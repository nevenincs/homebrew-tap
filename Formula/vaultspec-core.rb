class VaultspecCore < Formula
  desc "Decision-driven harness for coding agents, and humans."
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.3.9"
  license "MIT"

  livecheck do
    url :stable
    regex(Regexp.new("^vaultspec\\-core\\-v(\\d+(?:\\.\\d+)+)$", Regexp::IGNORECASE))
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.3.9/vaultspec-core-v0.3.9-aarch64-apple-darwin.tar.gz"
      sha256 "cb0ef1ad699f0bf555c1cf6dd00fd304d7764a4c428975c144c69062611514d5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.3.9/vaultspec-core-v0.3.9-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a08c4329d202a3e1f6c5f04122874e21506482e8609a341be25de25a7325b5b8"
    end

    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.3.9/vaultspec-core-v0.3.9-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7a340f60744bc7d2b6c290e954c6bb3df5d5bdd7c713913b616ac0e77367a719"
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
