# frozen_string_literal:true

class Directory
  attr_accessor :name, :parent

  def initialize(name, parent)
    @name = name
    @parent = parent
    @files = {}
    @children = {}
  end

  def add_file(fname, size)
    @total_size = nil
    @files[fname] = size.to_i
  end

  def add_subdir(name)
    @total_size = nil
    @children[name] ||= Directory.new(name, self)
  end

  def get_dir(name)
    if name == '..'
      @parent
    else
      @children[name]
    end
  end

  def total_size
    @total_size ||= @files.values.sum + @children.values.map(&:total_size).sum
  end

  def sum_of_sizes(max_size, sum)
    sum += total_size if total_size < max_size
    @children.each_value do |subdir|
      sum = subdir.sum_of_sizes(max_size, sum)
    end
    sum
  end

  def smallest_dir_greater_or_equal_to(size)
    child_candidates = @children.values.map { |sd| sd.smallest_dir_greater_or_equal_to(size) }
    choice = self
    child_candidates.each do |cc|
      if cc.total_size >= size && cc.total_size < choice.total_size
        choice = cc
      end
    end
    choice
  end

  def print(indent)
    puts "#{' ' * indent}- #{name} (dir)"

    indent += 3
    @children.each_value do |subdir|
      subdir.print(indent)
    end
    @files.each do |fname, size|
      puts "#{' ' * indent}- #{fname} (file, size=#{size})"
    end
  end
end

def parse_line(line)
  line = line.strip
  if line.start_with?('$ cd ')
    [:cd, line[5..]]
  elsif line.start_with?('$ ls')
    [:ls, nil]
  elsif line.start_with?('dir ')
    [:dir, line[4..]]
  elsif line.match?(/\A\d+ /)
    size, name = line.split(' ')
    [:file, {size: size, name: name}]
  else
    raise Error("Unexpected line: #{line}")
  end
end

def build_file_system(input_file)
  top_dir = nil
  current_dir = nil
  File.foreach(input_file) do |line|
    type, value = parse_line(line)
    case type
    when :cd
      if current_dir.nil?
        top_dir = Directory.new('/', nil)
        current_dir = top_dir
      else
        current_dir = current_dir.get_dir(value)
      end
    when :dir
      current_dir.add_subdir(value)
    when :file
      current_dir.add_file(value[:name], value[:size])
    end
  end
  top_dir
end

def part1(file)
  top_dir = build_file_system(file)
  top_dir.sum_of_sizes(100_000, 0)
end

def part2(file)
  top_dir = build_file_system(file)
  needed_space = 30_000_000
  free_space = 70_000_000 - top_dir.total_size
  must_delete = needed_space - free_space
  top_dir.smallest_dir_greater_or_equal_to(must_delete).total_size
end
