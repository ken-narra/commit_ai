# frozen_string_literal: true

require_relative "lib/commit_ai/version"

Gem::Specification.new do |spec|
  spec.name          = "commit_ai"
  spec.version       = CommitAi::VERSION
  spec.authors       = ["Ken Vitug"]
  spec.email         = ["106139850+ken-narra@users.noreply.github.com"]

  spec.summary       = "A gem that generates a one-liner commit message using OpenAI based on git diffs."
  spec.description   = "Commit AI helps you generate meaningful one-liner commit messages automatically by analyzing your staged git diffs using OpenAI's GPT models."
  spec.homepage      = "https://github.com/ken-narra/commit_ai"  # Replace with your actual repo URL
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"  # Assuming you're pushing to RubyGems

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ken-narra/commit_ai"  # Replace with your repo URL
  spec.metadata["changelog_uri"] = "https://github.com/ken-narra/commit_ai/blob/main/CHANGELOG.md"  # Replace if applicable

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
