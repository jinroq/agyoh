# coding: utf-8
module Initializers
  class Sqlite3Seeds
    require "sqlite3"

    # agyoh sqlite file
    AGYOH_SQLITE3_FILE = "./tmp/agyoh.sqlite3".freeze

    def initialize
      @db = SQLite3::Database.new(AGYOH_SQLITE3_FILE)

      ret = is_existed_table?("device_tokens")
      puts("ret => #{ret}")

      unless ret
        create_device_tokens
      end
    end

    private

    # テーブルの存在確認
    def is_existed_table?(table_name)
      begin
        ret = @db.execute("select count(*) from #{table_name}")
        true unless ret.nil?
      rescue SQLite3::SQLException => e
        puts("e => #{e.inspect}")
        puts("e.message => #{e.message}")
        if "no such table: #{table_name}" == e.message
          return false
        else
          raise e
        end
      end
    end

    # device_tokens テーブルの作成
    def create_device_tokens
      sql = <<-SQL
      create table device_tokens (
        id          integer primary key autoincrement,
        token       text    not null,
        device_name text    not null,
        created_at  text    not null,
        updated_at  text    not null
      );
      SQL
      @db.execute(sql)

    end
  end
end
