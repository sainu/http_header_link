# HttpLinkHeader

The library handling the Link header, written in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'http_link_header', git: 'git@github.com:sainu/http_link_header.git', branch: 'master'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install http_link_header git@github.com:sainu/http_link_header.git master

## Usage

### Generating Link Header

#### Basic

```rb
link_header = HttpLinkHeader::LinkHeader.new
link_header.add_link('/?page=1', rel: 'previous')
link_header.add_link('/?page=3', rel: 'next')
link_header.generate
=> "</?page=1>; rel=\"previous\", </?page=3>; rel=\"next\""
```

#### Configure Base URL

```rb
link_header = HttpLinkHeader::LinkHeader.new(base_url: 'http://localhost')
link_header.add_link('/?page=1', rel: 'previous')
link_header.add_link('/?page=3', rel: 'next')
link_header.generate
=> "<http://localhost/?page=1>; rel=\"previous\", <http://localhost/?page=3>; rel=\"next\""
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

