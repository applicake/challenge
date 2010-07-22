OPTIONS = ARGV.select { |v| v[0..1] == '--' }
ARGV.replace(ARGV - OPTIONS)

unless defined?(Challenge)
  CHALLENGE_BASE_PATH = File.expand_path(File.dirname(__FILE__) + '/../')
  require File.dirname(__FILE__) + '/challenge/dsl_accessor'
  require File.dirname(__FILE__) + '/challenge/benchmark'
  require File.dirname(__FILE__) + '/challenge/solution'
end
if OPTIONS.include?('--profile')
  require 'rubygems'
  require 'ruby-prof'
  require File.dirname(__FILE__) + '/challenge/profile'
end

