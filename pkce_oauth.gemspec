# frozen_string_literal: true

require_relative 'lib/pkce_oauth/version'

Gem::Specification.new do |spec|
  spec.name = 'pkce_oauth'
  spec.version = PkceOauth::VERSION
  spec.authors = ['Bogdanov Anton']
  spec.email = ['kortirso@gmail.com']

  spec.summary = 'PKCE Oauth2'
  spec.description = 'Code verifier and challenge generator for use in PKCE Oauth2.'
  spec.homepage = 'https://github.com/kortirso/pkce_oauth'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'
  spec.required_rubygems_version = '>= 3.3.11'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = 'https://github.com/kortirso/pkce_oauth/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ spec/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.extensions = ['ext/pkce_oauth/extconf.rb']

  spec.add_dependency 'rake', '~> 13.0'
  spec.add_dependency 'rake-compiler', '~> 1.2.0'
  spec.add_dependency 'rb_sys', '~> 0.9.91'

  spec.add_development_dependency 'rubocop', '~> 1.39'
  spec.add_development_dependency 'rubocop-performance', '~> 1.8'
  spec.add_development_dependency 'rubocop-rake', '~> 0.6'
  spec.add_development_dependency 'rubocop-rspec', '~> 3.0'
end
