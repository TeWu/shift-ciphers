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
      process(plaintext, true)
    end

    def decrypt(ciphertext)
      process(ciphertext, false)
    end

    protected

    def process(text, encrypting = true)
      text.each_char.reduce("") do |result, char|
        char_idx = alphabet.index(char)
        if !char_idx.nil?
          rel_offset = offset * (encrypting ? 1 : -1)
          result << alphabet[(char_idx + rel_offset) % alphabet.size]
        else
          if nonalphabet_char_strategy == :dont_encrypt
            result << char
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