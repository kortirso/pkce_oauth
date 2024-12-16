# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'

RuboCop::RakeTask.new

require 'rb_sys/extensiontask'

task build: :compile # rubocop: disable Rake/Desc

GEMSPEC = Gem::Specification.load('pkce_oauth.gemspec')

RbSys::ExtensionTask.new('pkce_oauth', GEMSPEC) do |ext|
  ext.lib_dir = 'lib/pkce_oauth'
end

task default: %i[compile spec rubocop]
