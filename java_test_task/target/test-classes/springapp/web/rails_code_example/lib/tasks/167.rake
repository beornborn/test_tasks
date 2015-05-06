require "csv"
task :bf_comments_data => :environment do
  BfComment.delete_all
  puts "BfComment remove ok "
  CSV.open(Rails.root.join("lib/bf_comments.csv")).each_with_index do |row, index|
    next if index == 0
    user = User.find_by_user_name(row[2])
    bf_comments_data = {heading: row[0], body: row[1],
      anonymous: row[3], confirmed_at: DateTime.now}
    bf_comment = BfComment.new(bf_comments_data)
    bf_comment.user_id = user.id
    bf_comment.breakingentity_id = Breakingentity.first.id
    bf_comment.save(validate: false)
    
    puts "BfComment add ok "
  end
  
  breakingentitys_rating = BreakingentitysRating.new({user_id: User.first.id, breakingentity_id: Breakingentity.first.id})
  breakingentitys_rating.save(validate: false)
  puts ""
  
end