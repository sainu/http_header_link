# frozen_string_literal: true

module HttpLinkHeader
  class LinkHeader
    class << self
      # @param [String] target
      # @return [HttpLinkHeader::ParseResult]
      def parse(target)
        parts = target.split(',')
        links = parts.map do |part|
          sections = part.split(';')
          uri = sections.shift[/<(.*)>/, 1]
          options = {}
          sections.each do |section|
            name, val = section.split('=').map(&:strip)
            val.slice!(0, 1) if val.start_with?('"')
            val.slice!(-1, 1) if val.end_with?('"')
            options[name.to_sym] = val
          end
          Link.new(uri, options)
        end

        new(links)
      end
    end

    # @param [Array<HttpLinkHeader::Link>] links
    def initialize(*links)
      _links = links.flatten
      @links = _links.empty? ? [] : _links
    end

    # @return [String]
    def to_s
      links.flatten.compact.map(&:to_s).join(', ')
    end

    def method_missing(name)
      links.public_send(name)
    end

    private

    # @return [Array<HttpLinkHeader::Link>]
    attr_reader :links
  end
end
