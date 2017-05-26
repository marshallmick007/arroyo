module Arroyo

  class Url
    DOMAIN_NAME_REGEX = /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z0-9]{2,12}\z/
    DEFAULT_SCHEME = 'http'
    DEFAULT_OPTS = {
      :scheme => 'http',
      :strict => false,
      :strip_www => false
    }
    
    attr_reader :value

    def initialize(uri, opts={})
      @value = uri
      @strict = false
      @opts = DEFAULT_OPTS.merge(opts)
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

    def self.create(url, opts={})
      opts = DEFAULT_OPTS.merge(opts)
      r = Result.new { try_create_url(url, opts) }
      Arroyo::Url.new( r.value { nil }, opts )
    end

    def self.parse_host(url, opts={})
      create(url,opts).host
    end
    
    def self.try_create_url(url, opts={})
      validate_try_create_params!(url)
      if url.is_a? URI
        u = url
      elsif url.is_a? Arroyo::Url
        raise 'Invalid Arroyo:Url supplied' unless url.ok?
        u = url.value
      else
        url = "#{DEFAULT_SCHEME}://#{url}" unless url.start_with?('http')
        u = URI.parse(url)
      end

      if opts[:strip_www]
        u.host = u.host.sub(/^www\./, '')
      end

      if !opts[:strict] || u.host =~ DOMAIN_NAME_REGEX
        return u
      end

      raise "Invalid host name format: [#{u.host}]"
    end

    def self.validate_try_create_params!(url)
      if url.nil?
        raise 'Nil input found'
      elsif url.is_a? String
        raise "Invalid input found '#{url}'"  if url == ''
      end
    end
  end
end

