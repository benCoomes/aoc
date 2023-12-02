# frozen_string_literal:true

def parse_ranges(line)
  line.strip.split(',').map { |r| Range.new(*r.split('-')).to_a }
end

def part1(file)
  contains_count = 0
  File.foreach(file) do |line|
    s1, s2 = parse_ranges(line)
    contains_count += 1 if s1.difference(s2).empty? || s2.difference(s1).empty?
  end
  contains_count
end

def part2(file)
  contains_count = 0
  File.foreach(file) do |line|
    s1, s2 = parse_ranges(line)
    contains_count += 1 unless s1.intersection(s2).empty?
  end
  contains_count
end
