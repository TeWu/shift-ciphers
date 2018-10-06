
module ShiftCipher
  ALPHABET = ((0..9).to_a.map(&:to_s) +
              ('a'..'z').to_a +
              ('A'..'Z').to_a
             ).join + " !@#$%^&*()-_=+{}[];:'\",./<>?"
end

module ShiftCipher
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

module ShiftCipher
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

#####################################################################
# var lowerReference = "abcdefghijklmnopqrstuvwxyz",
# upperReference = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
# function isalpha(e) { return /^[a-zA-Z]+$/.test(e) }
# function process(e, t, n) {
# if (void 0 === n && (n = 1), "string" != typeof e || "string" != typeof t) throw new Error("vignere: key word and phrase must be strings");
# if (!isalpha(e)) throw new Error("vignere: key word can only contain letters");
# e = e.toLowerCase();
# for (var i, a, r = t.length, o = e.length, s = 0, l = 0, c = ""; s < r; s++) isalpha(a = t[s]) ? (i = n > 0 ? lowerReference.indexOf(a.toLowerCase()) + lowerReference.indexOf(e[l]) : (i = lowerReference.indexOf(a.toLowerCase()) - lowerReference.indexOf(e[l])) < 0 ? 26 + i : i, i %= 26, c = -1 === lowerReference.indexOf(a) ? c + upperReference[i] : c + lowerReference[i], l = l + 1 === o ? 0 : l + 1) : c += a;
# return c
# }
# function cipher(e, t)   { return process(e, t) }
# function decipher(e, t) { return process(e, t, -1) }
#####################################################################

# https://rosettacode.org/wiki/Vigen%C3%A8re_cipher#Java
# https://rosettacode.org/wiki/Vigen%C3%A8re_cipher#Haskell
# https://rosettacode.org/wiki/Vigen%C3%A8re_cipher#TypeScript

caesar = ShiftCipher::Caesar.new
caesar_cyphertext = caesar.encrypt("ATTACKATDAWN")
p caesar_cyphertext
p caesar.decrypt(caesar_cyphertext)

key = "5ecr3t"
vigenere_cyphertext = ShiftCipher::Vigenere.encrypt("ATTACKATDAWN", key)
p key
p vigenere_cyphertext
p ShiftCipher::Vigenere.decrypt(vigenere_cyphertext, key)


# ------ specs ---------

describe ShiftCipher do
  it "works with short key" do
    key = "k3Y!"
    plaintext = "This is a simple test"
    cyphertext = ShiftCipher::Vigenere.encrypt(plaintext, key)
    expect(cyphertext).to eq "=k}0:l<yu#<;Gs;{:w_0N"
    expect(ShiftCipher::Vigenere.decrypt(cyphertext, key)).to eq plaintext
    expect(ShiftCipher::Vigenere.decrypt(cyphertext, "wrong key")).to_not eq plaintext
  end

  it "works with long key" do
    key = "Vee33eery lo00ng key this is inde333D"
    plaintext = "This is a simple test"
    cyphertext = ShiftCipher::Vigenere.encrypt(plaintext, key)
    expect(cyphertext).to eq "lvwv#wG>IxNGmpIuxNs 0"
    expect(ShiftCipher::Vigenere.decrypt(cyphertext, key)).to eq plaintext
    expect(ShiftCipher::Vigenere.decrypt(cyphertext, "wrong key")).to_not eq plaintext
  end

  it "works with custom alphabet" do
    key = "LEMON"
    plaintext = "ATTACKATDAWN"
    cyphertext = ShiftCipher::Vigenere.encrypt(plaintext, key, (?A..?Z).to_a.join)
    expect(cyphertext).to eq "LXFOPVEFRNHR"
    expect(ShiftCipher::Vigenere.decrypt(cyphertext, key, (?A..?Z).to_a.join)).to eq plaintext
    expect(ShiftCipher::Vigenere.decrypt(cyphertext, "WRONGKEY", (?A..?Z).to_a.join)).to_not eq plaintext
  end
end

