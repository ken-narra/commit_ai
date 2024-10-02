require_relative '../commit_ai'

namespace :commit_ai do
  desc "Generate commit message using OpenAI and commit"
  task :generate_commit do
    commit_ai = CommitAI.new
    commit_ai.execute
  end
end
