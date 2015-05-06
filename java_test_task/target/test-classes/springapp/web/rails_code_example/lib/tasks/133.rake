require "csv"

task :all_of_fv_make_nonanon=> :environment do
  User.where(:user_name=>"entityber via").first.entitys.map do |entity|
    entity.update_attributes(:anonymous=>false)
  end
  puts "done"
end
