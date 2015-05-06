class BreakingentitysController < ApplicationController
  before_filter :user_logged_in, :only => [:rate_up, :create_bf_comment]
  
  def rate_up
    f = BreakingentitysRating.create(:user_id => current_user.id, :breakingentity_id => params[:id])
    render :text=> f.errors.blank? ? Breakingentity.find(params[:id]).breakingentitys_ratings.all.size : f.errors.messages.values.flatten.join("<br/>") and return
  end

 def load_comments
    page = params[:page].to_i
    breakingentity = Breakingentity.find params[:id]
    bf_comments = breakingentity.bf_comments.order("created_at ASC").page(page).per(20)
    if(page > 1)
      render :partial=> "entitys/bf_comments_lazy_load",
             :locals => {:breakingentity => breakingentity, :page=>Integer(page)+1}, :layout=>false and return
    else
      render :partial=> "entitys/bf_comments_expanded",
             :locals => {:breakingentity => breakingentity, :page=>Integer(page)+1}, :layout=>false and return
    end
  end

  def collapse_comments
    breakingentity = Breakingentity.find params[:id]
    render :partial=> "entitys/bf_comments_collapsed", :locals => {:breakingentity => breakingentity}, :layout=>false and return
  end
  
  def create_bf_comment
    bf_comment = BfComment.create
    bf_comment.body = helpers.sanitize(params[:bf_comment][:body], :tags => %w())
    bf_comment.user_id = current_user.id
    bf_comment.breakingentity_id = params[:bf_comment][:breakingentity_id]
    bf_comment.anonymous = current_user.anonymous

    if bf_comment.spam?
      render :text=>"Your entity contains spam content. Please rewrite it in another way.", :layout=>false and return
    end
    bf_comment.save
    
    breakingentity = Breakingentity.find bf_comment.breakingentity_id
    
#    share = Hash.new
#    share["twitter"] = entity.id if params[:postentity_twitter]
#    share["facebook"] = entity.id if params[:postentity_facebook]
#    share["body_entity"] = entity.body if (params[:postentity_facebook] or params[:postentity_twitter])

#    flash[:share_params] = share if share.present?

    render :partial=> "entitys/bf_comments_collapsed", :locals => {:breakingentity => breakingentity}, :layout=>false and return
  end
  
  private

  def user_logged_in
    if current_user.blank?
      render :text => "Please Login first.", :status=>404 and return if request.xhr?
    end
  end
end
