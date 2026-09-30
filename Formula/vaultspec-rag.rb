class VaultspecRag < Formula
  desc "Hybrid dense and sparse semantic search for your docs and source code"
  homepage "https://github.com/nevenincs/vaultspec-rag"
  version "0.5.3"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-rag-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.5.3/vaultspec-rag-v0.5.3-aarch64-apple-darwin.tar.gz"
      sha256 "9648292cb371999bd46213ed7335c42a6f8265af6f65fbf3207d1489b0652372"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.5.3/vaultspec-rag-v0.5.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "af8674b1bd27d45c906d397cebe3ac048805157a2060d5b619673d0204a8936c"
    end

    on_arm do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.5.3/vaultspec-rag-v0.5.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2851d107d50c0df40a3a6822a539309ebdb8d6dbd34773b5f19a0591b236e5b3"
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
