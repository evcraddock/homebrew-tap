class Newsrag < Formula
  desc "Local-first evidence retrieval for city hall PDFs"
  homepage "https://github.com/evcraddock/newsrag"
  url "https://github.com/evcraddock/newsrag/releases/download/v0.3.0/newsrag-0.3.0-macos-arm64.tar.gz"
  sha256 "239a897c6c3d5c23fd57d7204d81ae6511d3109e3ef56a421a4538fddeb56279"
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
      Ollama is optional. To use local embeddings:

        brew install ollama
        brew services start ollama
        ollama pull nomic-embed-text
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
