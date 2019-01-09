# coding: utf-8
class AgyohLogger
  # agyoh log ファイル
  AGYOH_LOG_FILE = "./tmp/agyoh.log".freeze

  def initialize
    # log ファイル作成
    File.open(AGYOH_LOG_FILE, "a+").close
  end

  # ロガー
  def self.log_info(message = '')
    AgyohLogger.new.log_info(message)
  end

  def self.log_error(message = '')
    AgyohLogger.new.log_error(message)
  end

  def log_info(message = '')
    now = Time.now
    File.open(AGYOH_LOG_FILE, "a+") do |f|
      f.puts("[#{now}] #{message}")
    end
  end

  def log_error(message = '')
    log_info("[ERROR] #{message}")
  end
end
