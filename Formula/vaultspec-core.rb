class VaultspecCore < Formula
  desc "Spec-driven development framework - vaultspec-core CLI and MCP server"
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.1.62"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-core-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.62/vaultspec-core-aarch64-apple-darwin"
      sha256 "8137ff715597585901e41e5ba5852bafe2d2d979fff444f91bfdd7187df9809f"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.62/vaultspec-mcp-aarch64-apple-darwin"
        sha256 "99919f9ac6ec2ad55cefb979424abd9e84a9c93601ec2c72aaa5c23b169a8ace"
      end
    end

    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.62/vaultspec-core-x86_64-apple-darwin"
      sha256 "ce5f4118233c60252515d4e384a690e921ee2ca3ffbdd29bf60a061ac96e269f"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.62/vaultspec-mcp-x86_64-apple-darwin"
        sha256 "3e2afd077c1cc78bae2574b43151715b45bf1a10ad0d7e38318086fa7004cadd"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.62/vaultspec-core-x86_64-unknown-linux-gnu"
      sha256 "910cb7887c31ec6ab1f1860af043a8fa9c648e6bbb2f9a82694976ac1149c9b5"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.62/vaultspec-mcp-x86_64-unknown-linux-gnu"
        sha256 "264f6c44c687e580d55e37c9dd39fdfe9c69d204405838caba1476d684c078b9"
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
