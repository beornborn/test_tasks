class TicketsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create, :update, :show]
  before_action :set_ticket, only: [:update]

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      TicketMailer.ticket_created(@ticket).deliver_later
      redirect_to({ action: :new }, notice: 'Ticket was successfully created.')
    else
      render :new
    end
  end

  def update
    if @ticket.update(ticket_params)
      @ticket.send("#{params[:event]}!") if params[:event].present?
      redirect_to ticket_path(id: @ticket.uref), notice: 'Ticket was successfully updated.'
    else
      render :show
    end
  end

  def show
    @ticket = Ticket.find_by(uref: params[:id])

    redirect_to({ action: :new }, alert: "Ticket ##{params[:id]} doesn't exist.") and return unless @ticket
  end

  def index
    @tickets_fresh = Ticket.fresh
    @tickets_in_process = Ticket.in_process
    @tickets_done = Ticket.done
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:name, :email, :department, :subject, :description, :user_id)
  end
end
