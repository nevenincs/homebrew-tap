class VaultspecRag < Formula
  desc "Hybrid dense and sparse semantic search for your docs and source code"
  homepage "https://github.com/nevenincs/vaultspec-rag"
  version "0.4.17"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-rag-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.17/vaultspec-rag-x86_64-unknown-linux-gnu"
      sha256 "96aa4461acc79a74e3b2444a8b963578a5f7949ffd0d91d258d6390005068bbe"

      resource "vaultspec-search-mcp" do
        url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.17/vaultspec-search-mcp-x86_64-unknown-linux-gnu"
        sha256 "0aa2dea95b360802a1717344d38103413b37a109ed78cc5d6623367d42d201f3"
      end
    end

    on_arm do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.17/vaultspec-rag-aarch64-unknown-linux-gnu"
      sha256 "26de53767e8bf2c0dec1583503228ec0b200708d208c1b09dc5e0658951c2845"

      resource "vaultspec-search-mcp" do
        url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.17/vaultspec-search-mcp-aarch64-unknown-linux-gnu"
        sha256 "1f7b1ee0cf7df736446242a4c309f8d42006bfaee14979de9bb844a1d4b13e0c"
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
