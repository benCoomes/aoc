# frozen_string_literal:true

class Monkey
  attr_accessor :id, :inspect_count, :items

  def initialize(input)
    lines = input.split("\n")
    @id = lines[0].match(/Monkey (?<id>\d+):/)[:id]&.to_i
    @items = lines[1].match(/Starting items: (?<items>.*)/)[:items] \
      &.strip&.split(', ')&.map(&:to_i)
    exprs = lines[2].match(/Operation: new = old (?<expr>.*)/)[:expr] \
      &.strip&.split(' ')
    @val = exprs[1] == 'old' ? proc { |x| x } : proc { |_| exprs[1].to_i }
    @op = exprs[0] == '+' ? proc { |x| x + @val.call(x) } : proc { |x| x * @val.call(x) }
    @divisor = lines[3].match(/Test: divisible by (?<div>\d+)/)[:div]&.to_i
    @true_target = lines[4].match(/If true: throw to monkey (?<id>\d+)/)[:id]&.to_i
    @false_target = lines[5].match(/If false: throw to monkey (?<id>\d+)/)[:id]&.to_i
    @inspect_count = 0
  end

  def toss_items(other_monkies)
    @items.each do |i|
      i = (@op.call(i) / 3)
      @inspect_count += 1
      if i % @divisor == 0
        other_monkies[@true_target].add_item(i)
      else
        other_monkies[@false_target].add_item(i)
      end
    end
    @items = []
  end

  def add_item(item)
    @items.append(item)
  end
end

def paragraphs(input)
  input.split("\n\n")
end

def part1(file)
  input = File.read(file)
  pars = paragraphs(input)
  monkies = pars.map { |p| Monkey.new(p) }.map { |m| [m.id, m] }.to_h

  20.times do
    monkies.each_value do |m|
      m.toss_items(monkies)
    end
  end

  most_throws = monkies.values.map(&:inspect_count).sort.last(2)
  most_throws[0] * most_throws[1]
end

def part2(file)
  File.foreach(file) do |line|
    # part 2 solution here
  end
  :no_answer
end
