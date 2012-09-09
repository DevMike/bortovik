class HomeController < ApplicationController
  skip_before_filter :authenticate_user!

  def contact
    @contact_message = ContactMessage.new
  end

  def contact_message
    @contact_message = ContactMessage.new(params[:contact_message])
    if @contact_message.valid?
      SupportMailer.contact_message(@contact_message).deliver
      redirect_to contact_url, :notice => I18n.t(:'home.contact_message.greetings')
    else
      render :contact
    end
  end
end
