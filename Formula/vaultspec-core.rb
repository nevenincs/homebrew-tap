class VaultspecCore < Formula
  desc "Spec-driven development framework - vaultspec-core CLI and MCP server"
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.1.70"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-core-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.70/vaultspec-core-aarch64-apple-darwin"
      sha256 "82fcf0b71311a5458a5809cbf139133d85e5f96cb41fa7b044ff57f8f88db5ec"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.70/vaultspec-mcp-aarch64-apple-darwin"
        sha256 "c41274759a78656a86ebe2303b33c85a034b50dd87228aa7f71a9a4b2b7dadc6"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.70/vaultspec-core-x86_64-unknown-linux-gnu"
      sha256 "931973b77c6a6531c6a660a3549c51b28043169eeeedd53e0b44e0efbf965cb6"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.70/vaultspec-mcp-x86_64-unknown-linux-gnu"
        sha256 "f6bad7dfbf69313a18167af2690f1cd559a4115245376fe602fd815af94843bf"
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
