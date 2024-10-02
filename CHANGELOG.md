# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2024-10-3
### Added
- Initial release of the `commit_ai` gem.
- Automatically generates meaningful one-liner commit messages based on staged git diffs using OpenAI's GPT models.
- Command-line interface (CLI) for generating and committing messages interactively (`commit_ai`).
- Support for regenerating commit messages if needed.
- Integration with OpenAI's GPT models for analyzing code diffs and generating summaries.
