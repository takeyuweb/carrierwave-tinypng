require 'rubygems'
require 'bundler/setup'
require 'carrierwave'
require 'carrierwave/tinypng'
require 'webmock/rspec'

CarrierWave::TinyPNG.configure do |config|
  config.key = 'testkey'
end

def file_path(*paths)
  File.expand_path File.join(File.dirname(__FILE__), 'fixtures', *paths)
end

def public_path(*paths)
  File.expand_path(File.join(File.dirname(__FILE__), 'public', *paths))
end

CarrierWave.root = public_path
RSpec.configure do |config|
  config.after do
    FileUtils.rm_rf public_path
  end
end

I18n.load_path << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'carrierwave', 'locale', 'en.yml'))
