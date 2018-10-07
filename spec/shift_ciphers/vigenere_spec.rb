RSpec.describe ShiftCiphers::Vigenere do

  it "works with short key" do
    key = "k3Y!"
    plaintext = "This is a simple test"
    cyphertext = ShiftCiphers::Vigenere.encrypt(plaintext, key)
    expect(cyphertext).to eq "=k}0:l<yu#<;Gs;{:w_0N"
    expect(ShiftCiphers::Vigenere.decrypt(cyphertext, key)).to eq plaintext
    expect(ShiftCiphers::Vigenere.decrypt(cyphertext, "wrong key")).to_not eq plaintext
  end

  it "works with long key" do
    key = "Vee33eery lo00ng key this is inde333D"
    plaintext = "This is a simple test"
    cyphertext = ShiftCiphers::Vigenere.encrypt(plaintext, key)
    expect(cyphertext).to eq "lvwv#wG>IxNGmpIuxNs 0"
    expect(ShiftCiphers::Vigenere.decrypt(cyphertext, key)).to eq plaintext
    expect(ShiftCiphers::Vigenere.decrypt(cyphertext, "wrong key")).to_not eq plaintext
  end

  it "works with custom alphabet" do
    alphabet = (?A..?Z).to_a.join
    key = "LEMON"
    plaintext = "ATTACKATDAWN"
    cyphertext = ShiftCiphers::Vigenere.encrypt(plaintext, key, alphabet: alphabet)
    expect(cyphertext).to eq "LXFOPVEFRNHR"
    expect(ShiftCiphers::Vigenere.decrypt(cyphertext, key, alphabet: alphabet)).to eq plaintext
    expect(ShiftCiphers::Vigenere.decrypt(cyphertext, "WRONGKEY", alphabet: alphabet)).to_not eq plaintext
  end

end