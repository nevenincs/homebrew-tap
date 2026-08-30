class VaultspecCore < Formula
  desc "Spec-driven development framework - vaultspec-core CLI and MCP server"
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.1.71"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-core-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.71/vaultspec-core-aarch64-apple-darwin"
      sha256 "bfcdebd80da61ac56ba807f1a0f56b1d9184204b648cfc1f488460f97c08b56e"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.71/vaultspec-mcp-aarch64-apple-darwin"
        sha256 "e585cd0fa3771b8d87978e918a160b641a53288caeb3869b9b2ead1fbda50fe4"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.71/vaultspec-core-x86_64-unknown-linux-gnu"
      sha256 "9f975677c3047dae5a068d52eaa69b6c34a74b766803e434387ecaf28d3dacbd"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.71/vaultspec-mcp-x86_64-unknown-linux-gnu"
        sha256 "850c8178db1ef30d306b0f05e1ea49d5cdb23fc5d9a5752928b489e650f574d1"
      end
    end

    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.71/vaultspec-core-aarch64-unknown-linux-gnu"
      sha256 "12c135fe360e11121b77478d60b0d5dd92113b95f538ce87416fca1fd34145db"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.71/vaultspec-mcp-aarch64-unknown-linux-gnu"
        sha256 "5b98009577d439984bf3444a482ab8be430feb86216a2a480fd706dea5e7ee0f"
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
