class VaultspecCore < Formula
  desc "Spec-driven development framework - vaultspec-core CLI and MCP server"
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.1.64"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-core-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.64/vaultspec-core-aarch64-apple-darwin"
      sha256 "ab7108c08e9cf6708c344465b00e52074bfd8ac593220c0cbe98fc257d168a4c"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.64/vaultspec-mcp-aarch64-apple-darwin"
        sha256 "49d7674b2695cfdb8f9c66860dd46fc97f27bdb3eec7243da8c5fe33c8eed2c0"
      end
    end

    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.64/vaultspec-core-x86_64-apple-darwin"
      sha256 "bbb0d0b86eac144ac44fdfd939c0c1dbdf860c92d7e8d47d47c6f4cf3fb6070d"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.64/vaultspec-mcp-x86_64-apple-darwin"
        sha256 "5251b16852d450da363b6a72d971463d8f9304b8798b4deebdb3d3a106499a18"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.64/vaultspec-core-x86_64-unknown-linux-gnu"
      sha256 "9207ce41c74cad7a74727cab01a98e27e65344d17b767aae2344bb8f48540a55"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.64/vaultspec-mcp-x86_64-unknown-linux-gnu"
        sha256 "f1665c332f8483fbae4a634d2904f5126afeb4c19b4a8467e6a3431586a5afd0"
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
