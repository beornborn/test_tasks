task :auto_get_tweets => :environment do
  puts "get recent tweets"
  user=User.where(:user_name=>"entityer via").first
    entitys_tweets = Twitter.search("#entitys", :rpp=>10, :since_id=>(user.zip_code))
    lastid=entitys_tweets.map.max { |x,y| x.id <=> y.id }.id if entitys_tweets.present?
    entitys = entity.find(:all)
    entitys_tweets.keep_if {|tweet| entitys.keep_if {|a| tweet.text==a.body or tweet.text.include? "RT @"}.blank?}
    entitys_tweets.map.each {|n|
      entity = entity.create
      entity.body=n.text
      entity.user_id=user.id
      entity.anonymous = user.anonymous
       if  Rakismet.akismet_call('comment-check', {:comment_type=>'comment', :content=>entity.body,
             :user_ip => "192.168.1.1"})=='false'
       entity.save
      StatsMix.track("Post",1,{:meta=>{"layout"=>"desktop"}}) if ENV["entityS_HOST"] == 'www.entitys.com'
      StatsMix.track("Post staging",1,{:meta=>{"layout"=>"desktop"}}) if ENV["entityS_HOST"] != 'www.entitys.com'
      puts "tweet was created"
      else puts "tweet is spam"
      end
    }
    user.update_attribute("zip_code", lastid+1) if lastid.present?
  end
