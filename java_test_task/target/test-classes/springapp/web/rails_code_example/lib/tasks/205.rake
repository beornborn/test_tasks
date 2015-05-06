task :create_anonymous_user => :environment do

  user = User.where(["user_name = ?", "Anonymous"]).first
  if user.present?
    user.user_name = "Anonymous." 
    user.save
  end  

  puts "creating Anonymous bot user"
        user=User.new({:name=> "RobotAnonymous", :user_name=> "Anonymous", :password=>"n23527890vj07y52o0ry0ayeot5ghoery674", :zip_code=> "99999", :dob=>"9/9/1999", :email=>   "entitysanonim@entitysanonim.entitysanonim", :gender=> "M", :confirmed_at=> DateTime.now, :anonymous=>"1"})
        user.skip_confirmation!
        user.save(:validate=> false)
        user.update_attribute(:anonymous, !user.anonymous)
end
