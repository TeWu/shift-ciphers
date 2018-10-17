RSpec.describe ShiftCiphers::HardenedVigenere do
  DEFAULT_KEY = "k#;j"

  it_behaves_like "shift cipher", ShiftCiphers::HardenedVigenere, DEFAULT_KEY

  context "using cipher's instance methods" do
    before(:example) { @cipher = ShiftCiphers::HardenedVigenere.new(DEFAULT_KEY) }

    specify "transcryption with one letter key, which is the first letter in the cipher's alphabet" do
      key = @cipher.alphabet[0]
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "14YH5!*jfbc$!GFNGL\"CVoW81Hwi>Uwd8o98xP1om"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with one letter key" do
      key = "e"
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "TI.}4zaY5[bF 18R(hTB(]{aqij:?AH@88Vt]iCzc"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with two letters key" do
      key = "o2"
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "Rtqd^u_.VDfiu0t1vzW\"OK_9NSE7?e.w!<(iIy#0H"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with long key" do
      key = "Morbi 02 cc ultrices sagittis augue blandit interdum. 55! Suspendisse vitae lacinia quam! Id sollicitudin neque. Donec suscipit iaculis nisl, nec mattis ante commodo in. Nullam facilisis felis nisl, ac lacinia lorem accumsan sed. Maecenas euismod lectus dolor, at aliquet dui condimentum sit amet. Mauris finibus, ante vitae euismod laoreet, turpis diam maximus leo, a tristique risus neque nec odio. Mauris mi erat, accumsan in tempus nec, bibendum eget nisi. Suspendisse non consequat metus, sed facilisis lorem. Vivamus tincidunt dignissim eros varius porttitor. Vestibulum quis pulvinar diam, vitae egestas dolor."
      plaintext  = "In rissus ex, nullam vel pretium laoreet." * 20
      ciphertext = "HhK7'+c#)t=LF)P-2:sNDZ<8L35TEMN/-59/(g$e-KQ@9GV>+_u+\"?GwEtT?;suu/a.%}P{$BlTX8BNH&iQjMQ_ob0KQg)1[>LMd^IVJ0^2gNu2&$&QT;Q9oV!oCN5,>,0[^l0U:97F02PmD67iMN;;yFR0B>!GLYHpW'5+{. \#@D4oa#syN<x{;aoi[nrVi@-B?'n+p-pp6lenc-Wpj#Oez}q$wPb15C@1Z.kLJuT-{1(5/=W{&U= 0l+u*Ngc9GK,q0>}a*xg7$'buS1hu[*]5BzT1-(u$:'oy>C&.*d3qmP-0=kr!Pn5:^<N^v^dpm9N=S^8l\"jBEP?(BB:=,As$_nZ<_e!Ag0V6yx:B1=YA]lACMT>Z$XdEAo5%_u^xuSp2nq@7m,)mPT*jV<vM1)K}2L^+of6oM4{?Ch=Ykf/c(v:yC7-)XA0cu>GRn[XxU8Fa*@;{&T}XT]a5&+sEPn6SQVErMwpA#E&Ow{j%p/pZl1Z#Qi5Y%)TEBIdU>tSw&;3!iI@F>A$A&5T+L>'Tf=]!MX8bCbio%.C@Au\"fQW,jii$c(q@E;l+w>BiP{W#cR 87hAX/o4\",k'S7B,aFm-9n4ct=3BoY5u>x?<MU#5UL2gZg:3PYr+h[A.$F:i*l+C.BG1,7j9a8A,}c[&tY3jm%d^&H4>I7@U,?in(r+?M0oprYF5qf3Zd8[RWk:hxufVH^$j{CBm}-e^B2(_,#SjxIG'4Bav(P=- QqwS9jTSJKU*VI]>_h]?z}%u9V1nuVhA(3^q]p\"U$ypJ=(btBgw_Z/m<^83jf<$z//I-y,b4qlKriIcOMr"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "decryption with wrong key" do
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = ";LVWgXVlvRnbhk7Rla]kjpbE{w/#pbX0X!m<M_],s"

      encrypted = @cipher.encrypt(plaintext)
      @cipher = ShiftCiphers::HardenedVigenere.new("wrong key")
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to_not eq plaintext
    end

    specify "set custom key" do
      plaintext                   = "In rissus ex, nullam vel pretium laoreet."
      ciphertext_with_default_key = ";LVWgXVlvRnbhk7Rla]kjpbE{w/#pbX0X!m<M_],s"
      ciphertext_with_custom_key  = "Q&]6Gwk0eii&6tLyhIk?Hg#TPO^@GZ.n5D/.e6-Ta"

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
      ciphertext_1 = ";LVWgXVlvRnbhk7Rla]kjpbE{w/#pbX0X!m<M_],s"
      ciphertext_2 = "Q&]6Gwk0eii&6tLyhIk?Hg#TPO^@GZ.n5D/.e6-Ta"

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