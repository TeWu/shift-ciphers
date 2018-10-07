module ShiftCiphers
  class Vigenere
    attr_accessor :key, :alphabet, :nonalphabet_char_strategy

    def initialize(key, alphabet: Alphabets::DEFAULT, nonalphabet_char_strategy: :error)
      validate_key(key, alphabet)
      @key = key
      @alphabet = alphabet
      @nonalphabet_char_strategy = nonalphabet_char_strategy
    end

    def key=(key)
      validate_key(key, alphabet)
      @key = key
    end

    def alphabet=(alphabet)
      validate_key(key, alphabet)
      @alphabet = alphabet
    end

    def encrypt(plaintext)
      process(plaintext, :encrypt)
    end

    def decrypt(cyphertext)
      process(cyphertext, :decrypt)
    end

    protected

    def validate_key(key, alphabet)
      key.each_char do |char|
        raise CipherError.new("Invalid key #{key.inspect}. Character #{char.inspect} is not in the alphabet: #{alphabet.inspect}") unless alphabet.include?(char)
      end
    end

    def process(text, direction)
      key_chars = key.chars.cycle
      text.each_char.reduce("") do |cyphertext, char|
        char_idx = alphabet.index(char)
        if !char_idx.nil?
          rel_offset = alphabet.index(key_chars.next) * (direction == :encrypt ? 1 : -1)
          cyphertext << alphabet[(char_idx + rel_offset) % alphabet.size]
        else
          if nonalphabet_char_strategy == :dont_encrypt
            cyphertext << char
          else
            raise CipherError.new("Invalid input #{text.inspect}. Character #{char.inspect} is not in the alphabet: #{alphabet.inspect}")
          end
        end
      end
    end

    class << self
      def encrypt(plaintext, key, **options)
        self.new(key, **options).encrypt(plaintext)
      end

      def decrypt(cyphertext, key, **options)
        self.new(key, **options).decrypt(cyphertext)
      end
    end

  end
end