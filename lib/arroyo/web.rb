module Arroyo

  module Web
    #
    # Gathers HTTP headers from rack environment
    #
    def self.request_headers(env)
      env.inject({}){|acc, (k,v)| acc[$1.downcase] = v if k =~ /^http_(.*)/i; acc}
    end
  end
end
