# frozen_string_literal:true

require './solution'
require '../../lib/microtest'

test_sample = false
test_input = false
ARGV.each do |a|
  case a
  when '-s'
    test_sample = true
  when '-i'
    test_input = true
  end
end

if !test_sample && !test_input
  test_sample = true
  test_input = true
end

AOCTestCase.new(1, 'sample.txt', 95_437).run if test_sample
AOCTestCase.new(1, 'input.txt', 1_792_222).run if test_input
AOCTestCase.new(2, 'sample.txt', 24_933_642).run if test_sample
AOCTestCase.new(2, 'input.txt', 1_112_963).run if test_input
