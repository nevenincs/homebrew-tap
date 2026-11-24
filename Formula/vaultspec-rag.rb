class VaultspecRag < Formula
  desc "Hybrid dense and sparse semantic search for your docs and source code"
  homepage "https://github.com/nevenincs/vaultspec-rag"
  version "0.6.9"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-rag-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.6.9/vaultspec-rag-v0.6.9-aarch64-apple-darwin.tar.gz"
      sha256 "4db39e046075a5f709510c8b63fb1c9bd00f334ebb3d1eb63c394632f7e745a0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.6.9/vaultspec-rag-v0.6.9-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d0c967f7fc82f2e19cb9186c763278552817ad9f39bf7a7d9597d5137adf04f2"
    end

    on_arm do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.6.9/vaultspec-rag-v0.6.9-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2345797d93a680f21035194afdaefb26978bdf7864c557c67c3ce18bbcd87164"
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
