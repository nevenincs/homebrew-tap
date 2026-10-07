class VaultspecCore < Formula
  desc "Decision-driven harness for coding agents, and humans."
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.3.3"
  license "MIT"

  livecheck do
    url :stable
    regex(Regexp.new("^vaultspec\\-core\\-v(\\d+(?:\\.\\d+)+)$", Regexp::IGNORECASE))
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.3.3/vaultspec-core-v0.3.3-aarch64-apple-darwin.tar.gz"
      sha256 "4c622a6f6949962cf59b86caed9b081bc8ca3eb508766315e51a7432de70988a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.3.3/vaultspec-core-v0.3.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "15fade1d237f898b9fa7b0e388c821f2418f35d5f9f769f763288025b6b049a5"
    end

    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.3.3/vaultspec-core-v0.3.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6488c5bf34867efa9acec735ee41eb3b216565a30c6cf8a60082e37c9219dfdc"
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
