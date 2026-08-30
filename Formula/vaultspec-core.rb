class VaultspecCore < Formula
  desc "Spec-driven development framework - vaultspec-core CLI and MCP server"
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.1.67"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-core-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.67/vaultspec-core-aarch64-apple-darwin"
      sha256 "1a54e8005ec5848ad52b53185a2c2258641f1d65f3373280a4216e0bf50f65d3"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.67/vaultspec-mcp-aarch64-apple-darwin"
        sha256 "24a9ede208b7040a1e6ddb2b6b6befbb48d31c5a4a9c075df03501e52408f7eb"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.67/vaultspec-core-x86_64-unknown-linux-gnu"
      sha256 "d84081183fd3bdbffac42481e13900a9753332f4e4b2d586e3941926654ffb89"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.67/vaultspec-mcp-x86_64-unknown-linux-gnu"
        sha256 "f4a9c342e3068f5cbd7864b3e8056eac16ff8a83439f480634a429b80819e1a7"
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
