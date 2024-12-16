# frozen_string_literal: true

RSpec.describe PkceOauth do
  it 'has a version number' do
    expect(PkceOauth::VERSION).not_to be_nil
  end

  it 'does something useful' do
    expect(PkceOauth.hello('User')).to eq 'Hello from Rust, User!'
  end
end
