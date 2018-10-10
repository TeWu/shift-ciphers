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

    def decrypt(ciphertext)
      process(ciphertext, :decrypt)
    end

    protected

    def process(text, direction)
      text.each_char.reduce("") do |ciphertext, char|
        char_idx = alphabet.index(char)
        if !char_idx.nil?
          rel_offset = offset * (direction == :encrypt ? 1 : -1)
          ciphertext << alphabet[(char_idx + rel_offset) % alphabet.size]
        else
          if nonalphabet_char_strategy == :dont_encrypt
            ciphertext << char
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

      def decrypt(ciphertext, **options)
        self.new(**options).decrypt(ciphertext)
      end
    end

  end
end