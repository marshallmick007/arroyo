require 'securerandom'

module Arroyo
  module RandomString
    UPPER_LETTERS = ('A'..'Z').to_a
    LOWER_LETTERS = ('a'..'z').to_a
    LETTERS = UPPER_LETTERS + LOWER_LETTERS
    NUMBERS = (0..9).to_a
    WORD_CHARS = LETTERS + NUMBERS
    SYMBOLS = ['-', '!', '_', '@', '+', '*', '?', '%', '&', '/']

    def self.random_string(type, opts={})
      case type.to_sym
      when :guid, :uuid
        SecureRandom.uuid
      when :chars
        RandomString.generate_chars(opts)
      else
        SecureRandom.hex(opts[:length] || 24)
      end
    end

    def self.generate_chars(options = {})
      options[:length]  ||= 30
      options[:symbols] ||= false
      chars = options[:upper_letters_only] ? UPPER_LETTERS : WORD_CHARS
      chars_start = chars
      chars += SYMBOLS if options[:symbols]
      (
        [chars_start[rand(chars_start.size)]] +
        (0...options[:length]-2).map{ chars[rand(chars.size)] } +
        [chars_start[rand(chars_start.size)]]
      ).join
    end
  end
end
