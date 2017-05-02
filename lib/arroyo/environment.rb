require 'json'

module Arroyo

  def self.environment
    @environment ||= Environment.new
  end

  class Environment
    CAPISTRANO_REVISION_FILE='REVISION'
    
    attr_reader :env, :deploy_version, :deploy_date, :deploy_mode

    def initialize
      @env = coerce_environment
      set_app_version
    end

    def production?
      @env == :production
    end
    
    def development?
      !production?
    end

    def deployed?
      @deploy_mode
    end

    def to_json
      {
        :environment => @env,
        :deploy_version => @deploy_version,
        :deploy_date => @deploy_date,
        :deploy_mode => @deploy_mode
      }.to_json
    end

    alias_method :dev?, :development?
    alias_method :prod?, :production?

    private
  
    def set_app_version
      if File.exists? CAPISTRANO_REVISION_FILE
        @deploy_version = File.read(CAPISTRANO_REVISION_FILE).strip
        @deploy_date = File.mtime(REVISION_FILE).strftime('%F %r')
        @deploy_mode = :capistrano
      else
        s = `git log HEAD --pretty=format:%h^%ci`.strip
        if s
          @deploy_version = s.split('^')[0]
          @deploy_date = s.split('^')[1]
          @deploy_mode = :git
        end
      end
    rescue e
      warn 'Unable to locate app deploy info'
      warn e.message
      #app[:error] = e.message
      #app
    end

    def coerce_environment
      env = :development
      if ENV['RACK_ENV']
        env = ENV['RACK_ENV'].to_sym
      end
      env
    end
  end
end
