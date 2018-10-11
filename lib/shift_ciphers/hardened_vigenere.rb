module ShiftCiphers
  class HardenedVigenere < Vigenere

    def initialize(key, alphabet: Alphabets::DEFAULT, nonalphabet_char_strategy: :error)
      validate_key(key, alphabet)
      @key = key
      @alphabet = alphabet
      @nonalphabet_char_strategy = nonalphabet_char_strategy
    end

    def create_offsets_stream
      RandomOffsetsStream.new(key, alphabet.size - 1)
    end


    class RandomOffsetsStream
      def initialize(key, max)
        @random = key.bytes.reduce(Random.new(0)) do |random, byte|
          Random.new(random.rand(max) + byte)
        end
        @max = max
      end

      def next
        @random.rand(@max)
      end
    end
  end
end