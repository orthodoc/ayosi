require 'spec_helper'

describe UsersController do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @hospital = FactoryGirl.create(:hospital)
    @designation = FactoryGirl.create(:designation, user: @user, hospital: @hospital)
    @designations = @user.designations
  end

  context "for a signed in user" do

    before(:each) do
      sign_in @user
      get :show, id: @user.id
    end

    it { should respond_with(:success) }
    it { should render_template(:show) }
    it { should_not set_the_flash }
  end

  context "for a visitor" do
    before(:each) do
      sign_out @user
      get :show, id: @user.id
    end

    it { should_not respond_with(:success) }
    it { should_not render_template(:show) }
    it { should set_the_flash[:alert].to("You must sign in first!") }

  end

end
