require 'spec_helper'

describe Patient do

  subject { FactoryGirl.create(:patient) }

  it { should have_many(:surgeries) }
  it { should have_many(:hospitals).through(:surgeries) }

  it { should have_many(:clients) }
  it { should have_many(:users).through(:clients) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:age) }
  it { should validate_presence_of(:gender) }
  it { should validate_presence_of(:uhid) }

  it { should accept_nested_attributes_for(:surgeries) }
  it { should accept_nested_attributes_for(:clients) }

end
