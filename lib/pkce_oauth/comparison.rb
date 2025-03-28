# frozen_string_literal: true

module PkceOauth
  class Comparison
    attr_reader :challenger

    def initialize(challenger: CodeChallenger)
      @challenger = challenger.new
    end

    def equal?(code_verifier:, code_challenge:)
      challenger.call(code_verifier: code_verifier) == code_challenge
    end
  end
end
