require 'spec_helper'

describe TeamsController do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @hospital = FactoryGirl.create(:hospital)
    @designation = FactoryGirl.create(:designation, user: @user, hospital: @hospital)
  end

  context "when a signed in doctor gets new team" do

    before(:each) do
      @user.add_role :doctor
      sign_in @user
      get :new
    end

    it { should route(:get, 'teams/new').to(action: :new) }
    it { should respond_with(:success) }
    it { should render_template(:new) }
    it { should_not set_the_flash }

  end

  context "when a visitor gets new team" do

    before(:each) do
      sign_out @user
      get :new
    end

    it { should redirect_to(new_user_session_path) }
    it { should set_the_flash[:alert].to("You must sign in first!") }
  end

  context "when a signed in hospital staff other than doctor gets new team" do

    before(:each) do
      sign_in @user
      [:nurse, :physio, :data_operator, :secretary, :office_manager].each do |rrole|
        @user.add_role rrole
      end
      get :new
    end

    it { should redirect_to(user_path(@user)) }
    it { should set_the_flash[:alert].to("Only doctors can form a team") }
  end

  context "when any signed in user visits team page" do

    before(:each) do
      @team = FactoryGirl.create(:team)
      sign_in @user
      get :show, id: @team.id
    end

    it { should respond_with(:success) }
    it { should render_template(:show) }
    it { should_not set_the_flash }
  end

  context "when a visitor visits team page" do

    before(:each) do
      @team = FactoryGirl.create(:team)
      sign_out @user
      get :show, id: @team.id
    end

    it { should_not respond_with(:success) }
    it { should_not render_template(:show) }
    it { should set_the_flash[:alert].to("You have to sign in first!") }
  end

  context "when a singed in doctor edits team" do

    before(:each) do
      @team = FactoryGirl.create(:team)
      sign_in @user
      @user.add_role :doctor
      get :edit, id: @team.id
    end

    it { should respond_with(:success) }
    it { should render_template(:edit) }
    it { should_not set_the_flash }
  end

  context "when a nurse edits team" do

    before(:each) do
      @team = FactoryGirl.create(:team)
      sign_in @user
      @user.add_role :nurse
      get :edit, id: @team.id
    end

    it { should_not respond_with(:success) }
    it { should_not render_template(:edit) }
    it { should set_the_flash[:alert].to("Only doctors can edit a team") }
  end

  context "when updating a team" do

    before(:each) do
      sign_in @user
      @team = FactoryGirl.create(:team)
    end

    context "with valid attributes" do
      before(:each) do
        @new_team = FactoryGirl.attributes_for(:team)
        patch :update, id: @team, team: @new_team
        @team.reload
      end

      it { expect(@team.name).to eq(@new_team[:name]) }
      it { should set_the_flash[:notice].to("Team has been updated") }
      it { should redirect_to(team_path(@team)) }

    end

    context "with invalid attributes" do
      before(:each) do
        @invalid_team = FactoryGirl.attributes_for(:team, name: nil)
        patch :update, id: @team, team: @invalid_team
        @team.reload
      end

      it { expect(@team.name).not_to eq(@invalid_team[:name]) }
      it { should render_template(:edit) }
      it { should set_the_flash[:alert].to("Team has not been updated") }
    end

  end

  context "when deleting a team" do
    before(:each) do
      sign_in @user
      @team = FactoryGirl.create(:team)
      delete :destroy, id: @team.id
    end

    it { expect change(Team, :count).by(-1) }
    it { should redirect_to(user_path(@user)) }
  end

end
