# frozen_string_literal: true

RSpec.describe PkceOauth::Challenger do
  let(:instance) { described_class.new }

  describe '#call' do
    it 'returns string', :aggregate_failures do
      code_challenge = instance.call(code_verifier: 'verifier')

      expect(code_challenge.size).to eq 64
    end
  end
end
