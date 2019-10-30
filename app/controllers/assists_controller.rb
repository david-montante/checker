class AssistsController < ApplicationController
  before_action :authenticate_user!

  before_action :is_user, :only => [:check_in, :check_out]

  def index
    @assists = current_user.assists.completed.this_month.ordered if current_user.user?
    @assists = Assist.all.completed.this_month.ordered if current_user.admin?
  end
  
  def check_in
    unless current_user.assists.today.blank?
      redirect_to dashboard_users_path
      flash[:error] = "You have already checked-in today"
      return
    end
    current_user.assists << Assist.new(check_in: Time.now)
    redirect_to dashboard_users_path
    flash[:success] = "Have a nice day!"
  end

  def check_out
    today = current_user.assists.today.last
    if today.blank?
      redirect_to dashboard_users_path
      flash[:error] = "You haven't checked in!"
      return
    end
    unless today.check_out.blank?
      redirect_to dashboard_users_path
      flash[:error] = "You had already checked out!"
      return
    end
    today.update(check_out: Time.now)
    redirect_to dashboard_users_path
    flash[:success] = "Have a good rest!"
  end

  private 

  def is_user
    if current_user.admin?
      redirect_to dashboard_users_path
      flash[:info] = "Only users can check!"
      return
    end
  end
end
