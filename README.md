# homebrew-era-agent

Homebrew tap for ERA Agent (secure code-execution runner with microVM orchestration).

## Install

```bash
brew tap binsquare/era-agent
brew install era-agent
brew install krunvm buildah  # dependencies
```

For setup instructions (case-sensitive volume on macOS, env vars, troubleshooting), see the main project docs: https://github.com/BinSquare/ERA.

## Updating

1. Publish a new release in https://github.com/BinSquare/ERA (tag `vX.Y.Z`).
2. Update `Formula/era-agent.rb` with the new `url` and `sha256`.
3. `brew audit --new-formula Formula/era-agent.rb && brew install --build-from-source Formula/era-agent.rb`
4. Push to this tap.

## License

Same license as the main ERA project.
