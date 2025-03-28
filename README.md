# PkceOauth

Proof Key for Code Exchange (PKCE) for ruby built with rust.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pkce_oauth'
```

## Usage

```ruby
# @return [Hash] keys: code_verifier, code_challenge
# code_verifier - random key
# code_challenge - Base64 url-encoded string of the SHA256 hash of the code verifier
PkceOauth.challenge
```

```ruby
# @return [Hash] keys: code_verifier, code_challenge
PkceOauth.challenge(key_length: 64)
```

```ruby
# @return [Boolean]
PkceOauth.challenge_valid?(code_verifier: code_verifier, code_challenge: code_challenge)
```

### Usage with dry-container

If you use dry-container for class memoization and use `PkceOauth.challenge` with the same options, then you can add initialized objects to container

```ruby
register('pkce_challenge') { PkceOauth::Challenge.new }
register('pkce_comparator') { PkceOauth::Comparison.new }
```

and later call them

```ruby
pkce_challenge.call
pkce_comparator.equal?(code_verifier: code_verifier, code_challenge: code_challenge)
```

### Direct usage

You can directly call generating code verifier and code challenge

```ruby
PkceOauth.generate_code_verifier
PkceOauth.generate_limited_code_verifier(64)
PkceOauth.generate_code_challenge(code_verifier)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

After changing rust code in ext folder you need to compile code and run tests

```bash
bundle exec rake compile
rspec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kortirso/pkce_oauth.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
