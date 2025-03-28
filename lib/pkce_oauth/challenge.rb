# frozen_string_literal: true

module PkceOauth
  class Challenge
    attr_reader :verifier, :challenger

    def initialize(verifier: CodeVerifier, challenger: CodeChallenger, **options)
      @verifier = verifier.new(**options.slice(:key_length))
      @challenger = challenger.new
    end

    def call
      code_verifier = verifier.call

      {
        code_verifier: code_verifier,
        code_challenge: challenger.call(code_verifier: code_verifier)
      }
    end
  end
end
