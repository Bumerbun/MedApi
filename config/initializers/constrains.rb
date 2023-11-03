#
# SENSITIVE = Rails.application.config_for :sensitive_config
#
# Rails.application.configure do
#   config.action_mailer.delivery_method = :smtp
#   config.action_mailer.smtp_settings = {
#     address: SENSITIVE.smtp[:address],
#     port: SENSITIVE.smtp[:port],
#     user_name: SENSITIVE.smtp[:user_name],
#     password: SENSITIVE.smtp[:password]
#   }
# end