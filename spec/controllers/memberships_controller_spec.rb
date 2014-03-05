require 'spec_helper'

describe MembershipsController do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @team = FactoryGirl.create(:team, user: @user)
    sign_in @user
    member_list = FactoryGirl.create_list(:user, 2)
    member_list.each do |m|
      @team.members << m
    end
    @membership = @team.members.first.memberships.find_by(team: @team)
    @request.env['HTTP_REFERER'] = team_path(@team)
  end

  context "when signed in team owner removes member" do
    before(:each) do
      delete :destroy, id: @membership.id
    end

    it { expect change(Membership, :count).by(-1) }
    it { should set_the_flash[:alert].to("Membership has been deleted")}
    it { should redirect_to(team_path(@team)) }
  end

  context "when signed out user removes member" do
    before(:each) do
      sign_out @user
      delete :destroy, id: @membership.id
    end

    it { expect change(Membership, :count).by(0) }
    it { should set_the_flash[:alert].to("You have to sign in first!") }
    it { should redirect_to(new_user_session_path) }
  end

  context "when requesting on an inactive membership"do
    before(:each) do
      post :requesting, id: @membership.id
      @membership.reload
    end

    it { expect(@membership.aasm_state).to eq("pending") }
    it { should set_the_flash[:notice].to("Request submitted!") }
    it { should redirect_to(user_path(@user)) }

    context "and activation of pending membership" do
      before(:each) do
        post :activating, id: @membership.id
        @membership.reload
      end

      it { expect(@membership.aasm_state).to eq("active") }
      it { should set_the_flash[:notice].to("Membership activated!") }
      it { should redirect_to(@team) }
    end

    context "and rejecting a pending membership" do
      before(:each) do
        post :rejecting, id: @membership.id
        @membership.reload
      end

      it { expect(@membership.aasm_state).to eq("rejected") }
      it { should set_the_flash[:alert].to("Membership was rejected!") }
      it { should redirect_to(@team) }

      context "and banning a rejected member" do
        before(:each) do
          post :banning, id: @membership.id
          @membership.reload
        end

        it { expect(@membership.aasm_state).to eq("banned") }
        it { should set_the_flash[:notice].to("Member has been banned!") }
        it { should redirect_to(@team) }
      end
    end

    context "or banning a pending membership" do
      before(:each) do
        post :banning, id: @membership.id
        @membership.reload
      end

      it { expect(@membership.aasm_state).to eq("banned") }
      it { should set_the_flash[:notice].to("Member has been banned!") }
      it { should redirect_to(@team) }
    end
  end

  context "when activating an inactive membership" do
    before(:each) do
      post :activating, id: @membership.id
      @membership.reload
    end

    it { expect(@membership.aasm_state).to eq("active") }
    it { should set_the_flash[:notice].to("Membership activated!") }
    it { should redirect_to(@team) }

    context "and deactivating active membership" do
      before(:each) do
        post :deactivating, id: @membership.id
        @membership.reload
      end

      it { expect(@membership.aasm_state).to eq("inactive") }
      it { should set_the_flash[:notice].to("Membership was deactivated!") }
      it { should redirect_to(@team) }
    end

    context "and banning active member" do
      before(:each) do
        post :banning, id: @membership.id
        @membership.reload
      end

      it { expect(@membership.aasm_state).to eq("banned") }
      it { should set_the_flash[:notice].to("Member has been banned!") }
      it { should redirect_to(@team) }
    end

    context "and resigning from active membership" do
      before(:each) do
        post :resigning, id: @membership.id
        @membership.reload
      end

      it { expect(@membership.aasm_state).to eq("inactive") }
      it { should set_the_flash[:alert].to("You have resigned as a member!") }
      it { should redirect_to(@team) }
    end
  end


end
