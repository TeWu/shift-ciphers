require 'shift_ciphers/shift_ciphers'

module ShiftCiphers
  class Caesar
    DEFAULT_OFFSET = 13
    attr_accessor :offset, :alphabet

    def initialize(offset = DEFAULT_OFFSET, alphabet = ALPHABET)
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
      def encrypt(plaintext, offset = DEFAULT_OFFSET, alphabet = ALPHABET)
        process(plaintext, offset, :encrypt, alphabet)
      end

      def decrypt(cyphertext, offset = DEFAULT_OFFSET, alphabet = ALPHABET)
        process(cyphertext, offset, :decrypt, alphabet)
      end

      protected

      def process(text, offset, direction = :encrypt, alphabet = ALPHABET)
        offset *= (direction == :encrypt ? 1 : -1)
        text.each_char.reduce("") do |cyphertext, char|
          char_idx = alphabet.index(char)
          cyphertext << alphabet[(char_idx + offset) % alphabet.size]
        end
      end
    end
  end
end