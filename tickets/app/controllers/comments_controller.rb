class CommentsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]
  before_action :set_ticket, only: :create

  def new
    @comment = Comment.new
  end

  def create
    @comment = @ticket.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      # CommentMailer.comment_created(@comment).deliver_later
      redirect_to(ticket_path(id: @ticket.uref), notice: 'Comment was successfully created.')
    else
      render 'tickets/show'
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
