class VaultspecCore < Formula
  desc "Decision-driven harness for coding agents, and humans."
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.2.4"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-core-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.2.4/vaultspec-core-v0.2.4-aarch64-apple-darwin.tar.gz"
      sha256 "094fbacc825f4a059cd61e7951c9b04740617c52f73961a0dfc08101b1f73f43"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.2.4/vaultspec-core-v0.2.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3349944123e6f0dc96906780f646150292819e17f9afdfb49ad69f315866fca2"
    end

    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.2.4/vaultspec-core-v0.2.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4f60c0b6a1957cb55d6b40319e187060b7f37bbcb11d2c9bdcb9cf13f8ad7635"
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
