# frozen_string_literal: true

RSpec.describe PkceOauth do
  it 'has a version number' do
    expect(PkceOauth::VERSION).not_to be_nil
  end

  it 'has class methods written in rust', :aggregate_failures do
    code_verifier = described_class.generate_code_verifier
    expect(code_verifier.size).to eq 128
    expect(code_verifier).to be_a(String)

    code_verifier = described_class.generate_limited_code_verifier(64)
    expect(code_verifier.size).to eq 64
    expect(code_verifier).to be_a(String)

    code_challenge = described_class.generate_code_challenge(code_verifier)
    expect(code_challenge.size).to eq 43
    expect(code_challenge).to be_a(String)
  end

  describe '#challenge' do
    it 'returns hash with code verifier and challenge', :aggregate_failures do
      challenge = described_class.challenge

      expect(challenge[:code_verifier].size).to eq 128
      expect(challenge[:code_verifier]).to be_a(String)
      expect(challenge[:code_challenge].size).to eq 43
      expect(challenge[:code_challenge]).to be_a(String)
    end

    context 'with options' do
      it 'returns hash with code verifier and challenge', :aggregate_failures do
        challenge = described_class.challenge(key_length: 64)

        expect(challenge[:code_verifier].size).to eq 64
        expect(challenge[:code_verifier]).to be_a(String)
        expect(challenge[:code_challenge].size).to eq 43
        expect(challenge[:code_challenge]).to be_a(String)
      end
    end
  end

  describe '#challenge_valid?' do
    let!(:code_verifier) { described_class.generate_code_verifier }
    let!(:code_challenge)  { described_class.generate_code_challenge(code_verifier) }

    context 'for invalid compare' do
      it 'returns false' do
        result = described_class.challenge_valid?(code_verifier: code_verifier, code_challenge: 'challenge')

        expect(result).to be_falsy
      end
    end

    context 'for valid compare' do
      it 'returns true' do
        result = described_class.challenge_valid?(code_verifier: code_verifier, code_challenge: code_challenge)

        expect(result).to be_truthy
      end
    end
  end
end
