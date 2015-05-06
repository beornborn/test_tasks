task :follow_notify_enable_1 => :environment do

puts "change follow notification options"
   User.update_all({:follow_notification_enable=>true})
   User.update_all({:follow_notification_enable=>false, :product_notification_enable=>false, :account_product_notification_enable=>false}, :user_name=>["drentitys", "Doctorentitys", "Dr.entitys", "Dr. entitys", "Doctorentity", "Dentitys", "Dctrentitys", "Drentity", "Doctorentity", "dentity", "Anonymous"])
end