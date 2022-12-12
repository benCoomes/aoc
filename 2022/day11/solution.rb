# frozen_string_literal:true

require 'prime'

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


class PrimeMonkey
  attr_accessor :id, :inspect_count, :items

  def initialize(input)
    lines = input.split("\n")
    @id = lines[0].match(/Monkey (?<id>\d+):/)[:id]&.to_i
    @items = lines[1].match(/Starting items: (?<items>.*)/)[:items] \
       &.strip&.split(', ')&.map { |str_num| FactorNum.new(str_num.to_i) }
    exprs = lines[2].match(/Operation: new = old (?<expr>.*)/)[:expr] \
    &.strip&.split(' ')
    @val = exprs[1] == 'old' ? :self : exprs[1].to_i
    @op = \
      if exprs[0] == '*'
        if @val == :self
          proc { |factor_num| factor_num.square! }
        else
          proc { |factor_num| factor_num.multiply!(@val) }
        end
      else
        proc { |factor_num| factor_num.add!(@val) }
      end
    @divisor = lines[3].match(/Test: divisible by (?<div>\d+)/)[:div]&.to_i
    @true_target = lines[4].match(/If true: throw to monkey (?<id>\d+)/)[:id]&.to_i
    @false_target = lines[5].match(/If false: throw to monkey (?<id>\d+)/)[:id]&.to_i
    @inspect_count = 0
  end

  def toss_items(other_monkies)
    @items.each do |i|
      @op.call(i)
      @inspect_count += 1
      if i.divisible_by?(@divisor)
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

def part2(file)
  input = File.read(file)
  pars = paragraphs(input)
  monkies = pars.map { |p| PrimeMonkey.new(p) }.map { |m| [m.id, m] }.to_h

  start = Time.now
  1_000.times do |i|
    puts "#{i}: #{Time.now - start}" if (i % 20).zero?
    monkies.each_value do |m|
      m.toss_items(monkies)
    end
  end

  monkies.each_value { |m| puts "#{m.id}: #{m.inspect_count}" }

  most_throws = monkies.values.map(&:inspect_count).sort.last(2)
  most_throws[0] * most_throws[1]
end

class DivCacheNum
  # tried this - too slow, over 1 min to get past 1000
  def initialize(num)
    @value = num
    @divisor_cache = {}
  end

  def divisible_by?(divisor)
    if @divisor_cache.key?(divisor)
      @divisor_cache[divisor]
    else
      @divisor_cache[divisor] = (@value % divisor).zero?
    end
  end

  def multiply!(num)
    @value *= num
    @divisor_cache[num] = true
  end

  def add!(int_num)
    @value += int_num
    if @divisor_cache[int_num]
      @divisor_cache = {}
      @divisor_cache[int_num] = true
    else
      @divisor_cache = {}
    end
  end

  def square!
    @value *= @value
  end
end


POSSIBLE_DIVISORS = [2, 3, 5, 11, 13, 17, 19].freeze
class FactorNum
  # this was fast enough, but wrong. Problem is addition didn't reset the factors.
  def initialize(int_num)
    @factors = Prime.prime_division(int_num).to_h
    @div_check_factors = @factors.clone
  end

  def divisible_by?(prime)
    @div_check_factors.key?(prime)
  end

  def multiply!(prime)
    if @factors.key?(prime)
      @factors[prime] += 1
    else
      @factors[prime] = 1
      @div_check_factors[prime] = 1
    end
  end

  def add!(int_num)
    # addition should destroy the factors, but doesn't. 
    # too expensive to recompute for large numbers,
    # but without using factors, multiplication and squares (I think) are too expensive.
    value = Prime.int_from_prime_division(@factors.to_a)
    value += int_num
    @div_check_factors = {}
    POSSIBLE_DIVISORS.each do |d|
      @div_check_factors[d] = 1 if (value % d).zero?
    end
  end

  def square!
    @factors.each { |k, v| @factors[k] = v + 1 }
  end
end