# frozen_string_literal: true

RSpec.describe PkceOauth do
  it 'has a version number' do
    expect(PkceOauth::VERSION).not_to be_nil
  end

  it 'has class methods written in rust', :aggregate_failures do
    code_verifier = described_class.generate_code_verifier
    expect(code_verifier.size).to eq 128

    code_verifier = described_class.generate_limited_code_verifier(64)
    expect(code_verifier.size).to eq 64

    code_challenge = described_class.generate_code_challenge('verifier')
    expect(code_challenge.size).to eq 64
  end
end
