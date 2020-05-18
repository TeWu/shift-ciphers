module ShiftCiphers
  module Version
    MAJOR = 1
    MINOR = 0
    PATCH = 1
    LABEL = nil
    IS_STABLE = false
  end

  VERSION = ([Version::MAJOR, Version::MINOR, Version::PATCH, Version::LABEL, Version::IS_STABLE ? nil : "next"].compact * '.').freeze
end