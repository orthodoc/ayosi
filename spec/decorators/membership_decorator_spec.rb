require 'spec_helper'

describe MembershipDecorator do
  let(:user) { FactoryGirl.create(:user) }
  let(:team) { FactoryGirl.create(:team, user_id: user.id) }
  let(:membership) { MembershipDecorator.new(FactoryGirl.create(:membership, team_id: team.id, user_id: user.id)) }

  describe "where the delete link is" do
    context "displayed" do
      before(:each) do
        sign_in user
      end
      it { expect(membership.delete_link(team)).to include("/memberships/#{membership.id}") }
      it { expect(membership.delete_link(team)).to have_selector("i.fa-trash-o") }
      it { expect(membership.delete_link(team)).to include("Delete") }
      it { expect(membership.delete_link(team)).to include("Are you sure you want to remove Membership no: #{membership.id}") }
    end

    context "not displayed" do
      before(:each) do
        membership.destroy
      end
      it { expect(membership.delete_link(team)).to be_nil }
    end
  end
end
