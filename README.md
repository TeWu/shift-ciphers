Shift Ciphers [![Gem Version](https://badge.fury.io/rb/shift_ciphers.svg)](http://badge.fury.io/rb/shift_ciphers) [![Build Status](https://travis-ci.org/TeWu/shift-ciphers.svg?branch=master)](https://travis-ci.org/TeWu/shift-ciphers)
=======

**Shift Ciphers** gem is simple, yet complete, implementation of classic [Caesar][1] and [Vigenère][2] ciphers. It also features custom, hardened version of Vigenère cipher, which uses [autokey scheme][3] and [PRNG][4]s.

Installation
-------

    gem install shift_ciphers

Basic usage
-------

```ruby
require 'shift_ciphers'

plaintext = "Attack at dawn!"

encrypted = ShiftCiphers::Caesar.encrypt(plaintext, offset: 5)    # => "Fyyfhp%fy%ifBs^"
decrypted = ShiftCiphers::Caesar.decrypt(encrypted, offset: 5)    # => "Attack at dawn!"
decrypted == plaintext  # Should be true

encrypted = ShiftCiphers::Vigenere.encrypt(plaintext, "my keyword")    # => "W!0uqS3yU=zI3H{"
decrypted = ShiftCiphers::Vigenere.decrypt(encrypted, "my keyword")    # => "Attack at dawn!"
decrypted == plaintext  # Should be true

encrypted = ShiftCiphers::HardenedVigenere.encrypt(plaintext, "my keyword")    # => "Z6tappN^Ap[o&Ns"
decrypted = ShiftCiphers::HardenedVigenere.decrypt(encrypted, "my keyword")    # => "Attack at dawn!"
decrypted == plaintext  # Should be true
```

... or instantiate a cipher, and benefit from stored configuration info (e.g. `offset` for Caesar cipher, or `key` for Vigenère):

```ruby
caesar = ShiftCiphers::Caesar.new
caesar.offset = 5
encrypted = caesar.encrypt(plaintext)    # => "Fyyfhp%fy%ifBs^"
decrypted = caesar.decrypt(encrypted)    # => "Attack at dawn!"
decrypted == plaintext  # Should be true

vigenere = ShiftCiphers::Vigenere.new("my keyword")
encrypted = vigenere.encrypt(plaintext)    # => "W!0uqS3yU=zI3H{"
decrypted = vigenere.decrypt(encrypted)    # => "Attack at dawn!"
decrypted == plaintext  # Should be true

strong_vigenere = ShiftCiphers::HardenedVigenere.new("my keyword")
encrypted = strong_vigenere.encrypt(plaintext)    # => "Z6tappN^Ap[o&Ns"
decrypted = strong_vigenere.decrypt(encrypted)    # => "Attack at dawn!"
decrypted == plaintext  # Should be true
```

You can customize alphabet used by cipher:

```ruby
plaintext = "ATTACKATDAWN"
encrypted = ShiftCiphers::Vigenere.encrypt(plaintext, "KEYWORD", alphabet: "ABCDEFGHIJKLMNOPQRSTUVWXYZ")    # => "KXRWQBDDHYSB"
decrypted = ShiftCiphers::Vigenere.decrypt(encrypted, "KEYWORD", alphabet: "ABCDEFGHIJKLMNOPQRSTUVWXYZ")    # => "ATTACKATDAWN"
decrypted == plaintext  # Should be true
```

When you attempt to encrypt a string, which contains character that is not in the cipher's alphabet, then `ShiftCiphers::CipherError` is rised:

```ruby
plaintext = "ATTACK!"
encrypted = ShiftCiphers::Vigenere.encrypt(plaintext, "KEYWORD", alphabet: "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
# Raises ShiftCiphers::CipherError: Invalid input "ATTACK!". Character "!" is not in the alphabet: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
```

You can avoid this exception by telling cipher not to encrypt characters which are not in its alphabet. This is done by passing `nonalphabet_char_strategy` argument to `encrypt`/`decrypt` class method (or by using `nonalphabet_char_strategy=` instance method):

```ruby
plaintext = "ATTACK AT DAWN!"
encrypted = ShiftCiphers::Vigenere.encrypt(plaintext, "KEYWORD", alphabet: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", nonalphabet_char_strategy: :dont_encrypt)
decrypted = ShiftCiphers::Vigenere.decrypt(encrypted, "KEYWORD", alphabet: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", nonalphabet_char_strategy: :dont_encrypt)
puts plaintext  # => ATTACK AT DAWN!
puts encrypted  # => KXRWQB DD HYSB!
decrypted == plaintext  # Should be true
```

[1]: https://en.wikipedia.org/wiki/Caesar_cipher
[2]: https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher
[3]: https://en.wikipedia.org/wiki/Autokey_cipher
[4]: https://en.wikipedia.org/wiki/Pseudorandom_number_generator