# frozen_string_literal:true

# An advent of code test case
#   :part is a number (1 or 2, historically)
#   :input_file is the path to the input file
#   :answer is the expected answer, or :unknown_answer
class AOCTestCase
  attr_reader :part, :input_file, :answer

  def initialize(part, input_file, answer)
    @part = part
    @input_file = input_file
    @answer = answer
  end

  def name
    "part #{part} (#{input_file})"
  end

  def tested_method_name
    "part#{part}".to_sym
  end

  def run
    if File.exist?(input_file)
      solution = Object.send(tested_method_name, input_file)
      if answer == :unknown_answer
        report(solution)
      else
        assert(solution)
      end
    else
      report('file not found')
    end
  end

  private

  def report(solution)
    puts "#{name}: #{solution}"
  end

  def assert(solution)
    if answer != solution
      puts red("#{name}: Expected #{answer} but got #{solution}")
    else
      puts green("#{name}: Success! - #{solution}")
    end
  end

  # thanks to https://stackoverflow.com/questions/1489183/how-can-i-use-ruby-to-colorize-the-text-output-to-a-terminal
  def colorize(str, color_code)
    "\e[#{color_code}m#{str}\e[0m"
  end

  def red(str)
    colorize(str, 31)
  end

  def green(str)
    colorize(str, 32)
  end
end
