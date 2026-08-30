class VaultspecCore < Formula
  desc "Spec-driven development framework - vaultspec-core CLI and MCP server"
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.1.65"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-core-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.65/vaultspec-core-aarch64-apple-darwin"
      sha256 "e213864b986c5e4bbcdfea086b52a21cd786a1b37b39fdda8dc7e2a482ec4197"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.65/vaultspec-mcp-aarch64-apple-darwin"
        sha256 "a37a6789a602b8b29d9c457571080bb599e78347f28c6bcbab2a7b95c42b54f8"
      end
    end

    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.65/vaultspec-core-x86_64-apple-darwin"
      sha256 "c8b65abce67806343891741bfc52a1136c7f5708f2b757215dcef80e96f1ae6f"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.65/vaultspec-mcp-x86_64-apple-darwin"
        sha256 "006a48022e030662002240f80726ff699d41eae5fbc5e12c2bfd30098f3708a9"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.65/vaultspec-core-x86_64-unknown-linux-gnu"
      sha256 "58938014de9f62591a2af85f7527d5085131294733a4ed4c32445cecf449a1fc"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.65/vaultspec-mcp-x86_64-unknown-linux-gnu"
        sha256 "088427670f8e980693cd0b4916c3d057f20e3090751930c64420affb605d3f82"
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
