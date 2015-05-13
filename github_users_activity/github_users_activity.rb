#!/usr/bin/env ruby

puts "type 'exit' for quit"

loop do
  puts "\nEnter github usernames:"
  input = $stdin.gets.chomp

  break if input == 'exit'

  usernames = input.split(',').map(&:strip)

  puts "\nResult:"
  usernames.each do |username|
    puts "#{username}: 0"
  end
end
