class VaultspecRag < Formula
  desc "Hybrid dense and sparse semantic search for your docs and source code"
  homepage "https://github.com/nevenincs/vaultspec-rag"
  version "0.4.21"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-rag-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.21/vaultspec-rag-x86_64-unknown-linux-gnu"
      sha256 "45738c18cc07eb9cb04f0d1d3677a51992ac7dc072d3040cf34c9117bba34836"

      resource "vaultspec-search-mcp" do
        url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.21/vaultspec-search-mcp-x86_64-unknown-linux-gnu"
        sha256 "e6b6937a62c8ea71a17819781a5d4b0ff58fabef31607067b3ce89325f44089d"
      end
    end

    on_arm do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.21/vaultspec-rag-aarch64-unknown-linux-gnu"
      sha256 "6ec7d8d87abff7fe2db0a162ac22a7dafdd51eafa4dcf4c12e2cdbb190b98234"

      resource "vaultspec-search-mcp" do
        url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.21/vaultspec-search-mcp-aarch64-unknown-linux-gnu"
        sha256 "ca58517c85b3a8dc37a23352f9d91e0a9d63f98afec137cff9e954beb795a55d"
      end
    end
  end

  def install
    vendor = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"
    arch = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    triple = "#{arch}-#{vendor}"

    bin.install "vaultspec-rag-#{triple}" => "vaultspec-rag"

    resource("vaultspec-search-mcp").stage do
      bin.install "vaultspec-search-mcp-#{triple}" => "vaultspec-search-mcp"
    end
  end

  def caveats
    <<~EOS
      Requires an NVIDIA GPU with a working CUDA driver; there is no CPU mode.
      First launch downloads the CUDA runtime; needs network once, and space.
      Same GPU torch build uv installs, pinned from this project's lock.
      Verify with: vaultspec-rag --version
      Linux builds require glibc 2.28 or newer.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vaultspec-rag --version")
  end
end
