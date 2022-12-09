# frozen_string_literal:true

def move_tail!(head, tail)
  xdiff = head[:x] - tail[:x]
  ydiff = head[:y] - tail[:y]

  raise Error('Should not be!') if xdiff.abs > 1 && ydiff.abs > 1

  if xdiff.abs > 1
    if xdiff.positive?
      tail[:x] += 1
    else
      tail[:x] -= 1
    end
    tail[:y] = head[:y]
  elsif ydiff.abs > 1
    if ydiff.positive?
      tail[:y] += 1
    else
      tail[:y] -= 1
    end
    tail[:x] = head[:x]
  end
end

def move_rope(head, tail, visited, moves)
  moves.times do
    yield
    move_tail!(head, tail)
    visited[tail[:x]][tail[:y]] = true
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
  File.foreach(file) do |line|
    # part 2 solution here
  end
  :no_answer
end
