# frozen_string_literal:true

def parse_ranges(line)
  line.strip.split(',').map { |r| Range.new(*r.split('-')).to_a }
end

def part1(file)
  puts "part 1 (#{file}):"
  contains_count = 0
  File.foreach(file) do |line|
    s1, s2 = parse_ranges(line)
    contains_count += 1 if s1.difference(s2).empty? || s2.difference(s1).empty?
  end
  puts contains_count
end

def part2(file)
  puts "part 2 (#{file}):"
  contains_count = 0
  File.foreach(file) do |line|
    s1, s2 = parse_ranges(line)
    contains_count += 1 unless s1.intersection(s2).empty?
  end
  puts contains_count
end

part1('input.txt')
part2('input.txt')
