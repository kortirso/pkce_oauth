# frozen_string_literal: true

RSpec.describe PkceOauth::CodeChallenger do
  let(:instance) { described_class.new }

  describe '#call' do
    it 'returns string', :aggregate_failures do
      code_challenge = instance.call(code_verifier: 'verifier')

      expect(code_challenge.size).to eq 43
      expect(code_challenge).to be_a(String)
    end
  end
end
