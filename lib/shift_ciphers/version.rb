module ShiftCiphers
  module Version
    MAJOR = 1
    MINOR = 0
    PATCH = 0
    LABEL = nil
  end

  VERSION = ([Version::MAJOR, Version::MINOR, Version::PATCH, Version::LABEL].compact * '.').freeze
end