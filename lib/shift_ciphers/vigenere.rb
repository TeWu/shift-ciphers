require 'shift_ciphers/shift_ciphers'

module ShiftCiphers
  class Vigenere
    attr_accessor :key, :alphabet

    def initialize(key, alphabet = ALPHABET)
      @key = key
      @alphabet = alphabet
    end

    def encrypt(plaintext)
      self.class.encrypt(plaintext, key, alphabet)
    end

    def decrypt(cyphertext)
      self.class.decrypt(cyphertext, key, alphabet)
    end

    class << self
      def encrypt(plaintext, key, alphabet = ALPHABET)
        process(plaintext, key, :encrypt, alphabet)
      end

      def decrypt(cyphertext, key, alphabet = ALPHABET)
        process(cyphertext, key, :decrypt, alphabet)
      end

      protected

      def process(text, key, direction = :encrypt, alphabet = ALPHABET)
        key_chars = key.chars.cycle
        text.each_char.reduce("") do |cyphertext, char|
          char_idx = alphabet.index(char)
          offset = alphabet.index(key_chars.next) * (direction == :encrypt ? 1 : -1)
          cyphertext << alphabet[(char_idx + offset) % alphabet.size]
        end
      end
    end
  end
end