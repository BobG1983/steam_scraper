# SteamScraper

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'steam_scraper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install steam_scraper

## Usage

To scrape all pages from the steam store:

```Ruby
scraper = SteamScraper::SteamScraper.new
results = scraper.scrape
```

To scrape a range of pages from the steam store:

```Ruby
scraper = SteamScraper::SteamScraper.new
results = scraper.scrape(first_page, last_page)
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ShriekBob/steam_scraper.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
