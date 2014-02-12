#!/usr/bin/ruby
# coding : utf-8
Encoding.default_external = "euc-jp" unless RUBY_VERSION == "1.8.7"

module OrcaDAS
  USER_AGENT = "das-upload"
  PGVERSION = 1.0
  PGRELDATE = 0

  class Command
    def load_config
      path = CLIENT_CONFIG_FILE
      if File.file?(path)
        Module.new.module_eval File.open(path).read
      end
    end
  end

end
