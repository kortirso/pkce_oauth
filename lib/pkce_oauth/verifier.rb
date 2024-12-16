# frozen_string_literal: true

module PkceOauth
  class Verifier
    class KeyLengthError < StandardError; end

    MINIMUM_KEY_LENGTH = 43
    DEFAULT_KEY_LENGTH = 128

    attr_reader :key_length

    def initialize(key_length: DEFAULT_KEY_LENGTH)
      @key_length = validate_key_length(key_length)
    end

    def call
      PkceOauth.generate_limited_code_verifier(key_length)
    end

    private

    def validate_key_length(value)
      return value if value.is_a?(Integer) && value.between?(MINIMUM_KEY_LENGTH, DEFAULT_KEY_LENGTH)

      raise KeyLengthError, 'Key length should be number between 43 and 128'
    end
  end
end
