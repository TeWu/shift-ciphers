module ShiftCiphers
  ALPHABET = ((0..9).to_a.map(&:to_s) +
              ('a'..'z').to_a +
              ('A'..'Z').to_a
             ).join + " !@#$%^&*()-_=+{}[];:'\",./<>?"
end