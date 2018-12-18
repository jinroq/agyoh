# coding: utf-8
class Agyoh
  require 'net/http'
  require "socket"

  # agyoh pid ファイル
  AGYOH_PID_FILE = "./tmp/agyoh.pid".freeze
  # agyoh log ファイル
  AGYOH_LOG_FILE = "./tmp/agyoh.log".freeze
  # agyoh デフォルトポート番号
  AGYOH_DEFAULT_PORT = 2018

  # 初期化処理
  def initialize
    # pid ファイル作成
    File.open(AGYOH_PID_FILE, "w").close
    # log ファイル作成
    File.open(AGYOH_LOG_FILE, "a+").close
  end

  # 起動
  def run
    begin
      log_info("== Agyoh Begin.")

      # デーモン化
      daemonize

      # 処理実行
      execute

      log_info("== Agyoh End.")
    rescue => e
    end
  end

  private

  # デーモン化
  def daemonize
    begin
      # デーモン化
      Process.daemon(true, true)

      # pid ファイル生成
      File.open(AGYOH_PID_FILE, "w") { |f| f << Process.pid }
    rescue => e
      error_message = "#{self.class.name}.daemonize #{e}"
      log_error(error_message)
      STDERR.puts(error_message)
      exit(1)
    end
  end

  # 処理実行
  def execute
    begin
      @tcp_socket = TCPSocket.open("127.0.0.1", 2019)
    rescue => e
      error_message = "TCPSocket.open failed : #$!\n"
      puts(error_message)
      log_error(error_message + "#{e.message}")
    end

    # TCPSocket 用の Thread を作成
    threads << Thread.new do |thread|
      while true
        @tcp_socket.write('{ "key" : "value" }')
      end
    end

    # umgyoh の API を叩くための Thread を作成
    threads << Thread.fork do |thread|
      message = "Access umgyoh!"
      puts(message)
      log_info(message)
    end

    # Thread を使用
    threads.each do |thread|
      thread.join
    end
  end

  # 停止処理
  def stop
    @tcp_socket.close
  end

  # ロガー
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

# 起動
Agyoh.new.run
