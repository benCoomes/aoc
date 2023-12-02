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
    @map[goal[:y]][goal[:x]] = 'z'.bytes.first - OFFSET
  end

  def height_at(coord)
    @map[coord[:y]][coord[:x]]
  rescue
    byebug
  end

  def points_at_height(height_char)
    int_height = height_char.bytes.first - OFFSET
    coords = []
    @map.each_with_index do |row, y|
      row.each_with_index do |h, x|
        coords << { x: x, y: y } if h == int_height
      end
    end
    coords
  end

  def first_col
    (0...@map.size).map { |ri| {x: 0, y: ri } }
  end

  def set_hist(coord)
    @visit_history[coord[:y]][coord[:x]] = coord[:moves]
  end

  def get_hist(coord)
    @visit_history[coord[:y]][coord[:x]]
  end

  def reset_hist
    @visit_history.each do |row|
      row.each_with_index do |_, i|
        row[i] = UNVISITED
      end
    end
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
    lines = ""
    @visit_history.each_with_index do |row, y|
      line = ""
      row.each_with_index do |h, x|
        if h == UNVISITED
          line += @letters[y][x].rjust(4)
        else
          line += h.to_s.rjust(4)
        end
      end
      lines += line + "\n"
    end
    print lines
    STDOUT.flush
  end

  def find_point(search)
    @map.each_with_index do |row, y|
      row.each_with_index do |val, x|
        return { x: x, y: y } if val == search
      end
    end
  end

  def shortest_path_len(start = nil)
    start ||= start_pos
    start[:moves] = 0
    set_hist(start)
    check_queue = adjacent(start)

    iter = 1
    shortest_path = -1
    until check_queue.empty?
      coord = check_queue.shift
      if get_hist(coord) > coord[:moves]
        set_hist(coord)
        check_queue.concat(candidates(coord))
      end

      iter += 1
      if check_queue.empty?
        if get_hist(end_pos) == UNVISITED
          shortest_path = UNVISITED
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
end

def part2(file)
  terrain = Terrain.new(file)
  # Hack! For some reason the algorithm is jumping from a -> c.
  # But, searching for 'b' in the input shows that only the first row contains valid starting points
  # (and the entire 1st row is a valid starting point)
  # I want to use 'points_at_height', but first_col will do.
  # TODO: why is the algoithm escaping from boxed in areas, like the one at {x:69, y:38} ?
  low_points = terrain.first_col
  min_len = UNVISITED

  low_points.each_with_index do |start, i|
    len = terrain.shortest_path_len(start)
    min_len = len if len < min_len
    terrain.reset_hist
  end
  min_len
end
