# encoding: UTF-8

class SupportMailer < ActionMailer::Base
  default to: Settings.mail.contact_mail

  def contact_message(message)
    @message = message

    mail from: @message.email,
         subject: 'Contact message'
  end
end
