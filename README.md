# Arroyo

Arroyo is a collection of ruby monkey-patches, ideas and concepts, and
other random bits culled from multiple sources.

Arroyo packages

- [Timerizer](https://github.com/kylewlacy/timerizer)
- [Github-ds](https://github.com/github/github-ds) for [Resiliance](https://johnnunemaker.com/resilience-in-ruby/)
- [Backtrace Shortener](https://github.com/philc/backtrace_shortener) - Modified version of the backtrace_shortener gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'arroyo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install arroyo

## Features

### Backtrace Shortener

Cleans up backtraces by monkey-patching the Exception class. Modified
version of
[backtrace_shortener](https://github.com/philc/backtrace_shortener) with
a built in filter to remove all backtraces for anything other than your
app.

```ruby
# enable the patch
Arroyo::Backtrace.monkey_patch!
# reject all backtraces that to not originate from your app
Arroyo::Backtrace.show_only_app_exceptions!
# or to specify a directory root to ignore...
Arroyo::Backtrace.show_only_app_exceptions!(File.dirname(__FILE__))

```

## TODO

[ ] - Date extensions from Rails [PR 24930](https://github.com/rails/rails/pull/24930/files#diff-bb8f439dae4f26019960ef37b2dd1fd3). [Sequel](http://sequel.jeremyevans.net/rdoc/files/doc/dataset_filtering_rdoc.html) supports Range `where` clauses
[ ] - [PowerCore](https://github.com/arturoherrero/powercore), or [PowerPack](https://github.com/bbatsov/powerpack)
[ ] - [Pretty Backtrace](https://github.com/ko1/pretty_backtrace)
[ ] - [Haikuinator](https://github.com/usmanbashir/haikunator)
## Usage

DATA constant - https://github.com/thoughtbot/til/blob/master/ruby/the-data-constant.md

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/marshallmick007/arroyo.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

