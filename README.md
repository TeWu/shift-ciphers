Shift Ciphers [![Gem Version](https://badge.fury.io/rb/shift_ciphers.svg)](http://badge.fury.io/rb/shift_ciphers) [![Build Status](https://travis-ci.org/TeWu/shift_ciphers.svg?branch=master)](https://travis-ci.org/TeWu/shift_ciphers)
=======

**Shift Ciphers** gem is simple, yet complete, implementation of [Caesar](https://en.wikipedia.org/wiki/Caesar_cipher) and [Vigenère](https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher) ciphers.

Installation
-------

    gem install shift_ciphers

Basic usage
-------

```ruby
require 'shift_ciphers'

caesar = ShiftCiphers::Caesar.new
caesar_cyphertext = caesar.encrypt("ATTACKATDAWN")
p caesar_cyphertext
p caesar.decrypt(caesar_cyphertext)

key = "5ecr3t"
vigenere_cyphertext = ShiftCiphers::Vigenere.encrypt("ATTACKATDAWN", key)
p key
p vigenere_cyphertext
p ShiftCiphers::Vigenere.decrypt(vigenere_cyphertext, key)
```
