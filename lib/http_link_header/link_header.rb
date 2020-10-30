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
          url = sections.shift[/<(.*)>/, 1]
          options = {}
          sections.each do |section|
            name, val = section.split('=').map(&:strip)
            val.slice!(0, 1) if val.start_with?('"')
            val.slice!(-1, 1) if val.end_with?('"')
            options[name.to_sym] = val
          end
          Link.new(url, **options)
        end

        new(links)
      end

      # @param [Array<HttpLinkHeader::Link>] links
      def generate(*links)
        new(*links).generate
      end
    end

    # @return [Array<HttpLinkHeader::Link>]
    attr_reader :links

    # @param [Array<HttpLinkHeader::Link>] links
    def initialize(*links)
      _links = links.flatten
      @links = _links.empty? ? [] : _links
    end

    # @return [String]
    def generate
      links.flatten.compact.map(&:generate).join(', ')
    end

    # @param [HttpHeaderLink::Link]
    def push(link)
      raise TypeError, "no implicit conversion of #{link.class.name} into HttpLinkHeader::Link" unless link.is_a?(Link)
      links << link
    end

    # @return [Boolean]
    def present?
      !links.empty?
    end

    # @param [Symbol] attribute
    # @param [String] value
    def find_by(attribute, value)
      links.find { |link| link.public_send(attribute) == value }
    end
  end
end
