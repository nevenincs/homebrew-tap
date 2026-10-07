class VaultspecCore < Formula
  desc "Decision-driven harness for coding agents, and humans."
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.3.4"
  license "MIT"

  livecheck do
    url :stable
    regex(Regexp.new("^vaultspec\\-core\\-v(\\d+(?:\\.\\d+)+)$", Regexp::IGNORECASE))
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.3.4/vaultspec-core-v0.3.4-aarch64-apple-darwin.tar.gz"
      sha256 "effff0c1fa0903b89dec30188d7f447aa3d849f7751cd0fdd321858fb70b26e3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.3.4/vaultspec-core-v0.3.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1a0d38aa2ee5cd3227457e271475ca7ec5a33b4b22c4b8c5c139ede6357da12a"
    end

    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.3.4/vaultspec-core-v0.3.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "daabdadebcec47d9e91a01ad405878b69e27472077eaa600b65f98468ca1c0f1"
    end
  end

  def install
    bin.install "vaultspec-core"
    bin.install "vaultspec-core-mcp"
  end

  def caveats
    "Installs vaultspec-core and vaultspec-core-mcp.\nEach binary carries its own Python, Vaultspec and every dependency, so no launch needs a network.\nUpgrade through this channel: the binaries do not update themselves.\nVerify with: vaultspec-core --version\n"
  end

  test do
    assert_match version.to_s, shell_output(bin.to_s + "/vaultspec-core --version")
  end
end
