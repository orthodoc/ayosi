require 'spec_helper'

describe PatientsController do

  context "for a signed in user" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @hospital = FactoryGirl.create(:hospital)
      @designation = FactoryGirl.create(:designation, user: @user, hospital: @hospital)
      sign_in @user
      get :new
    end

    it { should route(:get, 'patients/new').to(action: :new) }
    it { should respond_with(:success) }
    it { should render_template(:new) }
    it { should_not set_the_flash }

  end
end
