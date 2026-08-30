class VaultspecRag < Formula
  desc "Hybrid dense and sparse semantic search for your docs and source code"
  homepage "https://github.com/nevenincs/vaultspec-rag"
  version "0.4.20"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-rag-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.20/vaultspec-rag-x86_64-unknown-linux-gnu"
      sha256 "15bdb27813c5b2564d191f7ef1547a2f3b76c26b78564415f93ff8b8890a0bdb"

      resource "vaultspec-search-mcp" do
        url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.20/vaultspec-search-mcp-x86_64-unknown-linux-gnu"
        sha256 "2f6f82bcf5f6b6a12a3f8f589e4f1aca233d129c4a538fa5eb9b1b26787cbd2c"
      end
    end

    on_arm do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.20/vaultspec-rag-aarch64-unknown-linux-gnu"
      sha256 "9585d9f60f8cbe9b1cc2140139f6d15a3f4503afabc21ef135be3ae89f5d9360"

      resource "vaultspec-search-mcp" do
        url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.20/vaultspec-search-mcp-aarch64-unknown-linux-gnu"
        sha256 "b7d6f93e4eafd3577cacc39cb2b6cb9894602813d395d14dfae91114e72c9522"
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
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vaultspec-rag --version")
  end
end
