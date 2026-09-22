class VaultspecRag < Formula
  desc "Hybrid dense and sparse semantic search for your docs and source code"
  homepage "https://github.com/nevenincs/vaultspec-rag"
  version "0.4.35"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-rag-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.35/vaultspec-rag-v0.4.35-aarch64-apple-darwin.tar.gz"
      sha256 "07e16ad120cbf4ba5a0a80cddab634f84edf9ee2100725d44976394d6f227546"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.35/vaultspec-rag-v0.4.35-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e04069e6677e4b39eee9197d107ccf434d40917d6daab31b8b4e3a37e4997794"
    end

    on_arm do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.35/vaultspec-rag-v0.4.35-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "84e04920742678bd2d04baadb4474e7519f3da2d538512979de710534328e9b2"
    end
  end

  def install
    bin.install "vaultspec-rag"
    bin.install "vaultspec-search-mcp"
  end

  def caveats
    <<~EOS
      Requires an NVIDIA GPU with CUDA, or Apple silicon; there is no CPU mode.
      First launch downloads the accelerator runtime; needs network and space.
      Same GPU torch build uv installs, pinned from this project's lock.
      Verify with: vaultspec-rag --version
      Linux builds require glibc 2.39 or newer.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vaultspec-rag --version")
  end
end
