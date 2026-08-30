class VaultspecCore < Formula
  desc "Spec-driven development framework - vaultspec-core CLI and MCP server"
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.1.73"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-core-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.73/vaultspec-core-aarch64-apple-darwin"
      sha256 "582e93d84e21de094c176cfd2f02b79093b8012c663942e8f35e03fff90c8a99"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.73/vaultspec-mcp-aarch64-apple-darwin"
        sha256 "de8b254bfc8f33bd27e903cbc84f64de399230cd4b425c757607aad8d2059c36"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.73/vaultspec-core-x86_64-unknown-linux-gnu"
      sha256 "420196472f4c41611cfdf88dbaac438508ac5da413f927766db71cc68127e15f"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.73/vaultspec-mcp-x86_64-unknown-linux-gnu"
        sha256 "41061a18c52bbe0d3c27b5e1d6266c7c6b7a2da62c29535001c7468e95cea881"
      end
    end

    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.73/vaultspec-core-aarch64-unknown-linux-gnu"
      sha256 "2b8699024d927682898cc6ad62f5f94da4afff42c9f564b5506d3fc9dbc44797"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.73/vaultspec-mcp-aarch64-unknown-linux-gnu"
        sha256 "5f014e3a761460b6dc2452f979075125426a9c3a43f548d9258e52d4089aca45"
      end
    end
  end

  def install
    vendor = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"
    arch = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    triple = "#{arch}-#{vendor}"

    bin.install "vaultspec-core-#{triple}" => "vaultspec-core"

    resource("vaultspec-mcp").stage do
      bin.install "vaultspec-mcp-#{triple}" => "vaultspec-mcp"
    end
  end

  def caveats
    <<~EOS
      Installs vaultspec-core and vaultspec-mcp.
      First launch bootstraps the pinned runtime; needs network once.
      Verify with: vaultspec-core --version
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vaultspec-core --version")
  end
end
