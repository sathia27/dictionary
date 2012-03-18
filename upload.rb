#!/usr/bin/env ruby
=begin
Program name: Enlish to tamil dictionary
Date Written: 18/03/2012
Date Modified: 18/03/2012
Author : Sathianarayanan.S
License: GPL2.0
Version: 1.0
=end

require_relative "word"
require "nokogiri"
require 'open-uri'
require 'net/http'
require 'uri'
class Upload < Word
  def english_to_tamil
		alphabets = ("a".."z").to_a
		alphabets.each do |alphabet|
			page = Nokogiri::HTML(open("http://ta.wiktionary.org/wiki/%E0%AE%9A%E0%AE%BF%E0%AE%B1%E0%AE%AA%E0%AF%8D%E0%AE%AA%E0%AF%81:PrefixIndex/"+alphabet))
			page.search("#mw-content-text a").each do |link|
				puts "Saving words of '"+
				inner_page = Nokogiri::HTML(open("http://ta.wiktionary.org"+link.attr("href")))
				name = inner_page.search("h1#firstHeading").text.gsub(/\s+/, "")
				meaning = inner_page.search("#mw-content-text ul li").collect{|mean| mean.text.gsub(/\s+/, "")}
				meaning.join(",")
				#puts name.gsub(/\s+/, "")
				Word.create(:name => name, :meaning => meaning)
			end
			puts "Saved all words of alphabet '"+alphabet+"'"
		end
	end
end
dict = Upload.new
dict.english_to_tamil

