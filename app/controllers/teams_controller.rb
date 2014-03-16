class TeamsController < ApplicationController
  before_filter :find_user
  before_filter :find_team, only: [:show, :edit, :update, :destroy]

  def new
    if signed_in?
      unless current_user.default_hospital.nil?
        if is_doctor?
          @team = Team.new
        else
          flash[:alert] = "Only doctors can form a team"
          redirect_to user_path(@user)
        end
      else
        flash[:alert] = "Please choose a hospital before you set a team"
        redirect_to new_designation_path
      end
    else
      flash[:alert] = "You must sign in first!"
      redirect_to new_user_session_path
    end
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      @team.members << @user unless @team.members.include?(@user)
      @team.owner.memberships.find_by(team: @team).activate!
      flash[:notice] = "Thank you for the submission"
      redirect_to @team
    else
      flash[:alert] = "Team was not created"
      render action: :new
    end
  end

  def show
    @members = @team.members
  end

  def edit
    if @team.owner == @user
      @team
    else
      flash[:alert] = "Only team owners can edit a team"
      redirect_to user_path(@user)
    end
  end

  def update
    if @team.update_attributes(team_params)
      flash[:notice] = "Team has been updated"
      redirect_to team_path(@team)
    else
      flash[:alert] = "Team has not been updated"
      render action: "edit"
    end
  end

  def destroy
    @team.destroy
    flash[:alert] = "Team #{@team.name} has been deleted!"
    redirect_to user_path(@user)
  end

  private

  def team_params
    params.require(:team).permit(:id, :name, :hospital_id, :user_id, :member_list )
  end

  def find_user
    @user = current_user
  end

  def find_team
    if signed_in?
      @team = TeamDecorator.find(params[:id])
    else
      flash[:alert] = "You have to sign in first!"
      redirect_to new_user_session_path
    end
  end
end
