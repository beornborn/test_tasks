module ApplicationHelper

  def getTruncatedUserNameCustom(user, length)
    return truncate user.user_name, :length => length
  end

  def my_notifications_count
    Notification.where(:user_id=>current_user.id, :read=>false).order("created_at desc").count if current_user.present?
  end

  def truncate_words(text, length = 30, end_string = " ...", entity_id = nil)
#    words = text.split()
#
#    words[0..(length-1)].join(' ') + (words.length > length ? end_string : '')

    prefix_http = "http://"
    prefix_https = "https://"
    prefix_ftp = "ftp://"
    twitter_url=  "http://www.twitter.com/"

    text.gsub(/\B(#\b+)\S+/i){|s|
      link_to(s, search_entitys_path(:tag => s[1..-1].downcase), :style=>"color:red;", :class=>"bold700")}
      .gsub(/(http:\/\/|www\.)\S*/i){|s|
      s.slice!(prefix_http); link_to(s, prefix_http+s, :style=>"color:red;", :target=>"_blank")}
      .gsub(/https:\/\/\S*/i){|s|
      s.slice!(prefix_https); link_to(s, prefix_https+s, :style=>"color:red;", :target=>"_blank")}
      .gsub(/ftp:\/\/\S*/i){|s|
      s.slice!(prefix_ftp); link_to(s, prefix_ftp+s, :style=>"color:red;", :target=>"_blank")}
      .gsub(/@\w*/i){|s|
      s.slice!("@"); link_to("@"+s, twitter_url+s, :style=>"color:red;", :class=>"bold700", :target=>"_blank")}
  end

end
