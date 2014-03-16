require 'spec_helper'

describe UserDecorator do
  let(:user) { UserDecorator.new(object) }
  let(:object) { FactoryGirl.create(:user, category: "hospital_staff") }
  let(:hospital) { FactoryGirl.create(:hospital) }
  before(:each) do
    sign_in user
  end

  context "where user's role_name is" do
    context "the category" do
      it { expect(user.role_name).to eq("Hospital Staff") }
    end

    context "the role itself" do
      before(:each) do
        user.add_role :doctor
      end
      it { expect(user.role_name).to eq("Doctor") }
    end
  end

  context "where user name_link is " do
    context "a link" do
      it { expect(h.current_user).to be user }
      it { expect(h.user_path(user)).to eq("/users/#{user.id}") }
      it { expect(h.current_user.name_link).to eq("<a href=\"/users/#{user.id}\">#{user.name}</a>") }
    end
  end

  describe "where welcome title has" do
    context "name link" do
      before(:each) do
        user.add_role :doctor
      end
      it { expect(h.current_user.welcome_title).to include(user.name_link) }
      it { expect(h.current_user.welcome_title).to have_selector("span") }
      it { expect(h.current_user.welcome_title).to include(" (Doctor)")}
    end
  end

  context "where for a team," do
    let(:designation) { FactoryGirl.create(:designation, user_id: user.id, hospital_id: hospital.id) }
    let(:team) { FactoryGirl.create(:team, user: user, hospital: hospital) }
    let(:membership) { FactoryGirl.create(:membership, user_id: user.id, team_id: team.id)}
    before(:each) do
      designation.update_attributes(is_default: true)
    end

    context "displays owner title" do
      it { expect(h.current_user).to eq(user) }
      it { expect(h.current_user.owner_title(team)).to eq("(Owner)")}
    end

    context "finds the designation" do
      it { expect(h.current_user.designation(team)).to eq(designation) }
      it { expect(h.current_user.designation_name(team)).to eq(designation.name.titleize) }
    end

    context "finds membership details" do
      before(:each) do
        membership.update_attributes(aasm_state: "inactive")
      end
      it { expect(h.current_user.membership(team)).to eq(membership) }
      it { expect(h.current_user.membership_status(team)).to eq("Inactive") }

      context "and buttons" do
        it { expect(h.current_user.activate_button(team)).to include("Activate") }
        it { expect(h.current_user.activate_button(team)).to include("/memberships/#{membership.id}/activating") }
        it { expect(h.current_user.activate_button(team)).to have_selector(".button-mini") }

        it { expect(h.current_user.reject_button(team)).to include("Reject") }
        it { expect(h.current_user.reject_button(team)).to include("/memberships/#{membership.id}/rejecting") }
        it { expect(h.current_user.reject_button(team)).to have_selector(".button-mini") }

        it { expect(h.current_user.deactivate_button(team)).to include("Deactivate") }
        it { expect(h.current_user.deactivate_button(team)).to include("/memberships/#{membership.id}/deactivating") }
        it { expect(h.current_user.deactivate_button(team)).to have_selector(".button-mini") }

        it { expect(h.current_user.ban_button(team)).to include("Ban") }
        it { expect(h.current_user.ban_button(team)).to include("/memberships/#{membership.id}/banning") }
        it { expect(h.current_user.ban_button(team)).to have_selector(".button-mini") }

        it { expect(h.current_user.request_button(team)).to include("Request") }
        it { expect(h.current_user.request_button(team)).to include("/memberships/#{membership.id}/requesting") }
        it { expect(h.current_user.request_button(team)).to have_selector(".button-mini") }

        it { expect(h.current_user.resign_button(team)).to include("Resign") }
        it { expect(h.current_user.resign_button(team)).to include("/memberships/#{membership.id}/resigning") }
        it { expect(h.current_user.resign_button(team)).to have_selector(".button-mini") }

        it { expect(h.current_user.disabled_button).to include("Disabled") }
        it { expect(h.current_user.disabled_button).not_to include("/memberships/#{membership.id}") }
        it { expect(h.current_user.disabled_button).to have_selector(".button-mini")}
      end

      context "and action button for" do
        let(:visitor) { UserDecorator.new(FactoryGirl.create(:user)) }
        let(:membership) { FactoryGirl.create(:membership, user_id: visitor.id, team_id: team.id) }

        context "when a member membership is inactive" do
          before(:each) do
            membership.update_attributes(aasm_state: "inactive")
          end
          it { expect(visitor.action_button(team)).to eq(visitor.activate_button(team)) }
        end

        context "when a member membership is pending" do
          before(:each) do
            membership.update_attributes(aasm_state: "pending")
          end
          it { expect(visitor.action_button(team)).to eq(visitor.activate_button(team).concat(visitor.reject_button(team))) }
        end

        context "when a member membership is active" do
          before(:each) do
            membership.update_attributes(aasm_state: "active")
          end
          it { expect(visitor.action_button(team)).to eq(visitor.deactivate_button(team).concat(visitor.ban_button(team))) }
        end

        context "when a member membership is rejected" do
          before(:each) do
            membership.update_attributes(aasm_state: "rejected")
          end
          it { expect(visitor.action_button(team)).to eq(visitor.ban_button(team)) }
        end
      end
    end
  end
end
