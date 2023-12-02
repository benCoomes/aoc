# frozen_string_literal:true

def first_unique_block(input, min_size)
  chars = input.chars
  chars.each_with_index do |_, index|
    next if index < min_size

    start = index - min_size
    code = chars[start...index]
    break index if code.uniq.size == min_size
  end
end

def part1(file)
  input = File.read(file)
  first_unique_block(input, 4)
end

def part2(file)
  input = File.read(file)
  first_unique_block(input, 14)
end
