# frozen_string_literal:true

require 'byebug'

OFFSET = 97
DEST = 'E'.bytes.first - OFFSET
START = 'S'.bytes.first - OFFSET
UNVISITED = 2**30

class Terrain
  def initialize(file)
    @map = []
    @visit_history = []
    @letters = []
    File.foreach(file) do |line|
      map_row = line.strip.each_byte.map { |b| b - OFFSET }.to_a 
      @letters << line.strip.chars
      @map << map_row
      @visit_history << Array.new(map_row.size, UNVISITED)
    end
    goal = end_pos # side-effect! memoize this when 'E'
    @map[goal[:y]][goal[:x]] = 'z'.bytes.first
  end

  def height_at(coord)
    @map[coord[:y]][coord[:x]]
  rescue
    byebug
  end

  def set_hist(coord)
    @visit_history[coord[:y]][coord[:x]] = coord[:moves]
  end

  def get_hist(coord)
    @visit_history[coord[:y]][coord[:x]]
  end

  def exists?(coord)
    coord[:x] >= 0 && coord[:y] >= 0 \
    && !@map[coord[:y]]&.send('[]', coord[:x]).nil?
  end

  def start_pos
    @start_pos ||= find_point(START)
  end

  def end_pos
    @end_pos ||= find_point(DEST)
  end

  def print_visits 
    puts @visit_history.map { |x| x.map { |i| i.to_s.rjust(3) }.join }
  end

  def print_map
    puts @map.map { |x| x.map { |i| i.to_s.rjust(3) }.join }
  end

  def visualize
    @visit_history.each_with_index do |row, y|
      line = ""
      row.each_with_index do |h, x|
        if h == UNVISITED
          line += @letters[y][x].rjust(3)
        else
          line += h.to_s.rjust(3)
        end
      end
      puts line
    end
  end

  def find_point(search)
    @map.each_with_index do |row, y|
      row.each_with_index do |val, x|
        return { x: x, y: y } if val == search
      end
    end
  end

  def shortest_path_len
    start = start_pos
    start[:moves] = 0
    set_hist(start)
    check_queue = adjacent(start)

    iter = 1
    shortest_path = -1
    until check_queue.empty?
      p "#{iter}: (#{check_queue.size})" if (iter % 100).zero?

      coord = check_queue.shift
      if get_hist(coord) > coord[:moves]
        set_hist(coord)
        check_queue.concat(candidates(coord))
      end

      iter += 1
      if check_queue.empty?
        byebug
        if get_hist(end_pos) == UNVISITED
          shortest_path = coord[:moves] + 1
        else
          shortest_path = get_hist(end_pos)
        end
      end
    end

    shortest_path
  end

  def adjacent(coord)
    left = { x: coord[:x] - 1, y: coord[:y], moves: coord[:moves] + 1 }
    right = { x: coord[:x] + 1, y: coord[:y], moves: coord[:moves] + 1 }
    up = { x: coord[:x], y: coord[:y] - 1, moves: coord[:moves] + 1 }
    down = { x: coord[:x], y: coord[:y] + 1, moves: coord[:moves] + 1 }
    [left, right, up, down].select { |c| exists?(c) }
  end

  def candidates(coord)
    results = []
    adj = adjacent(coord)
    adj.each do |cand|
      curr_height = height_at(coord)
      cand_height = height_at(cand)
      hist_moves = get_hist(cand)
      if curr_height + 1 >= cand_height && hist_moves > cand[:moves]
        results << cand
      end
    end
    results
  end
end

def part1(file)
  terrain = Terrain.new(file)
  terrain.shortest_path_len
  # currently broken :(
end

def part2(file)
  File.foreach(file) do |line|
    # part 2 solution here
  end
  :no_answer
end
