#!/usr/bin/env ruby
=begin
Program name: Enlish to tamil dictionary
Date Written: 18/03/2012
Date Modified: 18/03/2012
Author : Sathianarayanan.S
License: GPL2.0
Version: 1.0
=end

require "rubygems"
require "active_record"
ActiveRecord::Base.establish_connection(
	:adapter => "sqlite3",
	:database => "word.db"
)
unless ActiveRecord::Base.connection.tables.include?("words")
	ActiveRecord::Schema.define do
		create_table :words, :force => true do |t|
			t.column :name, :string
			t.column :meaning, :text
		end
	end
end
class Word < ActiveRecord::Base
	
end
