task :create_notlogin_anonym_user => :environment do

  user = User.where(["user_name = ?", "AnonymousNotLogged"]).first
  if user.present?
    user.user_name = "AnonymousNotLogged." 
    user.save
  end  

  puts "creating AnonymousNotLogged user"
        user=User.new({:name=> "AnonymousNotLogged", :user_name=> "AnonymousNotLogged", :password=>"123527890vj07y52o0ry0ayeot5ghoery674", :zip_code=> "99999", :dob=>"9/9/1999", :email=>   "anonymousnotlogged@anonymousnotlogged.anonymousnotlogged", :gender=> "M", :confirmed_at=> DateTime.now, :anonymous=>"1"})
        user.skip_confirmation!
        user.save(:validate=> false)
        user.update_attribute(:anonymous, !user.anonymous)
end