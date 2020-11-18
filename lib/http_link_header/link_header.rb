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
    end

    # @return [Array<HttpLinkHeader::Link>]
    attr_reader :links

    # @param [Array<HttpLinkHeader::Link>] links
    # @param [Hash] options
    # @option options [String] :base_url
    def initialize(*links, **options)
      _links = links.flatten
      @links = _links.empty? ? [] : _links
      @base_url = options.delete(:base_url)
    end

    # @return [String]
    def generate
      links.flatten.compact.map { |l| l.generate(base_url: base_url) }.join(', ')
    end

    # @param [String] url
    # @param [Hash] options
    # @option options [String] :rel
    # @option options [String] :title
    # @option options [String] :hreflang
    # @option options [String] :media
    # @option options [String] :type
    def add_link(url, **options)
      links << Link.new(url, options)
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

    private

    attr_reader :base_url
  end
end
