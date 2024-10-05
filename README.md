# [commit_ai](https://rubygems.org/gems/commit_ai)

Welcome to **commit_ai**, a Ruby gem designed to help developers generate meaningful commit messages automatically by analyzing staged git diffs using OpenAI's GPT models. Whether you're working with single-line or multi-line commits, CommitAi streamlines the commit process by providing concise, informative, and context-aware messages that follow best practices. With optional user input for change descriptions and smart minification of the git diff, this gem ensures clarity while preserving essential details in your commit messages.

![commit_ai demo](https://github.com/user-attachments/assets/b3727033-6db0-4d1b-b61b-f32ab9884adc)

## Installation

You can install **commit_ai** by running the following command in your terminal:

```bash
$ gem install commit_ai
```

## Usage

To use **CommitAi**, simply run the following command in your terminal after staging your changes:

```bash
$ commit_ai
```

### Setting Up OpenAI API Key

Before using the gem, set up your OpenAI API key by adding it to your environment variables. You can do this by running:

```bash
export OPENAI_ACCESS_TOKEN='your_openai_access_token_here'
```

This command sets the `OPENAI_ACCESS_TOKEN` variable for your current session. To make this change permanent, add the above line to your shell's configuration file (e.g., `.bashrc`, `.bash_profile`, or `.zshrc`).

This command will:
1. Analyze your staged changes (the `git diff --staged`).
2. Generate a suggested commit message based on the changes using OpenAI's GPT models.
3. Present the generated message, allowing you to accept, regenerate, or edit it as needed.

### Options During Execution:
- **y**: Accept the generated commit message and proceed with the commit.
- **r**: Regenerate a new commit message.
- **e**: Edit the generated commit message.
- **n**: Abort the commit.

## Development

To start contributing or testing locally, follow these steps:

1. **Clone the repository** and check out the code:
   ```bash
   $ git clone https://github.com/ken-narra/commit_ai.git
   $ cd commit_ai
   ```

2. **Install dependencies**:
   ```bash
   $ bin/setup
   ```

3. **Run an interactive console** for experimenting with the gem:
   ```bash
   $ bin/console
   ```

4. **To install the gem onto your local machine**, run:
   ```bash
   $ bundle exec rake install
   ```

5. **Release a new version**:
   - Update the version number in `lib/commit_ai/version.rb`.
   - Run the following command to create a git tag, push it to the repo, and upload the `.gem` file to RubyGems:
     ```bash
     $ bundle exec rake release
     ```

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/ken-narra/commit_ai](https://github.com/ken-narra/commit_ai). This project follows the Contributor Covenant [code of conduct](https://github.com/ken-narra/commit_ai/blob/master/CODE_OF_CONDUCT.md), and we expect all contributors to adhere to it in all project spaces.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CommitAi project's codebases, issue trackers, chat rooms, and mailing lists is expected to follow the [code of conduct](https://github.com/ken-narra/commit_ai/blob/master/CODE_OF_CONDUCT.md).
