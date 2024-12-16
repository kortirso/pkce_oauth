# frozen_string_literal: true

module PkceOauth
  class Comparator
    attr_reader :challenger

    def initialize(challenger: Challenger)
      @challenger = challenger.new
    end

    def equal?(code_verifier:, code_challenge:)
      challenger.call(code_verifier: code_verifier) == code_challenge
    end
  end
end
