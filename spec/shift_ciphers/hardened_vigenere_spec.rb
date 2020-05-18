RSpec.describe ShiftCiphers::HardenedVigenere do
  DEFAULT_KEY = "k#;j"

  it_behaves_like "shift cipher", ShiftCiphers::HardenedVigenere, DEFAULT_KEY

  context "using cipher's instance methods" do
    before(:example) { @cipher = ShiftCiphers::HardenedVigenere.new(DEFAULT_KEY) }

    specify "transcryption with one letter key, which is the first letter in the cipher's alphabet" do
      key = @cipher.alphabet[0]
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "ykHLK(i.>u8H[bfc%jDXV-$2tX58)pV/@#VTbYRvy"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with one letter key" do
      key = "e"
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "s&]rd_\"DG@ob$Re3Gg!eg^]3?OJ#&EPNgvhEIdZ8W"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with two letters key" do
      key = "o2"
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "2[cf/?Oe/Lv.DG,^aXNY/TaNN6FWEUerbMp<dpy36"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with long key" do
      key = "Morbi 02 cc ultrices sagittis augue blandit interdum. 55! Suspendisse vitae lacinia quam! Id sollicitudin neque. Donec suscipit iaculis nisl, nec mattis ante commodo in. Nullam facilisis felis nisl, ac lacinia lorem accumsan sed. Maecenas euismod lectus dolor, at aliquet dui condimentum sit amet. Mauris finibus, ante vitae euismod laoreet, turpis diam maximus leo, a tristique risus neque nec odio. Mauris mi erat, accumsan in tempus nec, bibendum eget nisi. Suspendisse non consequat metus, sed facilisis lorem. Vivamus tincidunt dignissim eros varius porttitor. Vestibulum quis pulvinar diam, vitae egestas dolor."
      plaintext  = "In rissus ex, nullam vel pretium laoreet." * 20
      ciphertext = "<r4M6bBkmQQ\"YlZ{7(A!,4$.*xwwPhIRyhkBB;x=+L:w7*<sw>[s:d{;[9V8PW+>vhC_+C+Wuh{;%4BMhPZ5$fAjU1; rw=bq+R=SaGbI@@$$qj#4UETk paTd}{u:]kK<?#oHi1SYT} 8@i9'u*6P($-DLp^NYhpA#Z./;;}Gmj-hz}D642pA.ig@xJM{.3J/?TBK>R[cw')=h?mHzUNU,/m)\"4,ueK0Z,s0RQSSqS<<-PH4}:j5-x}RezAP!(Hqn6!nwC*/'1Y,+ad}E>L,T*ds;GRhk3j\"@,lo}Csk;b]g[,N;85{\"^ja'YBD09T0i};&KPut[BuNm+KLb9h##) -BVLz#t&iR-.w#caVB+9(lQr@h&ycPm\"PPYtP_gXY@\"hKVKRHfFa0^4u1v6x(V$g9UDxmD%<;_\"<e 1fTGz89NpyR@rpw['BmCp;Z0;'=cur.Tpm>Y_1eByZ],q}8!r.ZF2[vmOvo1^}8qDR> ux'VDQ =K\"ciF?^1a9SeMd!_ZDo z9 =zhG> MB>aRHA*+VR}QGR>6,0,u,5jwv8T&aP{}Wzsye9 58c^14qDghI4JD9Mx{!^/ZoN'QYgm#b4<tyJIUDD]L@tKGZ*T.Eq&N]s9 __UoQng3dx&Q^^}3VHx8r![[jvo:0&W1_Q*mF<6#URys{&b^V*B*w073eu@hlnew.pNa:YEv+tZ!vE0xP_pACmZP>)TDIbr'Mci:z8cDL1rMp*;NDE7[Qv=ki#(1-Ez]yo3)*5>l,W1D.or+.Hft,<c)9wI?8^MiRN.WE\"KVwv%m*:as/B5f9:_2!0H8o3)<ok3I"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "decryption with wrong key" do
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "wRqFg7 b OwSZRi+xjYZS<W\#{:(f/?$DRY-hTXiWt"

      encrypted = @cipher.encrypt(plaintext)
      @cipher = ShiftCiphers::HardenedVigenere.new("wrong key")
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to_not eq plaintext
    end

    specify "set custom key" do
      plaintext                   = "In rissus ex, nullam vel pretium laoreet."
      ciphertext_with_default_key = "wRqFg7 b OwSZRi+xjYZS<W\#{:(f/?$DRY-hTXiWt"
      ciphertext_with_custom_key  = "dg}C(oD-,1m^vfpbfS\"\"q[vTZF^*A]o+ZSz2 \"6VV"

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
      ciphertext_1 = "wRqFg7 b OwSZRi+xjYZS<W\#{:(f/?$DRY-hTXiWt"
      ciphertext_2 = "dg}C(oD-,1m^vfpbfS\"\"q[vTZF^*A]o+ZSz2 \"6VV"

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