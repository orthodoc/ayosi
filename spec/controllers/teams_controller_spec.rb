require 'spec_helper'

describe TeamsController do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @hospital = FactoryGirl.create(:hospital)
    @designation = FactoryGirl.create(:designation, user: @user, hospital: @hospital)
  end

  context "for a signed in doctor" do

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

  context "for a visitor" do

    before(:each) do
      sign_out @user
      get :new
    end

    it { should redirect_to(new_user_session_path) }
    it { should set_the_flash[:alert].to("You must sign in first!") }
  end

  context "for a signed in hospital staff other than doctor" do

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


end
