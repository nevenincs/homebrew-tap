class VaultspecCore < Formula
  desc "Spec-driven development framework - vaultspec-core CLI and MCP server"
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.1.63"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-core-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.63/vaultspec-core-aarch64-apple-darwin"
      sha256 "29d605eee14c435bd2103e8f098dca1a65853686a1ece3bbc6e75c56531cbc25"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.63/vaultspec-mcp-aarch64-apple-darwin"
        sha256 "7b5a150ad287eb01fbb1675fe9c6e86d2b9dabaabc17e8477cc01a2ff5fb8006"
      end
    end

    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.63/vaultspec-core-x86_64-apple-darwin"
      sha256 "defe90cf01671bdb5006c1064bd0067b7ba28e7bf7c07cf43f97c39704e35a2b"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.63/vaultspec-mcp-x86_64-apple-darwin"
        sha256 "61f3d7ef609cbda65e71fe66367bb7557d7b2c7df6247d33a48c22654a13752b"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.63/vaultspec-core-x86_64-unknown-linux-gnu"
      sha256 "11575f780a4195fb96938221cafa76f5311df9f4dde54a258be07cac97967e29"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.63/vaultspec-mcp-x86_64-unknown-linux-gnu"
        sha256 "44458b645ee9f1c837483bea5a0ed01c9f213b9751dac2d83e1bee62f7fe877b"
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
