sums = []
elf = 0
File.foreach('input.txt') do |line|
  begin
    sums[elf] = 0 unless sums[elf]
    sums[elf] += Integer(line)
  rescue ArgumentError
    elf += 1
  end
end

puts "The richest elf has #{sums.max} calories."

top3calories = sums.sort.slice(-3, 3).sum

puts "The top 3 elves have #{top3calories} calories."