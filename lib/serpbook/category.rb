module Serpbook
  class Category
    attr_accessor :name
    attr_writer :cat_auth, :viewkey

    def initialize(opts)
      self.name = opts[:name]
      self.cat_auth = opts[:cat_auth]
      self.viewkey = opts[:viewkey]
    end

    def cat_auth
      @cat_key ||= fetch_keys[:auth]
    end

    def viewkey
      @viewkey ||= fetch_keys[:viewkey]
    end

    def rankings
      @rankings ||= Rankings.new(Serpbook.request(auth: cat_auth, viewkey: viewkey))
    end

    def create(url, keyword, region: 'google.com', language: 'en', ignore_local: true)
      exact = url.start_with?('http') ? 1 : 0
      ignore_local = ignore_local ? 1 : 0
      Serpbook.request(viewkey: 'addkeyword', category: name, kw: keyword, 
                       url: clean_url(url), region: region, language: language, exact: exact, 
                       ignore_local: ignore_local)
    end

    def delete(url, keyword, region: 'google.com', language: 'en')
      Serpbook.request(viewkey: 'delkeyword', category: name, kw: keyword, 
                       url: clean_url(url), region: region, language: language)
    end

    def reload
      @rankings = nil
      self
    end

    class Rankings
      include Enumerable
      attr_accessor :ranks

      def initialize(ranks)
        self.ranks = ranks
      end

      def each &block
        ranks.each(&block)
      end

      def for_keyword(keyword)
        self.class.new(ranks.select {|row| row['kw'] == keyword } )
      end

      def for_url(url)
        self.class.new(ranks.select {|row| row['url'] == url } )
      end
    end


  private
    def clean_url(url)
      url.gsub('http://', '')
    end

    def fetch_keys
      @keys ||= Serpbook.categories[name]
    end
  end
end