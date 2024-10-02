require 'openai'

class CommitAI
  def initialize
    @client = OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'])
  end

  def analyze_codebase
    codebase_summary = ""

    files = Dir.glob("**/*").reject { |f| f =~ %r{/(node_modules|\.git|\.DS_Store)} }

    files.each do |file|
      next unless File.file?(file)

      file_content = File.read(file)
      codebase_summary += "File: #{file}\n"
      codebase_summary += "Content Preview:\n#{file_content[0..500]}\n"
      codebase_summary += "\n---\n"
    end

    codebase_summary
  end

  def analyze_git_history
    git_history = `git log --pretty=format:"%h - %an, %ar: %s"`.strip
    if git_history.empty?
      "No commits found"
    else
      git_history
    end
  end

  def generate_commit_message(diff)
    codebase_summary = analyze_codebase
    git_history = analyze_git_history
    prompt = <<~PROMPT
      This is the codebase summary: #{codebase_summary}
      This is the git history: #{git_history}
      This is the git diff: #{diff}

      Please generate a **single-line** commit message that is concise and follows best practices.
      **Do not include any extra text or formatting** like triple backticks (```) or code block delimiters.
      Only return the commit message.
    PROMPT

    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "You are a Git commit message generator." },
          { role: "user", content: prompt }
        ],
        max_tokens: 50,
        temperature: 0.5
      }
    )

    response.dig("choices", 0, "message", "content").strip
  end

  def execute
    system("git add --all")
    diff = `git diff --staged`

    if diff.empty?
      puts "No changes to commit."
      return
    end

    loop do
      commit_message = generate_commit_message(diff)
      puts "Generated Commit Message: #{commit_message}"
      print "Do you want to proceed with the commit? (y/n) or regenerate (r): "
      response = STDIN.gets.chomp
      case response.downcase
      when 'y'
        system("git commit -m '#{commit_message}'")
        break
      when 'r'
        next
      else
        puts "Commit aborted."
        break
      end
    end
  end
end
