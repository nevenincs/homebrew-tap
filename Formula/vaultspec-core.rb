class VaultspecCore < Formula
  desc "Spec-driven development framework - vaultspec-core CLI and MCP server"
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.1.69"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-core-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.69/vaultspec-core-aarch64-apple-darwin"
      sha256 "0fbb1910fcbdca375b3527d8bdc9732889cb80fd161f66452a0fdfbc1d553235"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.69/vaultspec-mcp-aarch64-apple-darwin"
        sha256 "d86c248c34aa79bc98aa74cd7a0a2447dab1dd01b585dd18cd0157d02d78d707"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.69/vaultspec-core-x86_64-unknown-linux-gnu"
      sha256 "90c227ce1508fdff8b51b2ac424e3000a049bfcf1a2bc75e9139357c1aa68773"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.69/vaultspec-mcp-x86_64-unknown-linux-gnu"
        sha256 "c4cd8eba3b8e10e93a87f192ff8b4787c063eadbb7fa8890aefd801d856b396d"
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
