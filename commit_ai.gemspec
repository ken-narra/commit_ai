# frozen_string_literal: true

require_relative "lib/commit_ai/version"

Gem::Specification.new do |spec|
  spec.name          = "commit_ai"
  spec.version       = CommitAi::VERSION
  spec.authors       = ["Ken Vitug"]
  spec.email         = ["ken@narralabs.com"]

  spec.summary       = "A Ruby gem that utilizes OpenAI to create concise and meaningful commit messages based on the differences in your git changes."
  spec.description   = "Commit AI automates the generation of insightful one-liner commit messages by analyzing staged git diffs and the codebase with the help of OpenAI's advanced language models."
  spec.homepage      = "https://github.com/ken-narra/commit_ai"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ken-narra/commit_ai"
  spec.metadata["changelog_uri"] = "https://github.com/ken-narra/commit_ai/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir['lib/**/*', 'exe/*']
  spec.bindir        = "exe"
  spec.executables   = ['commit_ai']
  spec.require_paths = ["lib"]

  # Add dependencies
  spec.add_dependency 'ruby-openai'

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
