module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?
    
    messages = resource.errors.full_messages.map do |msg|
      msg = "Email address has already been taken" if msg == "Email has already been taken"
      msg = "You must be at least 13 years old to sign up" if msg == "Dob You must be at least 13 years old to sign up"
      content_tag(:li, msg)
    end.join



    sentence = I18n.t("errors.messages.not_saved",
      :count => resource.errors.count,
      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
      <h2>The following errors occurred:</h2>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end