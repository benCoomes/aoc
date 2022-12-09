# frozen_string_literal:true

def move_tail!(head, tail)
  xdiff = head[:x] - tail[:x]
  ydiff = head[:y] - tail[:y]

  if ydiff.abs > 1
    tail[:y] += ydiff.positive? ? 1 : -1
    if xdiff.abs >= 1
      tail[:x] += xdiff.positive? ? 1 : -1
    end
  elsif xdiff.abs > 1
    tail[:x] += xdiff.positive? ? 1 : -1
    if ydiff.abs >= 1
      tail[:y] += ydiff.positive? ? 1 : -1
    end
  end
end

def move_rope(head, tail, visited, moves)
  moves.times do
    yield
    move_tail!(head, tail)
    visited[tail[:x]][tail[:y]] = true
  end
end

def move_long_rope!(knots, visited, moves)
  moves.times do
    yield
    knots.each_cons(2) do |h, t|
      move_tail!(h, t)
    end
    visited[knots[-1][:x]][knots[-1][:y]] = true
  end
end

def part1(file)
  visited = Hash.new { |h,k| h[k] = {} }
  head = { x: 0, y: 0 }
  tail = { x: 0, y: 0 }
  File.foreach(file) do |line|
    direction, moves = line.strip.split(' ')
    moves = moves.to_i

    case direction
    when 'U'
      move_rope(head, tail, visited, moves) { head[:y] += 1 }
    when 'R'
      move_rope(head, tail, visited, moves) { head[:x] += 1 }
    when 'L'
      move_rope(head, tail, visited, moves) { head[:x] -= 1 }
    when 'D'
      move_rope(head, tail, visited, moves) { head[:y] -= 1 }
    end
  end
  visited.map { |_, v| v.keys.count }.sum
end

def part2(file)
  visited = Hash.new { |h,k| h[k] = {}}
  knots = Array.new(10) { |i| {x: 0, y: 0}}
  File.foreach(file) do |line|
    direction, moves = line.strip.split(' ')
    moves = moves.to_i

    case direction
    when 'U'
      move_long_rope!(knots, visited, moves) { knots[0][:y] += 1 }
    when 'R'
      move_long_rope!(knots, visited, moves) { knots[0][:x] += 1 }
    when 'L'
      move_long_rope!(knots, visited, moves) { knots[0][:x] -= 1 }
    when 'D'
      move_long_rope!(knots, visited, moves) { knots[0][:y] -= 1 }
    end
  end
  visited.map { |_, v| v.keys.count }.sum
end
