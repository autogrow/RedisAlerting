module RedisAlerting
  class Config
    def initialize(opts)
      @config = opts
      parse_config
    end

    def to_hash
      @config
    end
    
    private

    def parse_config
      raise ArgumentError, "No config file specified" if @config[:config].nil?
      
      # automatically use a relative config path
      if @config[:config][0] != "/"
        @config[:config] = File.expand_path(@config[:config], @config[:pwd])
      end

      raise ArgumentError, "Invalid config file: #{@config[:config]}" unless File.exists? @config[:config]
      
      yaml = YAML.load_file(@config[:config])
      @config.merge!(yaml["alerting"])

      raise ArgumentError, "Incomplete configuration" unless valid_config?
    end

    # TODO: check we have all the needed options
    def valid_config?
      true
    end
  end
end