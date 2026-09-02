class Newsrag < Formula
  desc "Local-first evidence retrieval for city hall PDFs"
  homepage "https://github.com/evcraddock/newsrag"
  url "https://github.com/evcraddock/newsrag/releases/download/v0.4.0/newsrag-0.4.0-macos-arm64.tar.gz"
  sha256 "70213e00b6e55de878ec2fed6457fc3febd90a418c700ac6e539140f08566b6d"
  license "MIT"

  depends_on arch: :arm64
  depends_on "ghostscript"
  depends_on macos: :sequoia
  depends_on "ocrmypdf"
  depends_on "qpdf"
  depends_on "sqlite"
  depends_on "tesseract"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"newsrag"
  end

  def caveats
    <<~EOS
      Configure an OpenAI-compatible embedding service before ingestion or vector search.
      See https://github.com/evcraddock/newsrag/blob/v#{version}/docs/embeddings.md
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/newsrag --version")

    data_dir = testpath/"data"
    output = shell_output("#{bin}/newsrag --data-dir #{data_dir} status --initialize")
    assert_match "summary: ok", output
    assert_path_exists data_dir/"newsrag.sqlite3"
  end
end
