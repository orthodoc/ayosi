require 'spec_helper'

describe HospitalsController do

  let(:user) { FactoryGirl.create(:user) }

  context "when user is signed in" do
    before(:each) do
      10.times { FactoryGirl.create(:hospital) }
      sign_in user
      get :index
    end

    it { should respond_with(:success) }
    it { should_not render_template(:index) }
    it { JSON.parse(response.body).should be_a_kind_of(Array) }
    it { JSON.parse(response.body).length.should eq 10 }
    it { should_not set_the_flash }
    it { assigns(:hospitals).should_not eq(HospitalDecorator.decorate(:hospital)) }
  end

  context "when user is signed out" do
    before(:each) do
      sign_out user
      get :index
    end

    it { should_not respond_with(:success) }
    it { should_not render_template(:index) }
    it { should set_the_flash[:alert].to("You have to sign in first!") }
  end

end
