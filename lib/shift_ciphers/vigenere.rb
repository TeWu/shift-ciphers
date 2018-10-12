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
      process(plaintext, true)
    end

    def decrypt(ciphertext)
      process(ciphertext, false)
    end

    protected

    def process(text, encrypting = true)
      offsets_stream = create_offsets_stream
      text.each_char.reduce("") do |result, char|
        char_idx = alphabet.index(char)
        if !char_idx.nil?
          rel_offset = offsets_stream.next * (encrypting ? 1 : -1)
          result << alphabet[(char_idx + rel_offset) % alphabet.size]
        else
          if nonalphabet_char_strategy == :dont_encrypt
            result << char
          else
            raise CipherError.new("Invalid input #{text.inspect}. Character #{char.inspect} is not in the alphabet: #{alphabet.inspect}")
          end
        end
      end
    end

    def set_key_offsets
      @key_offsets = @key.chars.map {|c| alphabet.index(c) }
    end

    def create_offsets_stream
      @key_offsets.cycle
    end

    def validate_key(key, alphabet)
      key.each_char do |char|
        raise CipherError.new("Invalid key #{key.inspect}. Character #{char.inspect} is not in the alphabet: #{alphabet.inspect}") unless alphabet.include?(char)
      end
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