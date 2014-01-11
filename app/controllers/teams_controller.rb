class TeamsController < ApplicationController
  before_filter :find_user

  def new
    if signed_in?
      @team = Team.new
    else
      flash[:alert] = "You must sign in first!"
      redirect_to new_user_session_path
    end
  end

  def create
    @team = Team.new(params[:team].permit(:name, :hospital_id))
    if @team.save
      Membership.create!(team: @team, user: @user)
      flash[:notice] = "Thank you for the submission"
      redirect_to @team
    else
      flash[:alert] = "Team was not created"
      render action: "new"
    end
  end

  def show
    @team = Team.find(params[:id])
  end

  private

  def find_user
    @user = current_user
  end    
end
