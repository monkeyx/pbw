require 'pbw/utils/polynomial'
require 'pbw/utils/dice'
require 'pbw/utils/chance'

module StringExtensions
  def dice
    ::Pbw::Utils::Dice.read(self)
  end

  def roll
    dice.roll
  end

  def chance
    ::Pbw::Utils::Chance.read(self)
  end

  def success?
    chance.success?
  end

  def is_number?
    true if Float(self) rescue false
  end

  def pluralize_if(quantity)
    return pluralize if quantity == 0 || quantity > 1
    self
  end

end

class String
  include StringExtensions
end