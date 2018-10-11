RSpec.describe ShiftCiphers::HardenedVigenere do
  DEFAULT_KEY = "k#;j"

  it_behaves_like "shift cipher", ShiftCiphers::HardenedVigenere, DEFAULT_KEY

  context "using cipher's instance methods" do
    before(:example) { @cipher = ShiftCiphers::HardenedVigenere.new(DEFAULT_KEY) }

    specify "transcryption with one letter key, which is the first letter in the cipher's alphabet" do
      key = @cipher.alphabet[0]
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = ".?]C<HU<ft7?l V?%OI%OH-*AW'y_s(hk6hFL8qJ7"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with one letter key" do
      key = "e"
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = ";iWJ/A;!YbEqn)vsSrxsb6OHqGKh$}[/n3M(Nur,7"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with two letters key" do
      key = "o2"
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "IaB9?-9cg&i(+qqua1zO>bIpintV%28Z&xQ{$'c)9"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with long key" do
      key = "Morbi 02 cc ultrices sagittis augue blandit interdum. 55! Suspendisse vitae lacinia quam! Id sollicitudin neque. Donec suscipit iaculis nisl, nec mattis ante commodo in. Nullam facilisis felis nisl, ac lacinia lorem accumsan sed. Maecenas euismod lectus dolor, at aliquet dui condimentum sit amet. Mauris finibus, ante vitae euismod laoreet, turpis diam maximus leo, a tristique risus neque nec odio. Mauris mi erat, accumsan in tempus nec, bibendum eget nisi. Suspendisse non consequat metus, sed facilisis lorem. Vivamus tincidunt dignissim eros varius porttitor. Vestibulum quis pulvinar diam, vitae egestas dolor."
      plaintext  = "In rissus ex, nullam vel pretium laoreet." * 20
      ciphertext = ".lre:b5!mM(@$z(+>> J]xa{T)D)K@U%Nako3IhNM^$}!80_Me90Mbks):vrfal 4qXcnl9wAtH}1nYZ:=0&>wB<z;F#,iW92Solj$MM;EMwv1D:-TWWWq'v9*>wbKHD_Ns?8X=Jm&8.#Z<4q24FUZrwbR!IC*%R@'PX-/^Nq. K9:2_0NcctltK^:'.9)A.PTf\"]U@J11ZhtXb@j.Y\"E!Y]*]\"H$GeI!-!8F!]GHvq_XvHy:m% orE?0SPiX*IUi-,lJDh\"vJChhXvB\"2\"Dj+O:,6:k^TKea]hHoBV=z9&a(,Qa\"bjys($laAbS?Kb'}ypF)T:7'OD \";6_krSg}?()ExU/&2*I<ZnT_k,ss_boy3UYajqMkP=&wNYrWvillmpM}jG8i>w;n_Jgb.\"^=me*;Ctuan9q#TV['p81U3-&jc967i?nSG_9Gs 5bNy[zN8c+qpS_8A)f*s9JG/R=HhSJ<p7\"MtG1ZV/[:E;N}2k9t f,B=6MwBKE{3#FD]156%(-I7GIM-vN/TR_*]zVM{l{D}CA@W.oQmUr(L;VLP.#XbcfD,v@S$La{JBO'L5XeUzKdf@FEC(!)JuR2[\"F+s4!i{0%,VlYMDAemvpI;J;694FOn-!:WrnF,m@Ve\"v k]S\"]QNdL=;!I<5e-/Zb!tEqEAagjB4:O;qLy6(kZZ3iY]Z;Jy]yO2{sqq4=ggUm&hYA ;n=pG8q*E'qWM!KjM0nl5*$v$OxB)39r)y\"hog3rswwvYZ%PI'E,JIX*+>V)u_}gx[5OkKy;'{h[ln2hjqX2%pYt}pO'\"x(vBcT}^X*126itaC"

      @cipher = ShiftCiphers::HardenedVigenere.new(key)
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "decryption with wrong key" do
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "\",V00:Foa4eWi2Qk[0 8:kY,5TTe7Rfe/igMj561="

      encrypted = @cipher.encrypt(plaintext)
      @cipher = ShiftCiphers::HardenedVigenere.new("wrong key")
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to_not eq plaintext
    end

    specify "set custom key" do
      plaintext                   = "In rissus ex, nullam vel pretium laoreet."
      ciphertext_with_default_key = "\",V00:Foa4eWi2Qk[0 8:kY,5TTe7Rfe/igMj561="
      ciphertext_with_custom_key  = "q'73LTB,Pac:d][D}(^AD:q*xX4PGfKUfTH:jDyE "

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
      ciphertext_1 = "\",V00:Foa4eWi2Qk[0 8:kY,5TTe7Rfe/igMj561="
      ciphertext_2 = "q'73LTB,Pac:d][D}(^AD:q*xX4PGfKUfTH:jDyE "

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