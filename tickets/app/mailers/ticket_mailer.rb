class TicketMailer < ApplicationMailer
  def ticket_created(ticket)
    @ticket = ticket
    mail(to: @ticket.email, subject: 'Ticket was succesfully created and will be proceeded soon')
  end
end
