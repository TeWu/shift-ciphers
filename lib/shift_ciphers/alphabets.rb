module ShiftCiphers
  module Alphabets
    NUMS = (0..9).to_a.map(&:to_s).join
    LOWER_ALPHA = ('a'..'z').to_a.join
    UPPER_ALPHA = ('A'..'Z').to_a.join
    ALPHA = LOWER_ALPHA + UPPER_ALPHA
    ALPHANUMS = NUMS + ALPHA
    SPECIAL = " !@#$%^&*()-_=+{}[];:'\",./<>?"

    DEFAULT = ALPHANUMS + SPECIAL
  end
end