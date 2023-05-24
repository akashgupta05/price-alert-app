class UserMailer < ApplicationMailer
  def price_alert_email
    @user = params[:user]
    @alert = params[:alert]
    mail(to: @user.email, subject: 'Price Alert Triggered')
  end
end
