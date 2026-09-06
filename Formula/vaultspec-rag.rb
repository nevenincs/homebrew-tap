class VaultspecRag < Formula
  desc "Hybrid dense and sparse semantic search for your docs and source code"
  homepage "https://github.com/nevenincs/vaultspec-rag"
  version "0.4.24"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-rag-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.24/vaultspec-rag-x86_64-unknown-linux-gnu"
      sha256 "4b8a02f9912cda8d41d8500dbe4bd2a64c3b01400f866e6c52f184a7cf51a7e8"

      resource "vaultspec-search-mcp" do
        url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.24/vaultspec-search-mcp-x86_64-unknown-linux-gnu"
        sha256 "c81741c55da58e9d2d57d8d2fc972ec8af97ae28a222e457d0635a18de021dd0"
      end
    end

    on_arm do
      url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.24/vaultspec-rag-aarch64-unknown-linux-gnu"
      sha256 "9429a0914f3e1342faf350339794979f568b5bbbded5596081b04b3fd194c54c"

      resource "vaultspec-search-mcp" do
        url "https://github.com/nevenincs/vaultspec-rag/releases/download/vaultspec-rag-v0.4.24/vaultspec-search-mcp-aarch64-unknown-linux-gnu"
        sha256 "6e5daa4ef9b84de9c52d82395ba6e410d802c36d68ae936a782f9730e761fb73"
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
