class VaultspecCore < Formula
  desc "Decision-driven harness for coding agents, and humans."
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.3.2"
  license "MIT"

  livecheck do
    url :stable
    regex(Regexp.new("^vaultspec\\-core\\-v(\\d+(?:\\.\\d+)+)$", Regexp::IGNORECASE))
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.3.2/vaultspec-core-v0.3.2-aarch64-apple-darwin.tar.gz"
      sha256 "2d00889a28a527b27aef491ba5453c14bdcd937b1e602921afce00aad488d255"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.3.2/vaultspec-core-v0.3.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "68b2cb675156386a1995debcccc52cac9c889dd0cc3afec6502d8692b16a36e8"
    end

    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.3.2/vaultspec-core-v0.3.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ce3b999224559dd5a4df9627ca51d4e8b187f49b1e0501c8dc8ccd873e5e9a24"
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
