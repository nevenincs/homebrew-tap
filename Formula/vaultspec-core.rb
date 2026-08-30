class VaultspecCore < Formula
  desc "Spec-driven development framework - vaultspec-core CLI and MCP server"
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.1.66"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-core-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.66/vaultspec-core-aarch64-apple-darwin"
      sha256 "e101a204baec1416b4f1f84f4fba72e4054b82b983946bacf59f7341080c0418"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.66/vaultspec-mcp-aarch64-apple-darwin"
        sha256 "0605f2629f43732904ede78c8d6fc0f8fe05d695aa9202eaca796fab49a5fec3"
      end
    end

    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.66/vaultspec-core-x86_64-apple-darwin"
      sha256 "35c02a9e0f9507213f35085cc5d303279eb2f29fcc69ba6082415f1ea25ebd1d"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.66/vaultspec-mcp-x86_64-apple-darwin"
        sha256 "86cc39e6f54cd471525d653c2f7707e93859387762ef440f01ae00f52c58ce1d"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.66/vaultspec-core-x86_64-unknown-linux-gnu"
      sha256 "3f8a333b82218e7b62957d9cfb9fc2307eeda50cdcadfe091a5a8fa829a9f788"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.66/vaultspec-mcp-x86_64-unknown-linux-gnu"
        sha256 "2d4a4820a2ea43c4a97d8e9bcac1cf288a9de369213ef79f3d773f4503d497c5"
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
