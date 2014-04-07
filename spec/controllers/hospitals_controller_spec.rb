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

  describe "when visiting the hospital page" do
    before(:each) do
      @hospital = FactoryGirl.create(:hospital)
      get :show, id: @hospital.id
    end
    it { should respond_with(:success) }
    it { should render_template(:show) }
    it { should_not set_the_flash }
  end

  describe "when editing the hospital" do
    let(:admin) { FactoryGirl.create(:user) }
    context "as an admin" do
      before(:each) do
        sign_in admin
        admin.add_role :admin
        @hospital = FactoryGirl.create(:hospital)
        get :edit, id: @hospital.id
      end

      it { should respond_with(:success) }
      it { should render_template(:edit) }
      it { should_not set_the_flash }
    end

    context "as a user" do
      before(:each) do
        sign_in user
        @hospital = FactoryGirl.create(:hospital)
        @request.env['HTTP_REFERER'] = hospital_path(@hospital)
        get :edit, id: @hospital.id
      end

      it { should_not respond_with(:success) }
      it { should_not render_template(:edit) }
      it { should set_the_flash[:alert].to("Only an admin can change the hospital details") }
      it { should redirect_to(hospital_path(@hospital)) }
    end
  end

end
