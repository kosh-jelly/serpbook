require "serpbook/version"
require 'serpbook/category'
require 'httparty'


module Serpbook
  include HTTParty

  class Configuration
    attr_accessor :master_key, :email
  end

  base_uri 'https://serpbook.com/serp/api/'

  class << self

    def config &block
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def categories
     request(viewkey: 'getcategories').map do |name, url|
        [name, CGI::parse(URI.parse(url).query).map{|k,v| [k.to_sym, v.first]}.to_h]
      end.to_h
    end

    def request(params)
      full_params = default_params.merge(params)
      response = self.get('/', query: full_params, verify: false)

      if response.code != 200
        raise ResponseError, "responded with #{response.code}, and messsage #{response.body}"
      end

      JSON.parse(response.body)
    end

    private
    def default_params
      { auth: Serpbook.configuration.master_key, 
        e: Serpbook.configuration.email }
    end
  
  end

end
