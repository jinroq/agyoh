# coding: utf-8
class AgyohTcpServer
  require "socket"
  require "./utils/logger"

  include Utils

  # agyoh pid file
  AGYOH_PID_FILE = "./tmp/agyoh.pid".freeze
  # port for client
  PORTNUMBER_FOR_CLIENT = 2019

  def initialize
    # open pid file
    File.open(AGYOH_PID_FILE, "w").close
  end

  def run
    execute
  end

  private

  # 
  def execute
    @tcp_server = TCPServer.open(PORTNUMBER_FOR_CLIENT)

    while true
      # 接続要求を受け付ける TCPScoket を生成する。
      socket = @tcp_server.accept

      # 接続相手先ソケットの情報。
      peeraddr = socket.peeraddr
      puts("socket.peeraddr => #{peeraddr}")
      Utils::Logger.log_info("socket.peeraddr => #{peeraddr}")

      # TCPSocket を閉じる。
      socket.close
    end

    # TCPServer を閉じる。
    @tcp_server.close
  end
end

AgyohTcpServer.new.run
