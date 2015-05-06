require "csv"
task :breakingentitys_data => :environment do
  Breakingentity.delete_all
  puts "Breakingentity remove ok "
  CSV.open(Rails.root.join("lib/breakingentitys.csv")).each_with_index do |row, index|
    next if index == 0
    breakingentitys_data = {heading: row[0], body: row[1], illustration: row[2], 
      author_name: row[3], author_avatar: row[4], author_link_adress: row[5], 
      author_link_name: row[6], confirmed_at: DateTime.now}
    breakingentity = Breakingentity.new(breakingentitys_data)
    breakingentity.save(validate: false)
    
    puts "Breakingentity add ok "
  end
  puts ""
end