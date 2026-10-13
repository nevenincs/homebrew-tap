class VaultspecCore < Formula
  desc "Decision-driven harness for coding agents, and humans."
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.3.7"
  license "MIT"

  livecheck do
    url :stable
    regex(Regexp.new("^vaultspec\\-core\\-v(\\d+(?:\\.\\d+)+)$", Regexp::IGNORECASE))
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.3.7/vaultspec-core-v0.3.7-aarch64-apple-darwin.tar.gz"
      sha256 "3587227c933b7861800a0e348bde5fac3a5c5624d95f73decebb58ad197bff73"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.3.7/vaultspec-core-v0.3.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e1572b95bac917d988b7bfbeacac83abe300da541545afdf329a4f0d0377bdfa"
    end

    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.3.7/vaultspec-core-v0.3.7-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "06640c1937844d00250d47c52b9b3e079ff604be8afe6071685ad065bdd64c8f"
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
