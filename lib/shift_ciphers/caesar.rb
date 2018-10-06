require 'shift_ciphers/alphabets'

module ShiftCiphers
  class Caesar
    DEFAULT_OFFSET = 13
    attr_accessor :offset, :alphabet

    def initialize(offset = DEFAULT_OFFSET, alphabet = Alphabets::DEFAULT)
      @offset = offset
      @alphabet = alphabet
    end

    def encrypt(plaintext)
      self.class.encrypt(plaintext, offset, alphabet)
    end

    def decrypt(cyphertext)
      self.class.decrypt(cyphertext, offset, alphabet)
    end

    class << self
      def encrypt(plaintext, offset = DEFAULT_OFFSET, alphabet = Alphabets::DEFAULT)
        process(plaintext, offset, :encrypt, alphabet)
      end

      def decrypt(cyphertext, offset = DEFAULT_OFFSET, alphabet = Alphabets::DEFAULT)
        process(cyphertext, offset, :decrypt, alphabet)
      end

      protected

      def process(text, offset, direction = :encrypt, alphabet = Alphabets::DEFAULT)
        offset *= (direction == :encrypt ? 1 : -1)
        text.each_char.reduce("") do |cyphertext, char|
          char_idx = alphabet.index(char)
          cyphertext << alphabet[(char_idx + offset) % alphabet.size]
        end
      end
    end
  end
end