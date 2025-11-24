class EraAgent < Formula
  desc "Secure code-execution runner with microVM orchestration using krunvm"
  homepage "https://github.com/BinSquare/ERA"
  url "https://github.com/BinSquare/ERA/releases/download/v1.0.1/era-agent-v1.0.1.tar.gz"
  version "1.0.1"
  sha256 "6e5f8bbc4dc79f8bb67d0b454571795abf98fda12d7512942a476063302e5347"
  license "MIT"

  depends_on "go" => :build
  depends_on "krunvm" => :recommended # Can work without but limited functionality
  depends_on "buildah" => :recommended # Can work without but limited functionality

  def install
    system "make", "agent"
    bin.install "agent"
  end

  def post_install
    state_dir = Pathname.new(ENV["HOME"]) / ".local" / "share" / "era-agent"
    state_dir.mkpath unless state_dir.directory?
  end

  def caveats
    <<~EOS
      ERA Agent installed successfully!

      Install required dependencies for full functionality:
        brew install krunvm buildah

      On macOS, krunvm needs a case-sensitive APFS volume:
        - Run: scripts/macos/setup.sh (from source directory)
        - Or create manually: diskutil apfs addVolume disk3 "Case-sensitive APFS" krunvm

      Quick start:
        agent vm temp --language python --cmd "python -c 'print(\"Hello from sandbox!\")'"

      For API server mode:
        agent server --addr :8080
    EOS
  end

  test do
    output = shell_output("#{bin}/agent --help 2>&1")
    assert_match "Agent CLI", output
    assert_match "vm", output
  end
end
