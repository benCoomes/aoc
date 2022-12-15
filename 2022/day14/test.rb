# frozen_string_literal:true

require './solution'
require '../../lib/microtest'
require 'byebug'

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

AOCTestCase.new(1, 'sample.txt', 24).run if test_sample
AOCTestCase.new(1, 'input.txt', 674).run if test_input
AOCTestCase.new(2, 'sample.txt', :unknown_answer).run if test_sample
AOCTestCase.new(2, 'input.txt', :unknown_answer).run if test_input
