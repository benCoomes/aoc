# frozen_string_literal:true

def part1(file)
  puts "part 1 (#{file}):"
  contains_count = 0
  File.foreach(file) do |line|
    s1, s2 = line.strip.split(',').map { |r| Range.new(*r.split('-')).to_a }
    if s1.difference(s2).empty?\
      || s2.difference(s1).empty?
      contains_count += 1
    end
  end
  puts contains_count
end

def part2(file)
  puts "part 2 (#{file}):"
  File.foreach(file) do |line|
    # part 2 solution here
  end
end

part1('input.txt')
part2('sample.txt')
