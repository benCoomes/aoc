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
  File.foreach(file) do |line|
    # part 2 solution here
  end
  :no_answer
end
