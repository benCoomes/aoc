# frozen_string_literal:true

class Rocks
  def initialize(file)
    # Lib idea - Rocks is a 'sparse array', which is a hash that contains only set values, and has defaults otherwise
    # Could be a useful class for printing, setting points, lines, etc.
    @rocks = Hash.new do |col_hash, x| 
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
        draw_rock_line(p1, p2)
      end
    end
  end

  def drop_sand_check_abyss
    pos = drop_sand
    pos[:y] < height
  end

  def height
    @height ||= @rocks.values.map { |col| col.select{ |_,v| v == :rock }.keys.max || 0 }.max
  end

  def print_map
    symbols = {rock: '#', air: '.', sand: 'o'}
    minx = @rocks.keys.min
    maxx = @rocks.keys.max
    draw_height = height + 1
    (0..draw_height).each do |y|
      (minx-1..maxx+1).each do |x|
        char = symbols[@rocks[x][y]]
        print char
      end
      puts ''
    end
  end

  private

  def drop_sand
    into_abyss = false
    stopped = false
    pos = { x: 500, y: 0 }

    until stopped || into_abyss
      down = @rocks[pos[:x]][pos[:y] + 1]
      if down == :air
        pos[:y] += 1
        into_abyss = true if pos[:y] > height
        next
      end

      left_down = @rocks[pos[:x] - 1][pos[:y] + 1]
      if left_down == :air
        pos[:x] -= 1
        pos[:y] += 1
        into_abyss = true if pos[:y] > height
        next
      end

      right_down = @rocks[pos[:x] + 1][pos[:y] + 1]
      if right_down == :air
        pos[:x] += 1
        pos[:y] += 1
        into_abyss = true if pos[:y] > height
        next
      end

      stopped = true
    end

    @rocks[pos[:x]][pos[:y]] = :sand
    pos
  end

  def draw_rock_line(p1, p2)
    xdiff = p1[:x] - p2[:x]
    ydiff = p1[:y] - p2[:y]
    raise 'Diagonal rock' unless xdiff.zero? || ydiff.zero?

    y = p1[:y]
    x = p1[:x]

    if xdiff.positive?
      (p2[:x]..p1[:x]).each { |x| @rocks[x][y] = :rock }
    elsif xdiff.negative?
      (p1[:x]..p2[:x]).each { |x| @rocks[x][y] = :rock }
    elsif ydiff.positive?
      (p2[:y]..p1[:y]).each { |y| @rocks[x][y] = :rock }
    elsif ydiff.negative?
      (p1[:y]..p2[:y]).each { |y| @rocks[x][y] = :rock }
    end
  end
end



def part1(file)
  rocks = Rocks.new(file)
  rocks.print_map
  count = 0
  while rocks.drop_sand_check_abyss && count < 10000 do
    count += 1
  end
  rocks.print_map
  count
end

def part2(file)
  File.foreach(file) do |line|
    # part 2 solution here
  end
  :no_answer
end
