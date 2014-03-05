require 'spec_helper'

describe Team do
  
  subject { FactoryGirl.create(:team) }

  it { should belong_to(:hospital) }

  it { should have_many(:memberships) }
  it { should have_many(:members).through(:memberships) }

  it { should belong_to(:user) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:hospital_id) }
  it { should validate_presence_of(:hospital) }
  it { should validate_presence_of(:user) }

  it { should accept_nested_attributes_for(:members) }

  it { expect(subject.owner).to eq(subject.user) }

  it { expect(subject.member_list).to eq(@member_list) }

end
