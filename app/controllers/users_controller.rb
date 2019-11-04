class UsersController < ApplicationController
  require 'securerandom'

  def new
    @user = User.new
  end

  def admin_create
    @user = User.new(user_params)
    password = SecureRandom.hex(8)
    @user.password = password
    if @user.save
      redirect_to dashboard_users_path
      flash[:success] = "The user was created"
      ContactMailer.welcome(@user, password, ENV['APP_DOMAIN']).deliver
    else
      redirect_to new_user_path,
                  flash: { error: @user.errors.full_messages.to_sentence }
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
