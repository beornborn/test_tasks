module entitysHelper
  def formatentityDate(from_time, to_time = 0, include_seconds = false, options = {})
    from_time = from_time.to_time if from_time.respond_to?(:to_time)
    to_time = Time.now
    distance_in_minutes = (((to_time - from_time).abs)/60).round

    case distance_in_minutes
      when 0..59
        return distance_in_minutes.to_s + "m"
      when 60..1439 then (distance_in_minutes.to_f / 60.0).round.to_s + "h"
      else
        (distance_in_minutes.to_f / 1440.0).round.to_s + "d"
    end
  end

  def formatentityLikeNumber(entity, type)
    likesNumber = entity.entitys_ratings.all.size
    if likesNumber > 0
      if(type == "my_entity")
        return "<div id=\"my_rating_count_"+entity.id.to_s(10)+"\" class=\"entity_likecount\">" + pluralize(likesNumber, "like") + "</div>"
      else
        return "<div id=\"rating_count_"+entity.id.to_s(10)+"\" class=\"entity_likecount\">" + pluralize(likesNumber, "like") + "</div>"
      end
    else
      if(type == "my_entity")
        return "<div id=\"my_rating_count_"+entity.id.to_s(10)+"\" class=\"entity_likecount\" style=\"display:none\"></div>"
      else
        return "<div id=\"rating_count_"+entity.id.to_s(10)+"\" class=\"entity_likecount\" style=\"display:none\"></div>"
      end
    end
  end

  def getUserAvatarLink(entity)
    url_link = entity.anonymous ? search_entitys_path+"?q=Anonymous" : search_entitys_path+"?q="+entity.user.user_name
    link_to image_tag(getUserAvatar(entity), class: "fl-l", alt: "Avatar", size: "48x48"), url_link
  end

  def getUserName(entity)
    text_link = entity.anonymous ? "Anonymous" : truncate(entity.user.user_name, :length => 30)
    url_link = entity.anonymous ? search_entitys_path+"?q=Anonymous" : search_entitys_path+"?q="+entity.user.user_name
    link_to text_link, url_link, {class: "black_link"}
  end
  
  def getUserNameBfComment(bf_comment)
    text_link = bf_comment.anonymous ? "Anonymous" : truncate(bf_comment.user.user_name, :length => 35)
    url_link = bf_comment.anonymous ? search_entitys_path+"?q=Anonymous" : search_entitys_path+"?q="+bf_comment.user.user_name
    link_to text_link, url_link, {class: "gray_link"}
  end

  def  getUserAvatar(entity)
    if entity.anonymous or entity.user.email =="entitysanonim@entitysanonim.entitysanonim"
      return "anonym.png"
    else
      return entity.user.avatar.thumb.url+((current_user and (entity.user.id == current_user.id)) ? '?'+Time.now.to_i.to_s : "") if entity.user.avatar.present?
      return "nopic.png"
    end
  end
  
  def  getUserAvatarForProfile(user)
    return user.avatar.thumb.url if user.avatar.present?
    return "nopic.png"
  end

  def getViewAllCommentsFromAllPages(entity)
    if entity.replies.size==1 then
      return "view 1 comment"
    end
      return "view all "+entity.replies.size.to_s(10)+" comments"
  end

  def getViewAllCommentsLinkTitle(entity, page)
         if entity.replies.size==1 then
      return "view 1 comment"
     end
    if entity.replies.size > 20
      n = entity.replies.size - (page - 1)*20
      if page == 1
        return "view first 20 of "+entity.replies.size.to_s(10)+" comments"
      elsif n >= 20
        return "view next 20 of "+entity.replies.size.to_s(10)+" comments"
      else
        return "view last "+n.to_s(10)+" of "+entity.replies.size.to_s(10)+" comments"
      end
    else
      return "view all "+entity.replies.size.to_s(10)+" comments"
    end
  end
  
  def getViewAllCommentsLinkTitleBfComments(breakingentity, page)
    if breakingentity.bf_comments.size > 20
      n = breakingentity.bf_comments.size - (page - 1)*20
      if page == 1
        return "view first 20 of "+breakingentity.bf_comments.size.to_s(10)+" comments"
      elsif n >= 20
        return "view next 20 of "+breakingentity.bf_comments.size.to_s(10)+" comments"
      else
        return "view last "+n.to_s(10)+" of "+breakingentity.bf_comments.size.to_s(10)+" comments"
      end
    else
      return "view all "+breakingentity.bf_comments.size.to_s(10)+" comments"
    end
  end

  #def getCollapseAllCommentsLinkTitle(entity, page)
    #if( entity.replies.size < 20 || (page - 1)*20 > entity.replies.size)
      #return "Collapse all "+entity.replies.size.to_s(10)+" comments"
    #else
      #n = (page -1)*20
      #return "Collapse all "+n.to_s(10)+" comments"
    #end
  #end

  def getViewAllCommentsLinkState(entity, page)
    return entity.replies.size - (page - 1)*20 > 0 ? "comments_viewmore_button btn_sml" : "comments_viewmore_button btn_sml no-disp"
  end
  
  def getViewAllCommentsLinkStateBfComments(breakingentity, page)
    return breakingentity.bf_comments.size - (page - 1)*20 > 0 ? "comments_viewmore_button btn_sml" : "comments_viewmore_button btn_sml no-disp"
  end

  def setNotificationRead(entity)
    notification = Notification.where(:entity_id=>entity.id).first
    notification.present? ? notification.update_attributes(:read=>true) : ""
  end
  
  def getYoutubeSearchvideo(link)
    if link.present? 
      begin
        entity_video = YoutubeSearch.search(link)
       
        if entity_video.first.present? and 
          entity_video.first.has_key?('embeddable') and
          entity_video.first['embeddable'] and
          !entity_video.first.has_key?('racy')
       
          return "<div class='video_body'><object width='420' height='315'><param name='movie' value='http://www.youtube.com/v/#{entity_video.first['video_id']}?version=3&amp;hl=en_US'></param><param name='allowFullScreen' value='true'></param><param name='allowscriptaccess' value='always'></param><param name='wmode' value='opaque'></param><embed src='http://www.youtube.com/v/#{entity_video.first['video_id']}?version=3&amp;hl=en_US' type='application/x-shockwave-flash' width='420' height='315' allowscriptaccess='always' allowfullscreen='true' wmode='opaque'></embed></object></div>"
        else
          return ''
        end
      resque
        return ''
      end
    else
      return ''
    end
  end
end
