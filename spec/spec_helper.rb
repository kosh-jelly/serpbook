$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'serpbook'

require 'awesome_print'
require 'vcr'
require '.env.rb'

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  c.cassette_library_dir = File.join('spec', 'vcr')
  c.hook_into :webmock
end

RSpec.configure do |config|

  config.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join("/").gsub(/[^\w\/]+/, "_")
    options = {} #example.metadata.slice(:record, :match_requests_on).except(:example_group)
    VCR.use_cassette(name, options) { example.call }
  end

  config.before :each do
    Serpbook.config do |conf|
      conf.master_key = ENV['serpbook_master_key']
      conf.email = ENV['serpbook_email']
    end
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.order = :random
  Kernel.srand config.seed
end