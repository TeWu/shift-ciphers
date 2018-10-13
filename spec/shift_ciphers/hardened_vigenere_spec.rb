RSpec.describe ShiftCiphers::HardenedVigenere do
  DEFAULT_KEY = "k#;j"

  it_behaves_like "shift cipher", ShiftCiphers::HardenedVigenere, DEFAULT_KEY

  context "using cipher's instance methods" do
    before(:example) { @cipher = ShiftCiphers::HardenedVigenere.new(DEFAULT_KEY) }

    specify "transcryption with one letter key, which is the first letter in the cipher's alphabet" do
      key = @cipher.alphabet[0]
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = ".Z46\"faOsfBxXEUc1/vr%O6Y,%%}YC2k%E[9w=!&N"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with one letter key" do
      key = "e"
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = ";y/Jaff^$Eyk*!?I#%A:[-eqzJR$g}T,?'SQ)_{2R"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with two letters key" do
      key = "o2"
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "ILIQ5R<zXg^6'-Y?/;CV0vD8xEJEOiU$ Uld78HS?"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with long key" do
      key = "Morbi 02 cc ultrices sagittis augue blandit interdum. 55! Suspendisse vitae lacinia quam! Id sollicitudin neque. Donec suscipit iaculis nisl, nec mattis ante commodo in. Nullam facilisis felis nisl, ac lacinia lorem accumsan sed. Maecenas euismod lectus dolor, at aliquet dui condimentum sit amet. Mauris finibus, ante vitae euismod laoreet, turpis diam maximus leo, a tristique risus neque nec odio. Mauris mi erat, accumsan in tempus nec, bibendum eget nisi. Suspendisse non consequat metus, sed facilisis lorem. Vivamus tincidunt dignissim eros varius porttitor. Vestibulum quis pulvinar diam, vitae egestas dolor."
      plaintext  = "In rissus ex, nullam vel pretium laoreet." * 20
      ciphertext = ".:  :wa<NhUkQwF?/;CV0vD8xEJEOiU$ Uld78HS?rRBL!N_4a:%XXEUc1/vr%O6Y,%%}YC2k%E[9w=!&N.nbiU>{[%]:BkMWhc*3k%O6Y,%%}YC2k%E[9w=!&N.nbiU>{[%]:BkMWhc*3k%O6Y,%%}YC2k%E[9w=!&N.nbiU>{[%]:BkMWhc*3k%O6Y,%%}YC2k%E[9w=!&N.nbiU>{[%]:BkMWhc*3k%O6Y,%%}YC2k%E[9w=!&N.nbiU>{[%]:BkMWhc*3k%O6Y,%%}YC2k%E[9w=!&N.nbiU>{[%]:BkMWhc*3k%O6Y,%%}YC2k%E[9w=!&N.nbiU>{[%]:BkMWhc*3k%O6Y,%%}YC2k%E[9w=!&N.nbiU>{[%]:BkMWhc*3k%O6Y,%%}YC2k%E[9w=!&N.nbiU>{[%]:BkMWhc*3k%O6Y,%%}YC2k%E[9w=!&N.nbiU>{[%]:BkMWhc*3k%O6Y,%%}YC2k%E[9w=!&N.nbiU>{[%]:BkMWhc*3k%O6Y,%%}YC2k%E[9w=!&N.nbiU>{[%]:BkMWhc*3k%O6Y,%%}YC2k%E[9w=!&N.nbiU>{[%]:BkMWhc*3k%O6Y,%%}YC2k%E[9w=!&N.nbiU>{[%]:BkMWhc*3k%O6Y,%%}YC2k%E[9w=!&N.nbiU>{[%]:BkMWhc*3k%O6Y,%%}YC2k%E[9w=!&N.nbiU>{[%]:BkMWhc*3k%O6Y,%%}YC2k%E[9w=!&N.nbiU>{[%]:BkMWhc*3k%O6Y,%%}YC2k%E[9w=!&N.nbiU>{[%]:BkMWhc*3k%O6Y,%%}YC2k%E[9w=!&N"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "decryption with wrong key" do
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "\"S63Hj82q<A8%hJS8/vr%O6Y,%%}YC2k%E[9w=!&N"

      encrypted = @cipher.encrypt(plaintext)
      @cipher = ShiftCiphers::HardenedVigenere.new("wrong key")
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to_not eq plaintext
    end

    specify "set custom key" do
      plaintext                   = "In rissus ex, nullam vel pretium laoreet."
      ciphertext_with_default_key = "\"S63Hj82q<A8%hJS8/vr%O6Y,%%}YC2k%E[9w=!&N"
      ciphertext_with_custom_key  = "qU nC0R8Q-G+,^7^X6o\"J<!??/R1)g>2+$+9w=!&N"

      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext_with_default_key
      expect(decrypted).to eq plaintext

      @cipher.key = "My custom KEY"

      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext_with_custom_key
      expect(decrypted).to eq plaintext
    end

    specify "instantiate cipher with custom key, which contains letters outside of the cipher's alphabet" do
      expect { ShiftCiphers::HardenedVigenere.new("Mój") }.to raise_error(ShiftCiphers::CipherError, /^Invalid key/)
    end

    specify "set key to one which contains letters outside of the cipher's alphabet" do
      expect { @cipher.key = "Mój" }.to raise_error(ShiftCiphers::CipherError, /^Invalid key/)
    end

    specify "set alphabet to one which doesn't contains some letters used in cipher's key" do
      custom_alphabet = @cipher.alphabet.gsub(@cipher.key[@cipher.key.length / 2], "")
      expect { @cipher.alphabet = custom_alphabet }.to raise_error(ShiftCiphers::CipherError, /^Invalid key/)
    end
  end


  context "using cipher's class methods" do
    specify "get different ciphertexts by using different keys" do
      plaintext    = "In rissus ex, nullam vel pretium laoreet."
      ciphertext_1 = "\"S63Hj82q<A8%hJS8/vr%O6Y,%%}YC2k%E[9w=!&N"
      ciphertext_2 = "qU nC0R8Q-G+,^7^X6o\"J<!??/R1)g>2+$+9w=!&N"

      encrypted = ShiftCiphers::HardenedVigenere.encrypt(plaintext, DEFAULT_KEY)
      decrypted = ShiftCiphers::HardenedVigenere.decrypt(encrypted, DEFAULT_KEY)
      expect(encrypted).to eq ciphertext_1
      expect(decrypted).to eq plaintext

      key_2 = "My custom KEY"

      encrypted = ShiftCiphers::HardenedVigenere.encrypt(plaintext, key_2)
      decrypted = ShiftCiphers::HardenedVigenere.decrypt(encrypted, key_2)
      expect(encrypted).to eq ciphertext_2
      expect(decrypted).to eq plaintext
    end

    specify "use key which contains letters outside of the cipher's alphabet" do
      plaintext = "In rissus ex, nullam vel pretium laoreet."
      expect { ShiftCiphers::HardenedVigenere.encrypt(plaintext, "żart") }.to raise_error(ShiftCiphers::CipherError, /^Invalid key/)
    end

    specify "use alphabet which doesn't contains some letters used in cipher's key" do
      plaintext = "In rissus ex, nullam vel pretium laoreet."
      expect { ShiftCiphers::HardenedVigenere.encrypt(plaintext, "ala ma", alphabet: "algh ") }.to raise_error(ShiftCiphers::CipherError, /^Invalid key/)
    end
  end
end