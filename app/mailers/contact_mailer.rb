class ContactMailer < ActionMailer::Base
  def welcome(user, password, app_domain)
    @user = user
    @password = password
    @app_domain = app_domain

    mail(to: @user.email, subject: "Welcome #{@user.full_name} | Runa Checker")
  end
end
