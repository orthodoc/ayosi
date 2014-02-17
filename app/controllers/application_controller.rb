class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  helper_method :display_name
  helper_method :is_doctor?
  helper_method :team_owner
  helper_method :team_owner?

  def display_name
    name.titleize
  end

  def is_doctor?
    current_user.has_role? :doctor
  end

  def team_owner
    @team.user.name.titleize
  end

  def team_owner?
    Team.where(user: current_user).count > 0
  end

end
