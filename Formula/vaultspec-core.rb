class VaultspecCore < Formula
  desc "Spec-driven development framework - vaultspec-core CLI and MCP server"
  homepage "https://github.com/nevenincs/vaultspec-core"
  version "0.1.72"
  license "MIT"

  livecheck do
    url :stable
    regex(/^vaultspec-core-v(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.72/vaultspec-core-aarch64-apple-darwin"
      sha256 "4fd9739cc013f4bf6bf31a5eda075d5d73a039166429799dbc9b6b04284a855e"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.72/vaultspec-mcp-aarch64-apple-darwin"
        sha256 "f8b0e15d47c59462b25c945dfbb7d9b4d449eba99921cf36689d9cc8bbc0da34"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.72/vaultspec-core-x86_64-unknown-linux-gnu"
      sha256 "3fe039ebbb84f76dc14cfd7ef2b8d5229db0bcd4acd0eaeb72b07a2cbd0e1979"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.72/vaultspec-mcp-x86_64-unknown-linux-gnu"
        sha256 "da8503027ccb11069b37b51a2c1f6f2fb0751bf6a281cda2c13cf674c969f721"
      end
    end

    on_arm do
      url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.72/vaultspec-core-aarch64-unknown-linux-gnu"
      sha256 "f3bde995f358e1646ae65fac2af51f10b37caa095060463d07c2df922b997355"

      resource "vaultspec-mcp" do
        url "https://github.com/nevenincs/vaultspec-core/releases/download/vaultspec-core-v0.1.72/vaultspec-mcp-aarch64-unknown-linux-gnu"
        sha256 "111958bf9202d9740c82390a7a607294c27be8b1b4f6e44f9e556bcc802ee30f"
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
