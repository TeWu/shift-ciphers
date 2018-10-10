RSpec.describe ShiftCiphers::Caesar do
  it_behaves_like "shift cipher", ShiftCiphers::Caesar

  context "using cipher's instance methods" do
    before(:example) { @cipher = ShiftCiphers::Caesar.new }

    specify "transcryption with custom offset" do
      @cipher = ShiftCiphers::Caesar.new(offset: 5)
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "Ns%wnxxzx%jC?%szqqfr%Ajq%uwjynzr%qftwjjy0"
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with zero offset" do
      @cipher = ShiftCiphers::Caesar.new(offset: 0)
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq plaintext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with offset equal to alphabet size" do
      @cipher = ShiftCiphers::Caesar.new(offset: @cipher.alphabet.size)
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq plaintext
      expect(decrypted).to eq plaintext
    end

    specify "transcryption with offset larger than alphabet size" do
      shared_offset = 8
      @cipher_1 = ShiftCiphers::Caesar.new(offset: shared_offset)
      @cipher_2 = ShiftCiphers::Caesar.new(offset: @cipher.alphabet.size * 200 + shared_offset)
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "Qv*zqAACA*mF2*vCttiu*Dmt*xzmBqCu*tiwzmmB3"

      encrypted_1 = @cipher_1.encrypt(plaintext)
      encrypted_2 = @cipher_2.encrypt(plaintext)
      decrypted_1 = @cipher_1.decrypt(encrypted_1)
      decrypted_2 = @cipher_2.decrypt(encrypted_2)
      expect(encrypted_1).to eq encrypted_2
      expect(encrypted_1).to eq ciphertext
      expect(decrypted_1).to eq decrypted_2
      expect(decrypted_1).to eq plaintext
    end

    specify "set custom offset" do
      plaintext                      = "In rissus ex, nullam vel pretium laoreet."
      ciphertext_with_default_offset = "VA=EvFFHF=rK7=AHyynz=Iry=CErGvHz=ynBErrG8"
      ciphertext_with_custom_offset  = "Rw(ArBBDB(nG3(wDuujv(Enu(yAnCrDv(ujxAnnC4"

      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext_with_default_offset
      expect(decrypted).to eq plaintext

      @cipher.offset = 9

      encrypted = @cipher.encrypt(plaintext)
      decrypted = @cipher.decrypt(encrypted)
      expect(encrypted).to eq ciphertext_with_custom_offset
      expect(decrypted).to eq plaintext
    end
  end


  context "using cipher's class methods" do
    specify "transcryption with custom offset" do
      plaintext  = "In rissus ex, nullam vel pretium laoreet."
      ciphertext = "Ty-CtDDFD-pI5-yFwwlx-Gpw-ACpEtFx-wlzCppE6"
      encrypted = ShiftCiphers::Caesar.encrypt(plaintext, offset: 11)
      decrypted = ShiftCiphers::Caesar.decrypt(encrypted, offset: 11)
      expect(encrypted).to eq ciphertext
      expect(decrypted).to eq plaintext
    end
  end
end