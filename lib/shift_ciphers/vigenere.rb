module ShiftCiphers
  class Vigenere
    attr_accessor :key, :alphabet, :nonalphabet_char_strategy

    def initialize(key, alphabet: Alphabets::DEFAULT, nonalphabet_char_strategy: :error)
      validate_key(key, alphabet)
      @key = key
      @alphabet = alphabet
      @nonalphabet_char_strategy = nonalphabet_char_strategy
      set_key_offsets
    end

    def key=(key)
      validate_key(key, alphabet)
      @key = key
      set_key_offsets
    end

    def alphabet=(alphabet)
      validate_key(key, alphabet)
      @alphabet = alphabet
    end

    def encrypt(plaintext)
      process(plaintext, :encrypt)
    end

    def decrypt(ciphertext)
      process(ciphertext, :decrypt)
    end

    protected

    def process(text, direction)
      key_offsets = @key_offsets.cycle
      text.each_char.reduce("") do |ciphertext, char|
        char_idx = alphabet.index(char)
        if !char_idx.nil?
          rel_offset = key_offsets.next * (direction == :encrypt ? 1 : -1)
          ciphertext << alphabet[(char_idx + rel_offset) % alphabet.size]
        else
          if nonalphabet_char_strategy == :dont_encrypt
            ciphertext << char
          else
            raise CipherError.new("Invalid input #{text.inspect}. Character #{char.inspect} is not in the alphabet: #{alphabet.inspect}")
          end
        end
      end
    end

    def validate_key(key, alphabet)
      key.each_char do |char|
        raise CipherError.new("Invalid key #{key.inspect}. Character #{char.inspect} is not in the alphabet: #{alphabet.inspect}") unless alphabet.include?(char)
      end
    end

    def set_key_offsets
      @key_offsets = @key.chars.map {|c| alphabet.index(c) }
    end

    class << self
      def encrypt(plaintext, key, **options)
        self.new(key, **options).encrypt(plaintext)
      end

      def decrypt(ciphertext, key, **options)
        self.new(key, **options).decrypt(ciphertext)
      end
    end

  end
end