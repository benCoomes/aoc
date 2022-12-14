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

AOCTestCase.new(1, 'sample.txt', 13).run if test_sample
AOCTestCase.new(1, 'input.txt', 6087).run if test_input
AOCTestCase.new(2, 'sample2.txt', 36).run if test_sample
AOCTestCase.new(2, 'input.txt', 2493).run if test_input
