class VaultspecCore < Formula
  desc "Spec-driven development framework - vaultspec-core CLI and MCP server"
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.1.68"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-core-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.68/vaultspec-core-aarch64-apple-darwin"
      sha256 "730a0667131c16f64acdcf90541dc3d0ac56465fa02a9559bb635da73b519166"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.68/vaultspec-mcp-aarch64-apple-darwin"
        sha256 "23ef4cb9aafa6d762784267b5bf4463b276fc5cfb4392d760380a965d3e51c04"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.68/vaultspec-core-x86_64-unknown-linux-gnu"
      sha256 "b2a221624ecdc9c38f4fa5f47ab1228eef5c9468a452acb6fbbf3f051282ddbc"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.68/vaultspec-mcp-x86_64-unknown-linux-gnu"
        sha256 "00346ea7ef5e5a6992f04e62122e9453bdac4cfc52a24d3fb0c614d5d5d60e4f"
      end
    end
  end

  def install
    vendor = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"
    arch = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    triple = "#{arch}-#{vendor}"

    bin.install "vaultspec-core-#{triple}" => "vaultspec-core"

    resource("vaultspec-mcp").stage do
      bin.install "vaultspec-mcp-#{triple}" => "vaultspec-mcp"
    end
  end

  def caveats
    <<~EOS
      Installs vaultspec-core and vaultspec-mcp.
      First launch bootstraps the pinned runtime; needs network once.
      Verify with: vaultspec-core --version
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vaultspec-core --version")
  end
end
