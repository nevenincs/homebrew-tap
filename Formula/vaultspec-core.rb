class VaultspecCore < Formula
  desc "Decision-driven harness for coding agents, and humans."
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.2.6"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-core-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.2.6/vaultspec-core-v0.2.6-aarch64-apple-darwin.tar.gz"
      sha256 "9387f0d3b69b6638352d93cf0131b7ca456dd8cc6fc0ae892373229722ad2593"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.2.6/vaultspec-core-v0.2.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b68c0b605bdd784a13f12e17b519f15f00325cacdef0b60706b3798592410912"
    end

    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.2.6/vaultspec-core-v0.2.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fdba2dddb2f47ac8fefc4b9680a47e84a38f0a07ede119f096b035840ed651f7"
    end
  end

  def install
    bin.install "vaultspec-core"
    bin.install "vaultspec-core-mcp"
  end

  def caveats
    <<~EOS
      Installs vaultspec-core and vaultspec-core-mcp.
      Each binary carries its own Python, Vaultspec and every dependency, so no launch needs a network.
      Upgrade through this channel: the binaries do not update themselves.
      Verify with: vaultspec-core --version
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vaultspec-core --version")
  end
end
