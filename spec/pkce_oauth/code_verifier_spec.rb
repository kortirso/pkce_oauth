# frozen_string_literal: true

RSpec.describe PkceOauth::CodeVerifier do
  let(:instance) { described_class.new }

  describe '#new' do
    context 'with invalid key length value type' do
      it 'raises error' do
        expect { described_class.new(key_length: 'abc') }.to(
          raise_error(PkceOauth::CodeVerifier::KeyLengthError, 'Key length should be number between 43 and 128')
        )
      end
    end

    context 'with key length value not in valid range' do
      it 'raises error' do
        expect { described_class.new(key_length: 12) }.to(
          raise_error(PkceOauth::CodeVerifier::KeyLengthError, 'Key length should be number between 43 and 128')
        )
      end
    end
  end

  describe '#call' do
    it 'returns random string', :aggregate_failures do
      code_verifier = instance.call

      expect(code_verifier.size).to eq 128
      expect(code_verifier).to be_a(String)
    end
  end
end
