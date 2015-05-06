require "csv"

task :rename_to_entityber_via=> :environment do
  puts "put entityber via"
  @user=User.where(:user_name=>"Anonymous").first
  if  @user.present?
  @user.update_attributes(:user_name=>"entityber via")
  @user.update_attributes(:anonymous=>false)
  @user.save(:validate=> false)
  else
    puts "no 1Anonymous user"
  end

  @user=User.where(:user_name=>"entityer via").first
  if  @user.present?
  @user.update_attributes(:user_name=>"entityber via")
  @user.update_attributes(:anonymous=>false)
  @user.save(:validate=> false)
  else
    puts "no 2Anonymous user"
  end

  @user=User.where(:user_name=>"entityber via").first
  if  @user.present?
  @user.update_attributes(:anonymous=>false)
  @user.save(:validate=> false)
  else
    puts "no 3Anonymous user"
  end
end
