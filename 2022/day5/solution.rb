# frozen_string_literal:true

def parse_crate_line(line)
  line.chars.each_slice(4).map do |col|
    col.join.strip.gsub('[', '').gsub(']', '')
  end
end

def parse_move_line(line)
  words = line.split(' ')
  return unless words.size >= 6

  {
    move: words[1].to_i,
    from: words[3].to_i - 1,
    to: words[5].to_i - 1
  }
end

def parse_stacks_and_moves(file)
  crates = []
  moves = []
  parse_state = :parse_crates
  File.foreach(file) do |line|
    case parse_state
    when :parse_crates
      c = parse_crate_line(line)
      crates << c
      if c[0] == '1'
        parse_state = :parse_moves
        crates.pop
      end
    when :parse_moves
      m = parse_move_line(line)
      moves << m if m
    end
  end

  stacks = []
  crates.reverse_each do |row|
    row.each_with_index do |item, index|
      stacks[index] = [] unless stacks[index] # todo - refactor into hash with auto-initialize
      stacks[index].push item unless item.empty?
    end
  end

  [stacks, moves]
end

def part1(file)
  stacks, moves = parse_stacks_and_moves(file)
  moves.each do |move|
    move[:move].times do
      c = stacks[move[:from]].pop
      stacks[move[:to]].push(c)
    end
  end
  stacks.map(&:last).join
end

def part2(file)
  File.foreach(file) do |line|
    # part 2 solution here
  end
  :no_answer
end
