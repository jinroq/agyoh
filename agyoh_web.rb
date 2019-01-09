# coding: utf-8
# endpoint を置くための web server
class AgyohWeb
  require 'net/http'
  require "socket"

  # agyoh pid ファイル
  AGYOH_PID_FILE = "./tmp/agyoh.pid".freeze
  # agyoh log ファイル
  AGYOH_LOG_FILE = "./tmp/agyoh.log".freeze
  # 3rd party 向け agyoh ポート番号
  AGYOH_3RD_PARTY_PORT = 2018
  # Client 向け agyoh ポート番号
  AGYOH_CLIENT_PORT = 2019
  
end
