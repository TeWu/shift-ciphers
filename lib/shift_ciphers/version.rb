module ShiftCiphers
  module Version
    MAJOR = 0
    MINOR = 0
    PATCH = 3
    LABEL = nil
  end

  VERSION = ([Version::MAJOR, Version::MINOR, Version::PATCH, Version::LABEL].compact * '.').freeze
end