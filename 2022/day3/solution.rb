# frozen_string_literal:true

class Bagpack
  PRIORITIES = Array('a'..'z').concat(Array('A'..'Z')).zip(1..52).to_h

  attr_reader :items, :comp1, :comp2

  def initialize(items)
    @items = items.rstrip.chars
    @item_count = items.size
    split_index = @item_count / 2
    @comp1 = @items[0...split_index]
    @comp2 = @items[split_index..]
  end

  def items_in_both_compartments
    comp1 & comp2
  end

  def shared_items(other_packs = [])
    shared = items
    other_packs.each { |p| shared &= p.items }
    shared
  end

  def self.priority_sum(items)
    items.map { |i| PRIORITIES[i] }.sum
  end
end

def part1(file)
  sum = 0
  File.foreach(file) do |line|
    bp = Bagpack.new(line)
    sum += Bagpack.priority_sum(bp.items_in_both_compartments)
  end
  sum
end

def part2(file)
  packs = []
  File.foreach(file) do |line|
    packs << Bagpack.new(line)
  end

  groups = packs.each_slice(3).to_a
  sum = 0
  groups.each do |g|
    shared = g.first.shared_items(g.slice(1..))
    sum += Bagpack.priority_sum(shared)
  end
  sum
end
