# frozen_string_literal:true

def part1(file)
  code_index = 0
  File.foreach(file) do |line|
    chars = line.chars
    code_index = chars.each_with_index do |_, index|
      next if index < 4

      start = index - 4
      code = line[start...index].chars
      break index if code.uniq.size == 4
    end
  end
  code_index
end

def part2(file)
  File.foreach(file) do |line|
    # part 2 solution here
  end
  :no_answer
end
