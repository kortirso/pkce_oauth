# frozen_string_literal: true

module PkceOauth
  class Challenger
    def call(code_verifier:)
      PkceOauth.generate_code_challenge(code_verifier)
    end
  end
end
