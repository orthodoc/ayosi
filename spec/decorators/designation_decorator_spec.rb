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

  describe "when make default radio button is" do
    context "displayed" do
      before(:each) do
        sign_in user
        designation.update_attributes(is_default: false)
      end

      it { expect(designation.make_default_button).not_to have_selector("i.fa-check-circle") }
      it { expect(designation.make_default_button).to have_selector("input#designation_id_#{designation.id}") }
    end

    context "not displayed" do
      before(:each) do
        sign_in user
        designation.update_attributes(is_default: true)
      end
      it { expect(designation.make_default_button).to have_selector("i.fa-check-circle") }
      it { expect(designation.make_default_button).not_to have_selector("input#designation_id_#{designation.id}") }
    end
  end

end
