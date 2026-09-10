class VaultspecCore < Formula
  desc "Decision-driven harness for coding agents, and humans."
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.2.0"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-core-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.2.0/vaultspec-core-aarch64-apple-darwin"
      sha256 "eab820a34f72ed40c4858c7d29626d8dd303647db800d3f82fdb32f7cac08ee4"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.2.0/vaultspec-mcp-aarch64-apple-darwin"
        sha256 "7678bc13d1785f6844e0aabc268eea5aeb9cf6224eece9347d6ee486a843c12c"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.2.0/vaultspec-core-aarch64-unknown-linux-gnu"
      sha256 "6ecfe277403eb23942df81c479cf2bf9227e419f9d5fb760fc47b6261a1aeb14"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.2.0/vaultspec-mcp-aarch64-unknown-linux-gnu"
        sha256 "aece5a04a771de26a3de661de4e9ea789ebfc5282e3b23287595d95cd71674f4"
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
      Each binary carries its own Python, Vaultspec and every dependency, so no launch needs a network.
      Upgrade through this channel: the binaries do not update themselves.
      Verify with: vaultspec-core --version
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vaultspec-core --version")
  end
end
