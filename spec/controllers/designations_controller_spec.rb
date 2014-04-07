require 'spec_helper'

describe DesignationsController do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @hospital = FactoryGirl.create(:hospital)
  end

  context "when a signed in user gets new designation" do
    
    before(:each) do
      sign_in @user
      get :new
    end

    it { should route(:get, 'designations/new').to(action: :new) }
    it { should respond_with(:success) }
    it { should render_template(:new) }
    it { should_not set_the_flash }
    it { assigns(:user).should eq(UserDecorator.decorate(@user)) }

  end

  context "when a visitor gets new designation" do

    before(:each) do
      get :new
    end

    it { should redirect_to(new_user_session_path) }
    it { should set_the_flash[:alert].to("You must sign in first!") }
  end

  context "when user creates with valid attributes" do

    before(:each) do
      sign_in @user
      @designation = FactoryGirl.attributes_for(:designation, user_id: @user.id, hospital_id: @hospital.id)
      post :create, designation: @designation
    end
    
    it { expect change(Designation, :count).by(1) }
    it { should set_the_flash[:notice].to("Thank you for the submission") }
    it { should redirect_to user_path(@user) }

  end

  context "when user creates with invalid attributes" do
    before(:each) do
      sign_in @user
      @invalid_designation = FactoryGirl.attributes_for(:designation, user_id: nil, hospital_id: nil)
      post :create, designation: @invalid_designation
    end

    it { expect change(Designation, :count).by(0) }
    it { should set_the_flash[:alert].to("Role was not created") }
    it { should render_template(:new) }
  end

  context "when editing by" do
    
    before(:each) do
      @designation = FactoryGirl.create(:designation)
    end

    context "signed in user" do
      before(:each) do
        sign_in @user
        get :edit, id: @designation.id
      end

      it { should respond_with(:success) }
      it { should render_template(:edit) }
      it { should_not set_the_flash }
    end

    context "signed out user" do
      before(:each) do
        sign_out @user
        get :edit, id: @designation.id
      end

      it { should_not render_template(:edit) }
      it { should set_the_flash[:alert].to("You have to sign in first!") }
      it { should redirect_to(new_user_session_path) }
    end

  end

  context "when updateing designation" do
    before(:each) do
      sign_in @user
      @designation = FactoryGirl.create(:designation)
    end

    context "with valid attributes" do
      before(:each) do
        @new_designation = FactoryGirl.attributes_for(:designation)
        patch :update, id: @designation.id, designation: @new_designation
        @designation.reload
      end

      it { expect(@designation.name).to eq(@new_designation[:name]) }
      it { should set_the_flash[:notice].to("Designation has been updated") }
      it { should redirect_to(user_path(@user)) }
    end

    context "with invlaid attributes" do
      before(:each) do
        @invalid_designation = FactoryGirl.attributes_for(:designation, name: nil)
        patch :update, id: @designation, designation: @invalid_designation
        @designation.reload
      end

      it { expect(@designation.name).not_to eq(@invalid_designation[:name]) }
      it { should render_template(:edit) }
      it { should set_the_flash[:alert].to("Designation has not been updated") }
    end
  end

  context "where making a designation default" do
    before(:each) do
      sign_in @user
      @designation = FactoryGirl.create(:designation)
    end
    context "when its not default" do
      before(:each) do
        @designation.update_attributes(is_default: false)
        @new_designation = FactoryGirl.build_stubbed(:designation, is_default: true)
        put :make_default, designation_id: @designation.id, designation: @new_designation[:is_default]
        @designation.reload
      end

      it { expect(@designation.is_default).to eq(true) }
      it { should set_the_flash[:notice].to("Designation was made default") }
      it { should redirect_to(user_path(@user)) }
    end

    context "without making a selection" do
      before(:each) do
        put :make_default, designation_id: nil
      end

      it { should set_the_flash[:alert].to("Select any one designation to make default")}
      it { should redirect_to(user_path(@user)) }
    end
  end

  context "when deleting a designation" do
    before(:each) do
      sign_in @user
      @designation = FactoryGirl.create(:designation)
      delete :destroy, id: @designation.id
    end

    it { expect change(Designation, :coutn).by(-1) }
    it { should redirect_to(user_path(@user)) }
  end

end
