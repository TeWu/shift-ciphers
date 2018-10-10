RSpec.describe ShiftCiphers::Vigenere do
  DEFAULT_KEY = "k#;j"

  it_behaves_like "shift cipher", ShiftCiphers::Vigenere, DEFAULT_KEY

  context "using cipher's instance methods" do
    before(:example) { @cipher = ShiftCiphers::Vigenere.new(DEFAULT_KEY) }

    specify "transcryption with one letter key, which is the first letter in the cipher's alphabet" do
      key = @cipher.alphabet[0]
      plaintext  = "In rissus ex, nullam vel pretium laoreet."

      @cipher = ShiftCiphers::Vigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq plaintext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with one letter key" do
      key = "e"
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "WB+FwGGIG+sL8+BIzzoA+Jsz+DFsHwIA+zoCFssH9"

      @cipher = ShiftCiphers::Vigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with two letters key" do
      key = "o2"
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "^p.tGuQwQ@Czi@LwJnyo.xCn.rPgRkSo.nyqPgCvj"

      @cipher = ShiftCiphers::Vigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with long key" do
      key = "Morbi 02 cc ultrices sagittis augue blandit interdum. 55! Suspendisse vitae lacinia quam! Id sollicitudin neque. Donec suscipit iaculis nisl, nec mattis ante commodo in. Nullam facilisis felis nisl, ac lacinia lorem accumsan sed. Maecenas euismod lectus dolor, at aliquet dui condimentum sit amet. Mauris finibus, ante vitae euismod laoreet, turpis diam maximus leo, a tristique risus neque nec odio. Mauris mi erat, accumsan in tempus nec, bibendum eget nisi. Suspendisse non consequat metus, sed facilisis lorem. Vivamus tincidunt dignissim eros varius porttitor. Vestibulum quis pulvinar diam, vitae egestas dolor."
      plaintext  = "In rissus ex, nullam vel pretium laoreet." * 20
      ciphertext = "1L>CA?sw?_q4o'QVDxoOxXoB]SUwV]EQ}Po.CzoQ8 QxJFVGVF1AsU%s2'=EO/JBy]RTs0NMP)z)JBqwQdS,<VsO01)=+Zi'IMxDDQ=NB',DRIHd1Z.IoA>GIV7 M]U]KCGW'wZU,FWGf)J+H+H)SUwV]EJ0z)APAAR8^,]Od?{YN'oTU{xGDGsO]X+A+KJG0FMO'f)yD+zD7 K]B]NQVG\"+H6_RQNvx\"?Jrgx-BsFwRw?'oSJGAR8fI+DLWU1F.zVlU,EO'kH]VIz0/EIL]GK,ysKFBHXhfP]U]COIVV+;41OMN'pE,NpP?j>oQLI\"2DDyF+sXd)J.E]NCST+s [xQYMKsOxIwv\"/No AQQ?'vCP8+DV-O]TLKSYGxFPm1P1IzAQ+2Bz_/PrLGp\"jvEPJG+PdfB>BLm?EE_ITm)K1DI)P+RDP?/OsFc1x]woLEIA09YB0>FKUMnx^!m/BRyDCO+2BJ,/DCQKIM1vD.NsHXnC,?Fv?HEE]zPm]P1GJBA\"q+}]UBAXK1P]ImGEIBWVVF}OAUUMOxsYi?,ZvMsQ?2DJ>SUwWGVhx}oQUwpXg_JxRMKU1R1z@c,xV'ysw\"p+Q]SBs0wKA?OkQ>rCOj(ijPJDK1s@+J6xRPOMsy+X+N)FJHWAW\")PqSF+pO5%A]U]KPXG>r!gV,zq\")+1XDz,CJGVw1R]OkC>zoFd%F)>IWCQ0xWKU?LPGDmE0ZrD,/OsTMIhxYyLFq+Vp)z]QAV?MC_ISc?,RDNvgxSsxxLBHWAW\")IDC>qCPh^A.>APn1{1zS4\",JvxsH]XwNxEFzLK1J]Nvi>oq0g"

      @cipher = ShiftCiphers::Vigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "decryption with wrong key" do
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "@<QKC2iNMA4QeAdNF.0F:54E:?hxN'kF:.0HL[4Mf"

      encrypted = @cipher.encrypt(plaintext)
      @cipher = ShiftCiphers::Vigenere.new("wrong key")
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to_not eq plaintext
    end

    specify "set custom key" do
      plaintext                   = "In rissus ex, nullam vel pretium laoreet."
      ciphertext_with_default_key = "@<QKC2iNMA4QeAdNF.0F:54E:?hxN'kF:.0HL[4Mf"
      ciphertext_with_custom_key  = "1VxDMUVSOxY-SjV1xPCP.R+%b,=M0uYO0Jw.-S_{t"

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
      expect { ShiftCiphers::Vigenere.new("Mój") }.to raise_error(ShiftCiphers::CipherError, /^Invalid key/)
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
      ciphertext_1 = "@<QKC2iNMA4QeAdNF.0F:54E:?hxN'kF:.0HL[4Mf"
      ciphertext_2 = "1VxDMUVSOxY-SjV1xPCP.R+%b,=M0uYO0Jw.-S_{t"

      encrypted = ShiftCiphers::Vigenere.encrypt(plaintext, DEFAULT_KEY)
      decrypted = ShiftCiphers::Vigenere.decrypt(encrypted, DEFAULT_KEY)
      expect(encrypted).to eq ciphertext_1
      expect(decrypted).to eq plaintext

      key_2 = "My custom KEY"

      encrypted = ShiftCiphers::Vigenere.encrypt(plaintext, key_2)
      decrypted = ShiftCiphers::Vigenere.decrypt(encrypted, key_2)
      expect(encrypted).to eq ciphertext_2
      expect(decrypted).to eq plaintext
    end

    specify "use key which contains letters outside of the cipher's alphabet" do
      plaintext = "In rissus ex, nullam vel pretium laoreet."
      expect { ShiftCiphers::Vigenere.encrypt(plaintext, "żart") }.to raise_error(ShiftCiphers::CipherError, /^Invalid key/)
    end

    specify "use alphabet which doesn't contains some letters used in cipher's key" do
      plaintext = "In rissus ex, nullam vel pretium laoreet."
      expect { ShiftCiphers::Vigenere.encrypt(plaintext, "ala ma", alphabet: "algh ") }.to raise_error(ShiftCiphers::CipherError, /^Invalid key/)
    end
  end
end