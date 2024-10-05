# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.8] - 2024-10-05
### Added
- Added a feature that prompts the user to provide a brief description of the change, which is then used along with the `git diff` to generate more accurate and meaningful commit messages.
- Introduced an option for users to select between single-line and multi-line commit messages, incorporating both the `git diff` and the user-provided description for clarity.
- Added support for "minifying" the `git diff` output by limiting unchanged context lines around the actual changes, making the diff more concise while retaining necessary context for accurate commit messages.

### Fixed
- Improved clarity in the user prompts for selecting commit message style and finalizing commit actions.
- Enhanced commit message generation with context about both the `git diff` and the user's input, resulting in more meaningful and concise commit messages.

### Improved
- Refined OpenAI prompts to ensure that commit messages are concise, human-like, and incorporate both technical changes from `git diff` and the user's intent.
- Optimized the `git diff` output by trimming unnecessary surrounding context, showing only a limited number of unchanged lines around modifications to enhance readability and reduce noise.

## [0.1.0] - 2024-10-03
### Added
- Initial release of the `commit_ai` gem.
- Automatically generates meaningful one-liner commit messages based on staged git diffs using OpenAI's GPT models.
- Command-line interface (CLI) for generating and committing messages interactively (`commit_ai`).
- Support for regenerating commit messages if needed.
- Integration with OpenAI's GPT models for analyzing code diffs and generating summaries.
