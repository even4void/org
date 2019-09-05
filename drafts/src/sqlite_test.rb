#!/usr/bin/env ruby

require 'rubygems'
gem 'sqlite3-ruby'

db = SQLite3::Database.new( "test.db" )

db.execute( "SELECT * FROM tab2" ) do |row|
  puts row
end

db.close
