Shift Ciphers [![Gem Version](https://badge.fury.io/rb/shift_ciphers.svg)](http://badge.fury.io/rb/shift_ciphers) [![Build Status](https://travis-ci.org/TeWu/shift-ciphers.svg?branch=master)](https://travis-ci.org/TeWu/shift-ciphers)
=======

**Shift Ciphers** gem is simple, yet complete, implementation of [Caesar](https://en.wikipedia.org/wiki/Caesar_cipher) and [Vigenère](https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher) ciphers.

Installation
-------

    gem install shift_ciphers

Basic usage
-------

```ruby
require 'shift_ciphers'

plaintext = "Attack at dawn!"

encrypted = ShiftCiphers::Caesar.encrypt(plaintext, offset: 5)
decrypted = ShiftCiphers::Caesar.decrypt(encrypted, offset: 5)
decrypted == plaintext  # Should be true

encrypted = ShiftCiphers::Vigenere.encrypt(plaintext, "my keyword")
decrypted = ShiftCiphers::Vigenere.decrypt(encrypted, "my keyword")
decrypted == plaintext  # Should be true
```

... or instantiate cipher, and benefit from stored configuration info (e.g. `offset` for Caesar cipher, or `key` for Vigenère cipher):

```ruby
caesar = ShiftCiphers::Caesar.new
caesar.offset = 5
encrypted = caesar.encrypt(plaintext)
decrypted = caesar.decrypt(encrypted)
decrypted == plaintext  # Should be true

vigenere = ShiftCiphers::Vigenere.new("my keyword")
encrypted = vigenere.encrypt(plaintext)
decrypted = vigenere.decrypt(encrypted)
decrypted == plaintext  # Should be true
```

You can customize alphabet used by cipher:

```ruby
plaintext = "ATTACKATDAWN"
encrypted = ShiftCiphers::Vigenere.encrypt(plaintext, "KEYWORD", alphabet: "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
decrypted = ShiftCiphers::Vigenere.decrypt(encrypted, "KEYWORD", alphabet: "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
decrypted == plaintext  # Should be true
```

When you attempt to encrypt a string, which contains character that is not in the cipher's alphabet, then `ShiftCiphers::CipherError` is rised:

```ruby
plaintext = "ATTACK!"
encrypted = ShiftCiphers::Vigenere.encrypt(plaintext, "KEYWORD", alphabet: "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
# Raises ShiftCiphers::CipherError: Invalid input "ATTACK!". Character "!" is not in the alphabet: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
```

You can avoid this exception by telling cipher to not encrypt characters which are not in its alphabet. This is done by passing `nonalphabet_char_strategy` argument to `encrypt`/`decrypt` class method (or by using `nonalphabet_char_strategy=` instance method):

```ruby
plaintext = "ATTACK AT DAWN!"
encrypted = ShiftCiphers::Vigenere.encrypt(plaintext, "KEYWORD", alphabet: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", nonalphabet_char_strategy: :dont_encrypt)
decrypted = ShiftCiphers::Vigenere.decrypt(encrypted, "KEYWORD", alphabet: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", nonalphabet_char_strategy: :dont_encrypt)
puts plaintext  # => ATTACK AT DAWN!
puts encrypted  # => KXRWQB DD HYSB!
decrypted == plaintext  # Should be true
```