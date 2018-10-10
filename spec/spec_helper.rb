require_relative 'config'
require_relative 'core_extensions'
require 'shift_ciphers'

LOREM_IPSUM_PARAGRAPH = "Donec dictum eros non lacus congue pellentesque. Nulla vitae nisl consequat orci luctus eleifend luctus eget diam. Morbi placerat ligula blandit? Rrutrum felis eget! Finibus urna! Nam non iaculis velit! Praesent eget urna vitae leo ultrices tristique sit amet sit amet sapien. Vivamus et fringilla est."

RSpec.shared_examples "shift cipher" do |cipher_class, *cipher_arguments|

  context "using cipher's instance methods" do
    before(:example) { @cipher = cipher_class.new(*cipher_arguments) }

    specify "short plaintext transcryption" do
      plaintext = "Attack at dawn!"
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(decrypted).to eq plaintext
    end

    specify "long plaintext transcryption" do
      plaintext = LOREM_IPSUM_PARAGRAPH * 300
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with custom alphabet" do
      plaintext = "zażółć gęślą jaźń"
      expect { @cipher.encrypt(plaintext) }.to raise_error(ShiftCiphers::CipherError)

      custom_alphabet = ShiftCiphers::Alphabets::LOWER_ALPHA + ShiftCiphers::Alphabets::SPECIAL + "ęółśążźćń"
      old_cipher_arguments = cipher_arguments.dup
      custom_cipher_arguments = old_cipher_arguments << old_cipher_arguments.extract_kwargs!.merge!(alphabet: custom_alphabet)
      @cipher = cipher_class.new(*custom_cipher_arguments)

      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(decrypted).to eq plaintext
    end

    specify "set custom alphabet" do
      plaintext = "zażółć gęślą jaźń"
      expect { @cipher.encrypt(plaintext) }.to raise_error(ShiftCiphers::CipherError)

      @cipher.alphabet = ShiftCiphers::Alphabets::LOWER_ALPHA + ShiftCiphers::Alphabets::SPECIAL + "ęółśążźćń"
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with nonalphabet_char_strategy set to :dont_encrypt" do
      plaintext  = "zażółć gęślą jaźń"
      expect { @cipher.encrypt(plaintext) }.to raise_error(ShiftCiphers::CipherError)

      old_cipher_arguments = cipher_arguments.dup
      custom_cipher_arguments = old_cipher_arguments << old_cipher_arguments.extract_kwargs!.merge!(nonalphabet_char_strategy: :dont_encrypt)
      @cipher = cipher_class.new(*custom_cipher_arguments)

      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(decrypted).to eq plaintext
      expect(encrypted.chars).to include(*%w[ ż ó ł ć ę ś ź ń ])
    end

    specify "set nonalphabet_char_strategy to :dont_encrypt" do
      plaintext  = "zażółć gęślą jaźn"
      expect { @cipher.encrypt(plaintext) }.to raise_error(ShiftCiphers::CipherError)

      @cipher.nonalphabet_char_strategy = :dont_encrypt
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(decrypted).to eq plaintext
      expect(encrypted.chars).to include(*%w[ ż ó ł ć ę ś ź ])
    end
  end


  context "using cipher's class methods" do
    before(:context) do
      @transcrypt = proc do |plaintext, args = cipher_arguments|
        encrypted = cipher_class.encrypt(plaintext, *args)
        decrypted = cipher_class.decrypt(encrypted, *args)
        [encrypted, decrypted]
      end
    end

    specify "short plaintext transcryption" do
      plaintext = "Attack at dawn!"
      encrypted, decrypted = @transcrypt.(plaintext)
      expect(decrypted).to eq plaintext
    end

    specify "long plaintext transcryption" do
      plaintext = LOREM_IPSUM_PARAGRAPH * 300
      encrypted, decrypted = @transcrypt.(plaintext)
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with custom alphabet" do
      plaintext = "zażółć gęślą jaźń"
      expect { @transcrypt.(plaintext) }.to raise_error(ShiftCiphers::CipherError)

      custom_alphabet = ShiftCiphers::Alphabets::LOWER_ALPHA + ShiftCiphers::Alphabets::SPECIAL + "ęółśążźćń"
      old_cipher_arguments = cipher_arguments.dup
      custom_cipher_arguments = old_cipher_arguments << old_cipher_arguments.extract_kwargs!.merge!(alphabet: custom_alphabet)

      encrypted, decrypted = @transcrypt.(plaintext, custom_cipher_arguments)
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with nonalphabet_char_strategy set to :dont_encrypt" do
      plaintext  = "zażółć gęślą jaźn"
      expect { @transcrypt.(plaintext) }.to raise_error(ShiftCiphers::CipherError)

      old_cipher_arguments = cipher_arguments.dup
      custom_cipher_arguments = old_cipher_arguments << old_cipher_arguments.extract_kwargs!.merge!(nonalphabet_char_strategy: :dont_encrypt)

      encrypted, decrypted = @transcrypt.(plaintext, custom_cipher_arguments)
      expect(decrypted).to eq plaintext
      expect(encrypted.chars).to include(*%w[ ż ó ł ć ę ś ź ])
    end
  end
end