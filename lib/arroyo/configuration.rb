module Arroyo
  class Configuration
    attr_accessor :app_root
    
    def initialize
      @app_root = nil
    end

    def has_app_root?
      !@app_root.nil?
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
