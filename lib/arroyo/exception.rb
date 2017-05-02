
module Arroyo
  class ArroyoException < StandardError
    attr_reader :exception

    def initialize(exception)
      @exception = exception
    end

    def message
      @exception.message
    end

    def backtrace
      simple_backtrace
      #@exception.backtrace
    end

    def simple_backtrace
      @exception.backtrace.select do |line| 
        line.start_with?(@configuration.app_base_path) 
      end.join( " ~> ")
    end

    def self.configuration
      @configuration ||= ExceptionConfiguration.new
    end

    def self.configure
      yield(configuration)
    end
  end

  class ExceptionConfiguration
    attr_accessor :app_base_path

    def initialize
      @app_base_path = nil
    end
  end
end
