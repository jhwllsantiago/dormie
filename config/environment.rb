# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

Rails.application.configure do
  config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag.html_safe }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 465,
    domain: "gmail.com",
    user_name: ENV["USERNAME"],
    password: ENV["PASSWORD"],
    authentication: "plain",
    :ssl => true,
    :tsl => true,
    enable_starttls_auto: true
  }
end