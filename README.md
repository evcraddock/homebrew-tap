# Evcraddock Homebrew Tap

## NewsRAG

Install the latest stable NewsRAG release and its native OCR dependencies on Apple Silicon macOS:

```bash
brew install evcraddock/tap/newsrag
```

Verify the installation:

```bash
newsrag --version
newsrag doctor
newsrag status --initialize
```

Ollama is optional. For local embeddings:

```bash
brew install ollama
brew services start ollama
ollama pull nomic-embed-text
```

Update or remove NewsRAG with:

```bash
brew update
brew upgrade newsrag
brew uninstall newsrag
```

See the [NewsRAG repository](https://github.com/evcraddock/newsrag) for configuration and usage documentation.
