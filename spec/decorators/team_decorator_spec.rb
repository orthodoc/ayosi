require 'spec_helper'

describe TeamDecorator do
  let(:user) { FactoryGirl.create(:user) }
  let(:team) { TeamDecorator.new(object) }
  let(:object) { FactoryGirl.create(:team, user: user) }

  describe "when delete_link is" do
    context "displayed for the owner" do
      before(:each) do
        sign_in user
      end
      it { expect(team.delete_link(user)).to include("/teams/#{team.id}") }
      it { expect(team.delete_link(user)).to have_selector("i.fa-trash-o") }
      it { expect(team.delete_link(user)).to include("Delete") }
      it { expect(team.delete_link(user)).to include("Are you sure you want to remove #{team.name}") }
    end

    context "not displayed for other users" do
      let(:visitor) { FactoryGirl.create(:user) }
      before(:each) do
        sign_in visitor
      end
      it { expect(team.delete_link(visitor)).to be_nil}
    end
  end

  describe "when displaying" do
    before(:each) do
      sign_in user
    end
    context "current user name" do

      it { expect(team.current_user_name).to include("/users/#{user.id}") }
      it { expect(team.current_user_name).to eq("<a href=\"/users/#{user.id}\">#{user.name}</a>")}
    end

    context "current team owner membership" do
      let(:membership) { FactoryGirl.create(:membership, team: team, user: user) }
      before(:each) do
        membership.update_attributes(aasm_state: "active")
      end
      it { expect(team.current_user_membership).to eq(membership) }
      it { expect(team.current_user_membership_status).to eq("Active") }

      context "and resign_button" do
        it { expect(team.resign_button).to include("Resign") }
        it { expect(team.resign_button).to include(h.resigning_membership_path(membership.id)) }
        it { expect(h.requesting_membership_path(membership.id)).to eq("/memberships/#{membership.id}/requesting") }
        it { expect(team.resign_button).to have_selector(".button_to") }
        it { expect(team.resign_button).not_to include("Request") }
        it { expect(team.current_user_membership_button).not_to eq(team.resign_button) }
      end

      context "and request_button" do
        before(:each) do
          membership.update_attributes(aasm_state: "inactive")
        end
        it { expect(team.request_button).to include("Request") }
        it { expect(team.request_button).to include(h.requesting_membership_path(membership.id)) }
        it { expect(h.resigning_membership_path(membership.id)).to eq("/memberships/#{membership.id}/resigning") }
        it { expect(team.request_button).to have_selector(".button_to") }
        it { expect(team.request_button).not_to include("Resign") }
        it { expect(team.current_user_membership_button).not_to eq(team.request_button) }
      end

      context "and disabled button" do
        before(:each) do
          membership.update_attributes(aasm_state: "pending")
        end
        it { expect(team.disabled_button).not_to include("Request") }
        it { expect(team.disabled_button).not_to include("/memberships/#{membership.id}/requesting") }
        it { expect(team.disabled_button).to have_selector(".button_to") }
        it { expect(team.current_user_membership_button).not_to eq(team.disabled_button) }
      end

      it { expect(team.current_user_display).to have_selector("span") }
      it { expect(team.current_user_display).to include(user.name) }
      it { expect(team.current_user_display).to include(" (Owner)") }

    end

    context "current member membership" do
      let(:visitor) { FactoryGirl.create(:user) }
      let(:team) { TeamDecorator.new(object) }
      let(:object) { FactoryGirl.create(:team) }
      let(:membership) { FactoryGirl.create(:membership, user: visitor, team: team) }
      before(:each) do
        sign_in visitor
        membership.update_attributes(aasm_state: "inactive")
      end

      context "for inactive member" do
        it { expect(team.current_user_membership_button).to eq(team.request_button) }
      end

      context "for active member" do
        before(:each) do
          membership.update_attributes(aasm_state: "pending")
        end
        it{ expect(team.current_user_membership_button).to eq(team.disabled_button) }
      end

      context "for active member" do
        before(:each) do
          membership.update_attributes(aasm_state: "active")
        end
        it { expect(team.current_user_membership_button).to eq(team.resign_button) }
      end

      context "for rejected member" do
        before(:each) do
          membership.update_attributes(aasm_state: "rejected")
        end
        it { expect(team.current_user_membership_button).to eq(team.request_button) }
      end

      context "for banned member" do
        before(:each) do
          membership.update_attributes(aasm_state: "banned")
        end
        it { expect(team.current_user_membership_button).to eq(team.disabled_button) }
      end

      it { expect(team.current_user_display).to have_selector("span") }
      it { expect(team.current_user_display).to include(visitor.name) }
      it { expect(team.current_user_display).to include(": Your membership is ") }
      it { expect(team.current_user_display).to include(team.current_user_membership_status) }
      it { expect(team.current_user_display).to include(team.current_user_membership_button) }
    end

    context "current user for a user who is not a member" do
      let(:visitor) { FactoryGirl.create(:user) }
      before(:each) do
        sign_out user
        sign_in visitor
      end
      it { expect(team.current_user_display).to have_selector("span") }
      it { expect(team.current_user_display).to include(visitor.name) }
      it { expect(team.current_user_display).to include(": You do not work in this hospital") }
    end

    context "all members except current user" do
      it { expect(team.display_members).not_to include(user) }
    end
  end

  describe "when invite by email link is displayed" do
    context"for doctors" do
      before(:each) do
        sign_in user
      end
      it { expect(team.invite_by_email_link).to include("Invite by email") }
      it { expect(team.invite_by_email_link).to include("/users/invitation/new") }
    end

    context "for other members" do
      let(:visitor) { FactoryGirl.create(:user) }
      before(:each) do
        sign_out user
        sign_in visitor
      end
      it { expect(team.invite_by_email_link).to be_nil }
    end
  end
end
