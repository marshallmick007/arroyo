# Arroyo

Arroyo is a collection of ruby monkey-patches, ideas and concepts, and
other random bits culled from multiple sources.

Arroyo packages

- [Timerizer](https://github.com/kylewlacy/timerizer)
- [Github-ds](https://github.com/github/github-ds) for [Resiliancy](https://johnnunemaker.com/resilience-in-ruby/)
- [Backtrace Shortener](https://github.com/philc/backtrace_shortener) - Modified version of the backtrace_shortener gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'arroyo'
# or
gem "arroyo", :git => 'git@github.com:marshallmick007/arroyo.git', :submodules => true
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

### Random Strings

```ruby
Arroyo::RandomString.random_string :chars
#> "KvnVAnd3rxHvw1ziikvz6nG0sPeS7c"
Arroyo::RandomString.random_string :chars, :length => 12, :symbols => true
#> "jd-X3C9XHb%e"
Arroyo::RandomString.random_string :chars, :length => 12, :upper_letters_only => true
#> "IOEDTKEFOWUW"
Arroyo::RandomString.random_string :uuid
#> "24a58f79-33ae-4a5d-9a1c-37cda2080bc8"
Arroyo::RandomString.random_string :guid
#> "e628c8e9-38fa-4e89-985a-9f96eb6e368d"
Arroyo::RandomString.random_string :hex
#> "ed5693d8b28089f81144621336357dc7aa60cd9c84e69e41"
Arroyo::RandomString.random_string :hex, :length => 8
#> "d3621e17ba8fb9e4"

```

### File Size Helpers

Monkey-patches the `Numeric` class. Converts an integer, float, etc to the proper
representation of the number of bytes

```ruby
4.12.MB
#> 4320133.12
13.GB
#> 13958643712
```

### Url Parser

Adds a wrapper around `URI.parse`

```ruby
u = Arroyo::Url.create("www.test.com")
u.ok?
#> true
u.value
#> #<URI::HTTP http://www.test.com>
u.host
#> www.test.com
u.tld
#> com
w = u.remove_www
w.host
#> test.com
```

`Arroyo::Url` takes an optional hash of additional settings that the
`create` method will use when constructing a URL. The defaults for this
hash are:

```ruby
DEFAULT_OPTS = {
  :scheme => 'http',
  :strict => false,
  :strip_www => false
}
```

`:strict` will cause the result to fail if the host name supplied does
not look like an internet address (eg: domain.tld, www.domain.co.tld,
etc)

## Version Info
- *0.1.3* - Add `remove_www`, `is_http?`, `is_https?` methods to
  `Arroyo::Url` class
- *0.1.1* - Add support for passing an options hash to
  `Arroyo::Url.create`

## TODO

- [ ] Date extensions from Rails [PR 24930](https://github.com/rails/rails/pull/24930/files#diff-bb8f439dae4f26019960ef37b2dd1fd3). [Sequel](http://sequel.jeremyevans.net/rdoc/files/doc/dataset_filtering_rdoc.html) supports Range `where` clauses
- [ ] [PowerCore](https://github.com/arturoherrero/powercore), or [PowerPack](https://github.com/bbatsov/powerpack)
- [ ] [Pretty Backtrace](https://github.com/ko1/pretty_backtrace)
- [ ] [Haikuinator](https://github.com/usmanbashir/haikunator)
- [ ] [Nifty-Utils](https://github.com/atech/nifty-utils)

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

