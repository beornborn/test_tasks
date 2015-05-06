require "csv"
task :category_data => :environment do
  Category.destroy_all
  CSV.open(Rails.root.join("lib/categories.csv")).each_with_index do |row, index|
    next if index == 0
    categories_data = {tag: row[0], pic: row[1], counter: (row[3].present? ? row[3] : 0)}
    category = Category.new(categories_data)
    category.save(validate: false)
    puts "category add ok "
  end
  puts ""
end