class VaultspecRag < Formula
  desc "Hybrid dense and sparse semantic search for your docs and source code"
  homepage "https://github.com/nevenincs/vaultspec-rag"
  version "0.6.0"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-rag-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.6.0/vaultspec-rag-v0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "d11e496f84348298fea6185e79abe4cc6fd970d9c8316176b8e895703ddfd9b0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.6.0/vaultspec-rag-v0.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7337a02ea6a32efe5d27f0774fda355263a97b171f51253b9114d2b77b3f9d99"
    end

    on_arm do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.6.0/vaultspec-rag-v0.6.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "72c20c7805e6b23fb29190838f167538fe95ddd2d09f137165f4d17ba85a3d99"
    end
  end

  def install
    bin.install "vaultspec-rag"
    bin.install "vaultspec-search-mcp"
    bin.install "vaultspec-rag-monitor"
  end

  def caveats
    <<~EOS
      RAG backend requires NVIDIA CUDA or Apple silicon; there is no CPU mode.
      RAG commands download their runtime on first launch; need network and space.
      Monitor starts offline without Python, Node, Bun or an accelerator.
      Backend control needs the sibling RAG command or the daemon's Python runtime.
      Verify with: vaultspec-rag --version
      Verify with: vaultspec-rag-monitor --version
      Linux builds require glibc 2.39 or newer.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vaultspec-rag --version")
    assert_match version.to_s, shell_output("#{bin}/vaultspec-search-mcp --version")
    assert_match version.to_s, shell_output("#{bin}/vaultspec-rag-monitor --version")
  end
end
