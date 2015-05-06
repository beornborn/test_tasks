require "csv"

task :admin_users => :environment do

  #if need clean
  AdminUser.delete_all
  
  puts "put admins"
  CSV.open(Rails.root.join("lib/adminsdata.csv")).each_with_index do |row, index|
    next if index == 0
    user_data = {:email=> row[0], :password=>row[1]}
    user = AdminUser.new user_data
    user.save(:validate=> false)
    end
end
