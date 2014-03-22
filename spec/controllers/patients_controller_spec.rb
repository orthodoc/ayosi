require 'spec_helper'

describe PatientsController do

  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  context "for a signed in user" do
    before(:each) do
      sign_in @user
      get :new
    end
    it { should route(:get, 'patients/new').to(action: :new) }
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
end
