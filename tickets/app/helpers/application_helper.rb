module ApplicationHelper
  def login_page
    controller_name == 'user_sessions' && action_name == 'new'
  end

  def label_for_ticket ticket
    {
      waiting_for_staff_response: ticket.user_id ? 'warning' : 'info',
      waiting_for_customer: 'warning',
      on_hold: 'warning',
      cancelled: 'danger',
      completed: 'success'
    }[ticket.current_state]
  end
end
