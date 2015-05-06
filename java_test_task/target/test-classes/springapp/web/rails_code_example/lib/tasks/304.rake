require "csv"

task :reserved_users=> :environment do
@user = User.where(:user_name=>"Dr.entitys")
User.destroy(@user) unless @user.blank?
  puts "put reserved users"
  CSV.open(Rails.root.join("lib/reserved_users_data.csv")).each_with_index do |row, index|
    next if index == 0
    user_data = {:name=>row[0], :user_name=>row[1], :email=> row[2], :password=>row[3], :zip_code=>row[4], :gender=>row[5]}
    user = User.new user_data
    user.skip_confirmation!
    user.save(:validate=> false)
    end
end
