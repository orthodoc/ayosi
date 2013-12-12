require 'spec_helper'

describe Hospital do

  subject { FactoryGirl.create(:hospital) }

  it { should have_many(:designations) }
  it { should have_many(:users).through(:designations) }

  it { should have_many(:surgeries) }
  it { should have_many(:patients).through(:surgeries) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:city) }
  it { should validate_presence_of(:city) }

  it { should accept_nested_attributes_for(:designations) }
  it { should accept_nested_attributes_for(:surgeries) }

end
