# frozen_string_literal:true

INTESRETING_CYCLES = [20, 60, 100, 140, 180, 220].freeze

def part1(file)
  sum = 0
  reg = 1
  cycle = 1

  File.foreach(file) do |line|
    op, val = line.split(' ')

    case op
    when "addx"
      # first part

      # during - check value
      if INTESRETING_CYCLES.include? cycle
        sum += cycle * reg
        p "#{cycle} * #{reg} = #{cycle * reg}"
      end

      # after - increment cycle
      cycle += 1

      # second part 

      # during - check value
      if INTESRETING_CYCLES.include? cycle
        sum += cycle * reg
        p "#{cycle} * #{reg} = #{cycle * reg}"
      end

      # after - increment cycle and reg
      cycle += 1
      reg += val.to_i
    when "noop"
      if INTESRETING_CYCLES.include? cycle
        sum += cycle * reg
        p "#{cycle} * #{reg} = #{cycle * reg}"
      end
      cycle += 1
    end
  end
  sum
end

def part2(file)
  File.foreach(file) do |line|
    # part 2 solution here
  end
  :no_answer
end
