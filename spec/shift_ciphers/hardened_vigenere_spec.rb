RSpec.describe ShiftCiphers::HardenedVigenere do
  DEFAULT_KEY = "k#;j"

  it_behaves_like "shift cipher", ShiftCiphers::HardenedVigenere, DEFAULT_KEY

  context "using cipher's instance methods" do
    before(:example) { @cipher = ShiftCiphers::HardenedVigenere.new(DEFAULT_KEY) }

    specify "transcryption with one letter key, which is the first letter in the cipher's alphabet" do
      key = @cipher.alphabet[0]
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "*aME3^tAC=7SQ4hdYlKFfm_AGe*I6o^\"5wKN hV92"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with one letter key" do
      key = "e"
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "_!3JZVo\"W7@W7&4sf2$WGktR&EauJQfCk;oU9G3JQ"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with two letters key" do
      key = "o2"
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "^2(Xt10CD.&%U8G 8dsMRI*%70DjnRb A-ilMRNuL"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with long key" do
      key = "Morbi 02 cc ultrices sagittis augue blandit interdum. 55! Suspendisse vitae lacinia quam! Id sollicitudin neque. Donec suscipit iaculis nisl, nec mattis ante commodo in. Nullam facilisis felis nisl, ac lacinia lorem accumsan sed. Maecenas euismod lectus dolor, at aliquet dui condimentum sit amet. Mauris finibus, ante vitae euismod laoreet, turpis diam maximus leo, a tristique risus neque nec odio. Mauris mi erat, accumsan in tempus nec, bibendum eget nisi. Suspendisse non consequat metus, sed facilisis lorem. Vivamus tincidunt dignissim eros varius porttitor. Vestibulum quis pulvinar diam, vitae egestas dolor."
      plaintext  = "In rissus ex, nullam vel pretium laoreet." * 20
      ciphertext = "-c/5Ly*:%sclnk?\"+LAundpHS\"PyR/8ou+FBsP2aW@YTTCG<:/0u<h{#AQviw[mm1cn=}3l$'s\"(=%cle}gQDSgg: ]I//0e(keXRtfg$oSgRJNfC1B)xh/G}BSO:b&}nxf}fUVUz'ewBYW@&HO)X30<]>eO(uYW;&4S*ER0)x*X/4mh3OD_uBlx$)'ShQ]m3w5kN7}\"!V;.7w??1r*mw,KvT)K)#MfeCmdo_Pr<D2 Usst5>R;Cpd 6wx)T]3Gce?e(# ,i/_lGS(%q_c%^{tvmoSJ{Qe)DYBZLbj{&/Ke]CFZW\"'A4BUe$p.\"td#gXl8S7YGzpUeFfW%N#)8B>RA'ul; [r5f9Q)%0]:b!] >hnN-*:/YJ6bBjyqmr;ZAIaVI+O8KlaWS903b7?GVsO^Q@(pJWIK1zOfbX0i}:}#WN'6l5Bv,MO0f;LtTs,<eL[}KPye1'}}4Jdb%yha(l_bhE};HPUTjj,yJ9.dNZSG-;X{{:XFi-,B7)lRi3oDocivi#;@6kx$,T0:kc#I!#GdR[3I}\"@/xbW(mlxO-.\"e5:{6DF'ZuUnuHs?${[rZ!Rp7M*mbx<,&yl<:c9#PEK%}'mM[!_ *o]a,B0'M7),%L+I$k2B4 0_p9f/.wf]bdD*Lw,VLPS,7t;l{jKO1T>;+E{;9B>FQ7N4^yZBh24A%>gkIxF3PF<m+V9Bo\"}DvJXFk805hCyO}W\"iU+V'h2UQWFCbosPIQZIb(*@*B'QRzg8r_%p;V+1Uy6Lp#-Qa9tD%(^*<b$cei:A6eZ i=Hq* 2eP\"\"a:bCPUPpO)+XMZq*L5l%*iM?T"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "decryption with wrong key" do
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "EU{k5WK tqK*+xw1sH3=]'eDa!x%0d@mcmxQ[sRyv"

      encrypted = @cipher.encrypt(plaintext)
      @cipher = ShiftCiphers::HardenedVigenere.new("wrong key")
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to_not eq plaintext
    end

    specify "set custom key" do
      plaintext                   = "In rissus ex, nullam vel pretium laoreet."
      ciphertext_with_default_key = "EU{k5WK tqK*+xw1sH3=]'eDa!x%0d@mcmxQ[sRyv"
      ciphertext_with_custom_key  = "8*1(zwA^E5?W&j#rRzkZSb^;4GiTI!-fc\"4Bfpz:;"

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
      ciphertext_1 = "EU{k5WK tqK*+xw1sH3=]'eDa!x%0d@mcmxQ[sRyv"
      ciphertext_2 = "8*1(zwA^E5?W&j#rRzkZSb^;4GiTI!-fc\"4Bfpz:;"

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