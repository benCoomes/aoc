
def part1(file)
  sums = []
  elf = 0
  File.foreach(file) do |line|
    begin
      sums[elf] = 0 unless sums[elf]
      sums[elf] += Integer(line)
    rescue ArgumentError
      elf += 1
    end
  end
  sums.max
end

def part2(file)
  sums = []
  elf = 0
  File.foreach(file) do |line|
    begin
      sums[elf] = 0 unless sums[elf]
      sums[elf] += Integer(line)
    rescue ArgumentError
      elf += 1
    end
  end
  sums.sort.slice(-3, 3).sum
end