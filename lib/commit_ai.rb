require 'openai'

class CommitAI
  def initialize
    @client = OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'])
  end

  def generate_commit_message(diff)
    prompt = <<~PROMPT
      This is the git diff: #{diff}

      Please generate a **single-line** commit message that is concise and follows best practices.
      **Do not include any extra text or formatting** like triple backticks (```) or code block delimiters.
      Only return the commit message.
    PROMPT

    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "You are a git commit message generator for ruby on rails projects." },
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
      print "Do you want to proceed with the commit? (y/n), regenerate (r), or edit (e): "
      response = STDIN.gets.chomp
      case response.downcase
      when 'y'
        system("git commit -m '#{commit_message}'")
        break
      when 'r'
        next
      when 'e'
        system("git commit -m '#{commit_message}' -e")
        break
      else
        puts "Commit aborted."
        break
      end
    end
  end
end
