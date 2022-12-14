# frozen_string_literal:true

def parse_rocks(file)
  # Lib Idea - Rocks is a 'sparse array', which is a hash that contains only set values, and has defaults otherwise
  # Could be a useful class for printing, setting points, lines, etc.
  rocks = Hash.new do |col_hash, x| 
    col_hash[x] = Hash.new do |row_hash, y| 
      row_hash[y] = :air
    end
  end

  File.foreach(file) do |line|
    pairs = line.split(' -> ').map do |c|
      x, y = c.split(',')
      { x: x.to_i, y: y.to_i }
    end.each_cons(2)

    pairs.each do |p1, p2|
      draw_rock_line(rocks, p1, p2)
    end
  end
  rocks
end

def draw_rock_line(rocks, p1, p2)
  xdiff = p1[:x] - p2[:x]
  ydiff = p1[:y] - p2[:y]
  raise 'Diagonal rock' unless xdiff.zero? || ydiff.zero?

  y = p1[:y]
  x = p1[:x]

  if xdiff.positive?
    (p2[:x]..p1[:x]).each { |x| rocks[x][y] = :rock }
  elsif xdiff.negative?
    (p1[:x]..p2[:x]).each { |x| rocks[x][y] = :rock }
  elsif ydiff.positive?
    (p2[:y]..p1[:y]).each { |y| rocks[x][y] = :rock }
  elsif ydiff.negative?
    (p1[:y]..p2[:y]).each { |y| rocks[x][y] = :rock }
  end
end

def print_rocks(rocks)
  minx = rocks.keys.min
  maxx = rocks.keys.max
  height = rocks.values.map { |col| col.keys.max }.max + 1
  (0..height).each do |y|
    (minx-1..maxx+1).each do |x|
      char = rocks[x][y] == :rock ? '#' : '.'
      print char
    end
    puts ''
  end
end

def part1(file)
  rocks = parse_rocks(file)
  print_rocks(rocks)
end

def part2(file)
  File.foreach(file) do |line|
    # part 2 solution here
  end
  :no_answer
end
