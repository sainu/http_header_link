# frozen_string_literal: true

module HttpLinkHeader
  class Link
    # @return [String]
    attr_reader :uri
    attr_reader :attributes

    # @param [String] uri
    # @param [Hash{ Symbol => String }] options
    def initialize(uri, **options)
      @uri = uri
      @attributes = options.slice(:rel, :title, :hreflang, :media, :type)
    end

    # @return [String]
    def to_s
      str = "<#{uri}>"
      attributes.each do |name, value|
        str += %(; #{name}="#{value}")
      end
      str
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
  end
end
