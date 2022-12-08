# frozen_string_literal:true

def parse_trees(file)
  tree_rows = []
  tree_cols = []
  row_index = 0
  File.foreach(file) do |line|
    row = line.strip.chars.map(&:to_i)
    tree_rows << row
    row.each_with_index do |tree, col_index|
      col = tree_cols[col_index] ||= []
      col[row_index] = tree
    end
    row_index += 1
  end
  [tree_rows, tree_cols]
end

def part1(file)
  visible = 0
  tree_rows, tree_cols = parse_trees(file)

  tree_rows.each_with_index do |row, row_index|
    row.each_with_index do |tree, col_index|
      if tree > (tree_rows[row_index][0...col_index].max || -1) # left max
        visible += 1
      elsif tree > (tree_rows[row_index][col_index+1...].max || -1) # right max
        visible += 1
      elsif tree > (tree_cols[col_index][0...row_index].max || -1) # top_max
        visible += 1
      elsif tree > (tree_cols[col_index][row_index+1...].max || -1) # bottom_max
        visible += 1
      end
    end
  end
  visible
end

def part2(file)
  max_score = 0
  tree_rows, tree_cols = parse_trees(file)

  tree_rows.each_with_index do |row, row_index|
    next if row_index.zero? || row_index == tree_rows.size - 1

    row.each_with_index do |tree, col_index|
      next if col_index.zero? || col_index == row.size - 1

      to_right = tree_rows[row_index][col_index+1...]
      rvd = (to_right.index { |t| t >= tree } || to_right.size - 1) + 1

      to_left = tree_rows[row_index][0...col_index].reverse
      lvd = (to_left.index { |t| t >= tree } || to_left.size - 1) + 1

      above = tree_cols[col_index][0...row_index].reverse
      avd = (above.index { |t| t >= tree } || above.size - 1) + 1

      below = tree_cols[col_index][row_index+1...]
      bvd = (below.index { |t| t >= tree } || below.size - 1) + 1

      score = rvd * lvd * avd * bvd
      if score > max_score
        max_score = score
      end
    end
  end
  max_score
end
