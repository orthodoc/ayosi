require 'spec_helper'

describe HospitalDecorator do
  let(:user) { FactoryGirl.create(:user) }
  let(:hospital) { HospitalDecorator.new(FactoryGirl.create(:hospital)) }

  context "displays name link" do
    before(:each) do
      user.add_role :admin
      sign_in user
    end
    it { expect(hospital.name_link).to include(hospital.name) }
    it { expect(hospital.name_link).to include("/hospitals/#{hospital.id}/edit")}
    it { expect(hospital.title).to include(hospital.name_link) }
    it { expect(hospital.title).to include(hospital.city) }
  end
end
