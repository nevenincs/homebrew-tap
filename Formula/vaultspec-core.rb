class VaultspecCore < Formula
  desc "Decision-driven harness for coding agents, and humans."
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.3.5"
  license "MIT"

  livecheck do
    url :stable
    regex(Regexp.new("^vaultspec\\-core\\-v(\\d+(?:\\.\\d+)+)$", Regexp::IGNORECASE))
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.3.5/vaultspec-core-v0.3.5-aarch64-apple-darwin.tar.gz"
      sha256 "99c14a505da07f89af2a8e92e81239af353268d13311588ca993d77863fbb938"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.3.5/vaultspec-core-v0.3.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bd0613c701f174eac6e4d76deaba2328984bd8cc48216ff7ad591a910555ec37"
    end

    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.3.5/vaultspec-core-v0.3.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "93d05924dcd866f563f7100850334d71a7d6800e911d224914c7b060ab4a46b7"
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
