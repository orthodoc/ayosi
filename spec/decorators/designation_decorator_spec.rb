require 'spec_helper'

describe DesignationDecorator do

  let(:user) { FactoryGirl.create(:user) }
  let(:designation) { DesignationDecorator.new(object) }
  let(:object) { FactoryGirl.create(:designation, user_id: user.id) }

  describe "where the delete link is" do

    before(:each) do
      sign_in user
    end

    context "displayed" do
      it { expect(designation.delete_link(user)).to include("/designations/#{designation.id}") }
      it { expect(designation.delete_link(user)).to have_selector("i.fa-trash-o") }
      it { expect(designation.delete_link(user)).to include("Delete") }
      it { expect(designation.delete_link(user)).to include("Are you sure you want to remove #{designation.name}") }
    end

    context "not displayed" do
      before(:each) do
        user.designations.each do |d|
          d.destroy
        end
      end

      it { expect(designation.delete_link(user)).to be_nil }
    end

  end

end
