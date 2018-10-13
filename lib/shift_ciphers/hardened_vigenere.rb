module ShiftCiphers
  class HardenedVigenere < Vigenere

    def initialize(key, alphabet: Alphabets::DEFAULT, nonalphabet_char_strategy: :error)
      validate_key(key, alphabet)
      @key = key
      @alphabet = alphabet
      @nonalphabet_char_strategy = nonalphabet_char_strategy
    end

    protected

    def process(text, encrypting = true)
      offsets_stream = create_offsets_stream
      plaintext_char = ""
      text.each_char.reduce("") do |result, char|
        char_idx = alphabet.index(char)
        if !char_idx.nil?
          rel_offset = offsets_stream.next(plaintext_char) * (encrypting ? 1 : -1)
          result_char = alphabet[(char_idx + rel_offset) % alphabet.size]
          plaintext_char = encrypting ? char : result_char
          result << result_char
        else
          if nonalphabet_char_strategy == :dont_encrypt
            result << char
          else
            raise CipherError.new("Invalid input #{text.inspect}. Character #{char.inspect} is not in the alphabet: #{alphabet.inspect}")
          end
        end
      end
    end

    def create_offsets_stream
      RandomOffsetsStream.new(key, alphabet.size - 1)
    end


    class RandomOffsetsStream
      SEEDING_RAND_MAX = 2**32-1

      def initialize(key, max)
        @random = key.bytes.reduce(Random.new(0)) do |random, byte|
          Random.new(random.rand(SEEDING_RAND_MAX) ^ byte)
        end
        @max = max
      end

      def next(plaintext_char)
        plaintext_byte = plaintext_char.bytes.reduce(0){|a,e| a ^ e}
        @random = Random.new(@random.rand(SEEDING_RAND_MAX) ^ plaintext_byte)
        @random.rand(@max)
      end
    end
  end
end