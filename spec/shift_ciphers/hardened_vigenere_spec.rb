RSpec.describe ShiftCiphers::HardenedVigenere do
  DEFAULT_KEY = "k#;j"

  it_behaves_like "shift cipher", ShiftCiphers::HardenedVigenere, DEFAULT_KEY

  context "using cipher's instance methods" do
    before(:example) { @cipher = ShiftCiphers::HardenedVigenere.new(DEFAULT_KEY) }

    specify "transcryption with one letter key, which is the first letter in the cipher's alphabet" do
      key = @cipher.alphabet[0]
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "sJw/,{K{<Nm oDH97F7<=GKUl,Jd6+om<CYhKhHp."

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with one letter key" do
      key = "e"
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = ":;(vX%@vV3]<'-g),>x;_%k{\"$PBTgfY3i1+0v6T0"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with two letters key" do
      key = "o2"
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "(/L&!\"z;1%'v.WT/+FW:}y8<jE7k?_x}=$d)cV5(u"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with long key" do
      key = "Morbi 02 cc ultrices sagittis augue blandit interdum. 55! Suspendisse vitae lacinia quam! Id sollicitudin neque. Donec suscipit iaculis nisl, nec mattis ante commodo in. Nullam facilisis felis nisl, ac lacinia lorem accumsan sed. Maecenas euismod lectus dolor, at aliquet dui condimentum sit amet. Mauris finibus, ante vitae euismod laoreet, turpis diam maximus leo, a tristique risus neque nec odio. Mauris mi erat, accumsan in tempus nec, bibendum eget nisi. Suspendisse non consequat metus, sed facilisis lorem. Vivamus tincidunt dignissim eros varius porttitor. Vestibulum quis pulvinar diam, vitae egestas dolor."
      plaintext  = "In rissus ex, nullam vel pretium laoreet." * 20
      ciphertext = "\"z0pIfMQ-:/[ >bQT;lsBQ.0je0SrW/Ob:VMk]_BaAo5t@XdgCyf'Rk&2OW_Y 5fx:I a0b Tig/TB^70'o(36=UV?{$.-&Ak@Hb]Q{>iEpI&?. VBS,L[D,mqh]>o%?p^H1187)V?kIdiu5t\"-PbPNGl<@o3Hx7*-d3@2S]:$aAd2$H2oWkhL&@?HxLw:6_ocCY%2.Iy[1c j4}TFn8(N7)fV;1Q^[/<iCfDuBd,fk^oe0v}Cbn<b:G>*F:YgC;GX(OD4p$YFZmXPv8a%I1]qlapLN5tCr<U3yH@%r%^.OV1+PI(*K8Nh8!@Bwv7ax<[6;=-6YszW](0+Jw0c#<g5+deX0-LHo6:0sK>8&)^Dw1#4&lt4?.S,yd:($n$%k/$hkDAcRGBF#+_R@VH@u<H*)Iw?eE}ac}<%+5q(*u)rmD&4;-kKg:G1b$)2U@E5d csM}{f'E9&x$MD.0_QmI}sTD=3(:zC\"3>sUy=o!E1&Cw^KI(:$D89MFJDJ&NYqJ/P[3au>n(:e>:vG'c5(&\"zK@U#bG_P^]7Xpy/_Aba*Qe\"a 8a[icu{-C+</T697k5T?D:3hX9\"v>)UUMYhs+8Jj--Dw@.,k/4(h\"Y.$LFMcSnjR)fv>b0a_(mxCCy&$MQO<:1AQs=;Ig'L8Y715=H%T}<2]MNYux#XZXdMy(q8#c55!>Jcd/GqE7a6>Hq$<NtNz)8.+An A*%6-l{TXoo[Mn<?P:0n1 )2,0v[<smsmGdK9TgDiJm=7L//Xk*taV03%,FS<Fc'&(zw{L1,L02;f\"44;#w66/Yzjbs1K\"0Cj<2M]g*A7]N"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "decryption with wrong key" do
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "rXhInpbE-D.-#gceH7@y!jd,lL!rUxo_6d hnwsmB"

      encrypted = @cipher.encrypt(plaintext)
      @cipher = ShiftCiphers::HardenedVigenere.new("wrong key")
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to_not eq plaintext
    end

    specify "set custom key" do
      plaintext                   = "In rissus ex, nullam vel pretium laoreet."
      ciphertext_with_default_key = "rXhInpbE-D.-#gceH7@y!jd,lL!rUxo_6d hnwsmB"
      ciphertext_with_custom_key  = "J]pMI\"Btytv})%rk56/c6Z#mTt\"j5.(yZQlEuF1>0"

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
      ciphertext_1 = "rXhInpbE-D.-#gceH7@y!jd,lL!rUxo_6d hnwsmB"
      ciphertext_2 = "J]pMI\"Btytv})%rk56/c6Z#mTt\"j5.(yZQlEuF1>0"

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