class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def loged_in?
    if current_user != nil
      true
    end
  end
  helper_method :loged_in?

  def check_and_redirect
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    if @current_user == nil
      redirect_to "/log_in", :notice => "Faça log in para ter acesso"
    end
  end
  helper_method :check_and_redirect

  def emails_status
    @total_emails = 0
    @your_emails = 0
    @newest_emails = 0


    @total_emails = Email.where("visibility = ? OR user_id = ?", "Public",current_user).count
    @your_emails = Email.where(user: current_user).count
    @newest_emails = Email.where("visibility = ? OR user_id = ?", "Public",current_user).where(created_at: (Time.now - 1.day)..Time.now).count
  end
  helper_method :emails_status

  def projects_status
    @total_projects = 0
    @your_projects = 0
    @private_projects = 0


    @total_projects = Project.public_or_yours(current_user).count
    @your_projects = Project.where(user: current_user).count
    @private_projects = Project.private_or_yours(current_user).count
    @urgent_projects = Project.public_or_yours(current_user).high_urgency.count
  end
  helper_method :projects_status

  def activities_status
    @total_activities = 0
    @your_activities = 0
    @private_activities = 0
    @urgent_activities = 0


    @total_activities = Activity.public_or_yours(current_user).count
    @your_activities = Activity.where(user: current_user).count
    @private_activities = Activity.private_or_yours(current_user).count
    @urgent_activities = Activity.public_or_yours(current_user).high_urgency.count


  end
  helper_method :activities_status
end
