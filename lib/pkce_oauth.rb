# frozen_string_literal: true

require_relative 'pkce_oauth/version'
require_relative 'pkce_oauth/pkce_oauth'
require_relative 'pkce_oauth/code_verifier'
require_relative 'pkce_oauth/code_challenger'
require_relative 'pkce_oauth/challenge'
require_relative 'pkce_oauth/comparison'

module PkceOauth
  module_function

  class Error < StandardError; end

  def challenge(...)
    PkceOauth::Challenge.new(...).call
  end

  def challenge_valid?(...)
    PkceOauth::Comparison.new.equal?(...)
  end
end
