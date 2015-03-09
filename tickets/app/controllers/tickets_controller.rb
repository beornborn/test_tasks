class TicketsController < ApplicationController
  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(controller_params)

    if @ticket.save
      redirect_to({ action: :new }, notice: 'Ticket was successfully created.')
    else
      render :new
    end
  end

  private

  def controller_params
    params.require(:ticket).permit(:name, :email, :department, :subject, :description)
  end
end
