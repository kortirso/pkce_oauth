# frozen_string_literal: true

require_relative 'pkce_oauth/version'
require_relative 'pkce_oauth/pkce_oauth'
require_relative 'pkce_oauth/challenge'
require_relative 'pkce_oauth/comparator'
require_relative 'pkce_oauth/verifier'
require_relative 'pkce_oauth/challenger'

module PkceOauth
  module_function

  class Error < StandardError; end
  # Your code goes here...

  def challenge(...)
    PkceOauth::Challenge.new(...).call
  end

  def challenge_valid?(...)
    PkceOauth::Comparator.new.equal?(...)
  end
end
