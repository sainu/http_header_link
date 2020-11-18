# frozen_string_literal: true

module HttpHeaderLink
  class Link
    # @return [String]
    attr_reader :url
    attr_reader :attributes

    # @param [String] url
    # @param [Hash] options
    # @option options [String] :rel
    # @option options [String] :title
    # @option options [String] :hreflang
    # @option options [String] :media
    # @option options [String] :type
    def initialize(url, **options)
      @url = url
      @attributes = options.slice(:rel, :title, :hreflang, :media, :type)
    end

    # @param [String] base_url
    # @return [String]
    def generate(base_url: nil)
      src = base_url ? URI.join(base_url, url) : url
      str = "<#{src}>"
      attributes.each do |name, value|
        str += %(; #{name}="#{value}")
      end
      str
    end

    # @param [Symbol] name
    # @return [String, nil]
    def get_query(name)
      query_hash[name.to_s]
    end

    # @return [String, nil]
    def rel
      attributes[:rel]
    end

    # @return [String, nil]
    def hreflang
      attributes[:hreflang]
    end

    # @return [String, nil]
    def title
      attributes[:title]
    end

    # @return [String, nil]
    def media
      attributes[:media]
    end

    # @return [String, nil]
    def type
      attributes[:type]
    end

    private

    # @return [URI]
    def uri
      URI.parse(url)
    end

    # @return [Hash{ String => String }]
    def query_hash
      URI::decode_www_form(uri.query || '').to_h
    end
  end
end
