class TeamsController < ApplicationController
  before_filter :find_user

  def new
    if signed_in?
      if is_doctor?
        @team = Team.new
      else
        flash[:alert] = "Only doctors can form a team"
        redirect_to user_path(@user)
      end
    else
      flash[:alert] = "You must sign in first!"
      redirect_to new_user_session_path
    end
  end

  def create
    @team = Team.new(team_params)
    if @team.save!
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

  def edit
    if signed_in?
      @team = Team.find(params[:id])
    else
      flash[:alert] = "You have to sign in to update the team"
      redirect_to new_user_session_path
    end
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(team_params)
      flash[:notice] = "Team has been updated"
      redirect_to team_path(@team)
    else
      flash[:alert] = "Team has not been updated"
      render action: "edit"
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :hospital_id, :user_id, member_ids: [])
  end

  def find_user
    @user = current_user
  end    
end
