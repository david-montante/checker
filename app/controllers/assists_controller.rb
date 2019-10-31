class AssistsController < ApplicationController
  before_action :authenticate_user!

  before_action :is_user, :only => [:check_in, :check_out]
  before_action :is_admin, :only => [:report]

  def index
    if current_user.user?
      @assists = current_user.assists.completed.this_month.ordered
      return
    end
    @q = Assist.ransack(params[:q])
    @q.sorts = 'check_in desc' if @q.sorts.empty?
    @assists = @q.result.includes(:user).completed
  end

  def report
    @q = User.ransack(params[:q])
    @q.sorts = 'first_name desc' if @q.sorts.empty?
    @users = @q.result.uniq

    @a = Assist.ransack(ransack_params(params[:q]))
    @assists = @a.result.includes(:user).completed
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

  def is_admin
    if current_user.user?
      redirect_to dashboard_users_path
      flash[:info] = "Only admins can report!"
      return
    end
  end

  def ransack_params(params)
    return nil if params.blank?
    {
      "check_in_gteq" => params[:assists_check_in_gteq],
      "check_in_lteq" => params[:assists_check_in_lteq]
    }
  end
end
