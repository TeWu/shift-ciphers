module ShiftCiphers
  class Caesar
    DEFAULT_OFFSET = 13
    attr_accessor :offset, :alphabet, :nonalphabet_char_strategy

    def initialize(offset: DEFAULT_OFFSET, alphabet: Alphabets::DEFAULT, nonalphabet_char_strategy: :error)
      @offset = offset
      @alphabet = alphabet
      @nonalphabet_char_strategy = nonalphabet_char_strategy
    end

    def encrypt(plaintext)
      process(plaintext, :encrypt)
    end

    def decrypt(cyphertext)
      process(cyphertext, :decrypt)
    end

    protected

    def process(text, direction)
      text.each_char.reduce("") do |cyphertext, char|
        char_idx = alphabet.index(char)
        if !char_idx.nil?
          rel_offset = offset * (direction == :encrypt ? 1 : -1)
          cyphertext << alphabet[(char_idx + rel_offset) % alphabet.size]
        else
          if nonalphabet_char_strategy == :dont_encrypt
            cyphertext << char
          else
            raise CipherError.new("Character #{char.inspect} is not in the alphabet: #{alphabet.inspect}")
          end
        end
      end
    end

    class << self
      def encrypt(plaintext, **options)
        self.new(**options).encrypt(plaintext)
      end

      def decrypt(cyphertext, **options)
        self.new(**options).decrypt(cyphertext)
      end
    end

  end
end