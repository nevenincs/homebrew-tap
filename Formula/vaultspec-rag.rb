class VaultspecRag < Formula
  desc "Hybrid dense and sparse semantic search for your docs and source code"
  homepage "https://github.com/nevenincs/vaultspec-rag"
  version "0.4.12"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-rag-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.12/vaultspec-rag-x86_64-unknown-linux-gnu"
      sha256 "f4a5f1c28d7d668e67c7820b010b77735f1abd1925a126f736996b19380608b0"

      resource "vaultspec-search-mcp" do
        url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.12/vaultspec-search-mcp-x86_64-unknown-linux-gnu"
        sha256 "516c58d27eacc81a02f63ab55c78478a8f67ff0192ee48a1d226dc6950b1aaaf"
      end
    end

    on_arm do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.12/vaultspec-rag-aarch64-unknown-linux-gnu"
      sha256 "d84288efc122b43653d2462eaca1ee7e6203159cc83107b2df76328ae9786ed1"

      resource "vaultspec-search-mcp" do
        url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.12/vaultspec-search-mcp-aarch64-unknown-linux-gnu"
        sha256 "3f942ab8d511a235ea5b6f97688e0ddca85862067e25cfaf6e6ae9db010097f6"
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
