module RPS
  class Item
    ITEM_TO_OUTCOME = {
      rock: { rock: :draw, paper: :lose, scissor: :win },
      paper: { rock: :win, paper: :draw, scissor: :lose },
      scissor: { rock: :lose, paper: :win, scissor: :draw }
    }.freeze

    OUTCOME_TO_ITEM_TYPE = {
      rock: { win: :paper, draw: :rock, lose: :scissor },
      paper: { win: :scissor, draw: :paper, lose: :rock },
      scissor: { win: :rock, draw: :scissor, lose: :paper }
    }

    POINTS_FOR_OUTCOME = {
      win: 6,
      draw: 3,
      lose: 0
    }.freeze

    POINTS_FOR_TYPE = {
      rock: 1,
      paper: 2,
      scissor: 3
    }.freeze

    ITEM_TYPE_FOR = {
      A: :rock,
      X: :rock,
      B: :paper,
      Y: :paper,
      C: :scissor,
      Z: :scissor
    }.freeze

    OUTCOME_FOR = {
      X: :lose,
      Y: :draw,
      Z: :win
    }.freeze

    attr_reader :type

    def self.from_symbol(sym)
      Item.new(ITEM_TYPE_FOR[sym])
    end

    def initialize(type)
      @type = type
    end

    def points_against(other)
      POINTS_FOR_OUTCOME[ITEM_TO_OUTCOME[@type][other.type]]
    end

    def choice_for_result(result)
      Item.new(OUTCOME_TO_ITEM_TYPE[@type][result])
    end

    def inherrent_worth
      POINTS_FOR_TYPE[@type]
    end
  end
end

def part1(file)
  total_score = 0
  File.foreach(file) do |line|
    opp, you = line.split(' ').map { |x| RPS::Item.from_symbol(x.to_sym) } 
    score = you.points_against(opp) + you.inherrent_worth
    total_score += score
  end
  total_score
end

def part2(file)
  total_score = 0
  File.foreach(file) do |line|
    opp, result = line.split(' ')
    opp = RPS::Item.from_symbol(opp.to_sym)
    result = RPS::Item::OUTCOME_FOR[result.to_sym]
    you = opp.choice_for_result(result)
    total_score += you.points_against(opp) + you.inherrent_worth
  end
  total_score
end
