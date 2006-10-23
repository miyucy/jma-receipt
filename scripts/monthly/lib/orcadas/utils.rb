module OrcaDAS
  USER_AGENT = "das-upload"
  PGVERSION = 1.0
  PGRELDATE = 0

  class Command
    def load_config
      path = CLIENT_CONFIG_FILE
      if File.file?(path)
        config = Module.new
        config.module_eval File.open(path).read
        config
      end
    end
  end

end
