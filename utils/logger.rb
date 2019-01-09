# coding: utf-8
module Utils
  class Logger
    LOG_FILE = "./tmp/agyoh.log".freeze

    def initialize
      File.open(LOG_FILE, "a+").close
    end

    # public class methods
    
    # level: info
    def self.log_info(message = '')
      Logger.new.log_info(message)
    end

    # level: error
    def self.log_error(message = '')
      Logger.new.log_error(message)
    end

    # public instance methods

    # level: info
    def log_info(message = '')
      now = Time.now
      File.open(LOG_FILE, "a+") do |f|
        f.puts("[#{now}] #{message}")
      end
    end

    # level: error
    def log_error(message = '')
      log_info("[ERROR] #{message}")
    end
  end
end
