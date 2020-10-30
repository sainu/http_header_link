# HttpLinkHeader

The library handling the Link header, written in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'http_link_header'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install http_link_header

## Usage

### Generating Link Header

```rb
HttpLinkHeader::LinkHeader.generate(
  HttpLinkHeader::Link.new("/?page=1", rel: 'previous'),
  HttpLinkHeader::Link.new("/?page=3", rel: 'next')
)
=> "</?page=3>; rel=\"previous\", </?page=1>; rel=\"next\""
```

```rb
prev_url = get_prev_url
next_url = get_next_url
link_header = HttpLinkHeader::LinkHeader.new
link_header.push(HttpLinkHeader::Link.new(prev_url, rel: 'previous')) if prev_url
link_header.push(HttpLinkHeader::Link.new(next_url, rel: 'next')) if next_url
link_header.generate if link_header.present?
```

### Parsing Link Header

```rb
link_header = HttpLinkHeader::LinkHeader.parse('</?page=2>; rel="next"')
next_page = link_header.find_by(:rel, 'next')&.get_query(:page)&.to_i
=> 2
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sainuio/http_link_header.

