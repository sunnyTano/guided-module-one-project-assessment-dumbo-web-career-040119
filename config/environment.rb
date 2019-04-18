require 'bundler'
Bundler.require
require 'tty-font'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'app'
# require_all 'db'

ActiveRecord::Base.logger = Logger.new(nil) 
