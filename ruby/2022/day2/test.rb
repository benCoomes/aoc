# frozen_string_literal:true

require './solution'
require '../../lib/microtest'

AOCTestCase.new(1, 'sample.txt', 15).run
AOCTestCase.new(1, 'input.txt', 11_386).run
AOCTestCase.new(2, 'sample.txt', 12).run
AOCTestCase.new(2, 'input.txt', 13_600).run
