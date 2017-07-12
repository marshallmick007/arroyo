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

    def app_root
      Arroyo.configuration.app_root
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
      rev_file = compute_capistrano_revision_file
      if File.exists? rev_file
        @deploy_version = File.read(rev_file).strip
        @deploy_date = File.mtime(rev_file).strftime('%F %r')
        @deploy_mode = :capistrano
      else
        s = `git log HEAD --pretty=format:%h^%ci`.strip
        if s
          @deploy_version = s.split('^')[0]
          @deploy_date = s.split('^')[1]
          @deploy_mode = :git
        end
      end
    rescue StandardError => e
      warn 'Unable to locate app deploy info'
      warn e.message
    end

    def coerce_environment
      env = :development
      if ENV['RACK_ENV']
        env = ENV['RACK_ENV'].to_sym
      end
      env
    end

    def compute_capistrano_revision_file
      if Arroyo.configuration.has_app_root?
        File.join( Arroyo.configuration.app_root, CAPISTRANO_REVISION_FILE )
      else
        CAPISTRANO_REVISION_FILE
      end
    end
  end
end
