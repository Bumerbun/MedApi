class UserMailer < ApplicationMailer
  @@mail_subject = "New recommendation on consultation request"
  def new_recommendation(recipient, text)
    @recommendation_text = text
    mail(to: recipient, subject: @@mail_subject)
  end
end
