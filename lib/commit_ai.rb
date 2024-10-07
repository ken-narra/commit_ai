require 'openai'
require 'colorize'

class CommitAI
  def initialize
    @client = OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'])
  end

  def execute
    system("git add --all")
    diff = `git diff -U10 --staged`

    if diff.empty?
      puts "No changes to commit. No need to proceed.".colorize(:red)
      return
    end

    puts "Please provide a brief description of the change made (optional):".colorize(:cyan)
    user_description = STDIN.gets.chomp

    puts "Do you want a multi-line commit message? (y/n) (optional):".colorize(:cyan)
    message_style_input = STDIN.gets.chomp.downcase
    message_style = message_style_input == 'y' ? 'multi' : 'single'

    commit_message = generate_commit_message(diff, message_style, user_description)
    loop do
      puts "\nGenerated Commit Message:\n#{commit_message}".colorize(:green)
      puts ""
      puts "Do you want to proceed with the commit? (y/n), regenerate (r), or edit (e):".colorize(:cyan)
      response = STDIN.gets.chomp
      case response.downcase
      when 'y'
        system("git commit -m '#{commit_message}'")
        puts "Commit successful!".colorize(:green)
        break
      when 'r'
        commit_message = generate_commit_message(diff, message_style, user_description)
        puts "Regenerating commit message...".colorize(:yellow)
        next
      when 'e'
        system("git commit -m '#{commit_message}' -e")
        puts "Commit successful after editing!".colorize(:green)
        break
      when 'n'
        puts "Commit aborted. No changes committed.".colorize(:red)
        break
      else
        puts "Invalid input. Please try again.".colorize(:red)
        puts ""
        next
      end
    end
  end

  private

  def generate_commit_message(diff, message_style, user_description)
    user_description_content = user_description.empty? ? '' : "Here is the user description of the change: \"#{user_description}\""
    prompt = if message_style == 'single'
               <<~PROMPT
                 This is the git diff: #{diff}

                 A git diff shows the changes made in a commit, where lines prefixed with a '+' indicate additions and lines prefixed with a '-' indicate deletions.

                 #{user_description_content}

                 Please generate a **single-line** commit message that is concise and follows best practices based on both the diff and user description.
                 **Do not include any extra text or formatting** like triple backticks (```) or code block delimiters.
                 Only return the commit message.
               PROMPT
             else
               <<~PROMPT
                 This is the git diff: #{diff}

                 A git diff shows the changes made in a commit, where lines prefixed with a '+' indicate additions and lines prefixed with a '-' indicate deletions.

                 #{user_description_content}

                 Please generate a **multi-line** commit message that is clear, concise, and follows best practices based on both the diff and user description.
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

  def minify_diff(diff, context_lines = 3)
    minified_diff = []
    current_context = []

    diff.lines.each do |line|
      if line.start_with?('+', '-')
        # Add the surrounding context before and after changes
        minified_diff.concat(current_context.last(context_lines))
        minified_diff << line
        current_context.clear  # Clear after using context lines
      else
        # Only keep a limited number of context lines
        current_context << line unless line.strip.empty?
        current_context = current_context.last(context_lines)  # Trim extra lines
      end
    end

    minified_diff.join
  end
end
