require 'openai'

class CommitAI
  def initialize
    @client = OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'])
  end

  def generate_commit_message(diff, message_style)
    prompt = if message_style == 'single'
               <<~PROMPT
                 This is the git diff: #{diff}

                 A git diff shows the changes made in a commit, where lines prefixed with a '+' indicate additions and lines prefixed with a '-' indicate deletions.

                 Please generate a **single-line** commit message that is concise and follows best practices.
                 **Do not include any extra text or formatting** like triple backticks (```) or code block delimiters.
                 Only return the commit message.
               PROMPT
             else
               <<~PROMPT
                 This is the git diff: #{diff}

                 A git diff shows the changes made in a commit, where lines prefixed with a '+' indicate additions and lines prefixed with a '-' indicate deletions.

                 Please generate a **multi-line** commit message that is clear, concise, and follows best practices.
                 The first line should be a short summary of the change.
                 The second line should be blank.
                 The following lines should provide additional details about the change and its purpose.
               PROMPT
             end

    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "You are a highly experienced senior software engineer specializing in Ruby on Rails projects. Your only task is to generate clear and concise git commit messages following best practices." },
          { role: "user", content: prompt }
        ],
        max_tokens: 150,
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

    puts "Choose commit message style: single-line (s) or multi-line (m): "
    message_style_input = STDIN.gets.chomp.downcase
    message_style = message_style_input == 'm' ? 'multi' : 'single'

    loop do
      commit_message = generate_commit_message(diff, message_style)
      puts "Generated Commit Message:\n#{commit_message}"
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
