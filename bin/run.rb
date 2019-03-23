require_relative "environment"
require 'pry'
Scraper.new(@db).scrape

all_pokemon = @db.execute("SELECT * FROM pokemon;")
binding.pry
# test out your code here!
puts "last line"
