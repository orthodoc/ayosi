require 'spec_helper'

describe UsersController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @hospital = FactoryGirl.create(:hospital)
    @designation = FactoryGirl.create(:designation, user: @user, hospital: @hospital)
    @designations = @user.designations
  end

  context "where a signed in user gets the show page" do
    before(:each) do
      sign_in @user
      get :show, id: @user.id
    end
    it { assigns(:user).should eq(UserDecorator.decorate(@user)) }
    it { assigns(:designations).should eq(DesignationDecorator.decorate(@designations)) }
    it { should respond_with(:success) }
    it { should render_template(:show) }
    it { should_not set_the_flash }
  end

  context "where a visitor gets the show page" do
    before(:each) do
      sign_out @user
      get :show, id: @user.id
    end
    it { should_not respond_with(:success) }
    it { should_not render_template(:show) }
    it { should set_the_flash[:alert].to("You must sign in first!") }
  end

  context "when updating user" do

  end

  describe  "getting the users in a hospital" do
    context "when signed in" do
      before(:each) do
        sign_in @user
        @nurse_designation = FactoryGirl.create(:designation, hospital: @hospital)
        @nurse = @nurse_designation.user
        @secretary_designation = FactoryGirl.create(:designation, hospital: @hospital)
        @secretary = @secretary_designation.user
        @team = FactoryGirl.create(:team, user: @user, hospital: @hospital)
        get :index, on: hospital_users_path(@team.hospital_id)
      end
    end

    context "when signed out" do

    end

  end


end
