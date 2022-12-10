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


def print_screen(cycle, reg)
  pos = (cycle-1) % 40
  pixel = ([reg-1, reg, reg+1].include? pos) ? '#' : ' '
  print pixel
  if cycle % 40 == 0
    puts "\n"
  end
end

def part2(file)
  sum = 0
  reg = 1
  cycle = 1

  File.foreach(file) do |line|
    op, val = line.split(' ')

    case op
    when "addx"
      # first part

      # during - check pos & draw
      print_screen(cycle, reg)

      # after - increment cycle
      cycle += 1

      # second part 

      # during - check pos & draw
      print_screen(cycle, reg)

      # after - increment cycle and reg
      cycle += 1
      reg += val.to_i
    when "noop"
      # during - check pos & draw
      print_screen(cycle, reg)
      cycle += 1
    end
  end
  :no_answer
end
