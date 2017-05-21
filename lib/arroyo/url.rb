module Arroyo

  class Url
    attr_reader :value

    DEFAULT_SCHEME = 'http'

    def initialize(uri)
      @value = uri
    end

    def ok?
      @value != nil
    end

    def host
      Result.new { @value.host }.value { nil }
    end

    def remove_www
      return self if !ok?
      Result.new { 
        h = host.sub(/^www\./, '')
        Arroyo::Url.create( "#{value.scheme}://#{h}/#{value.path}")
      }.value { self }
    end

    # Attempts to locate the Top Level Domain
    # for the current Url. If more than one dot
    # is found, then the last two segments are taken
    # This is likely not ideal in some cases
    def tld
      return nil if !ok?

      Result.new {
        dots = host.count('.')
        if dots == 1
          tld = /.*\.(\D*)$/.match(host).captures[0]
        elsif dots > 1
          tld = /.*\.(.*\..*)$/.match(host).captures[0]
        end
        tld
      }.value { nil }
    end

    def to_s
      Result.new { @value.to_s }.value { nil }
    end

    def self.create(url)
      r = Result.new { try_create_uri(url) }
      Arroyo::Url.new( r.value { nil } )
    end

    def self.parse_host(url)
      create(url).host
    end
    
    def self.try_create_uri(url)
      if url == ''
        raise "Invalid input"
      end
      url = "#{DEFAULT_SCHEME}://#{url}" unless url.start_with?('http')
      URI.parse(url)
    end
  end
end

