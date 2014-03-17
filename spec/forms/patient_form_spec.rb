require 'spec_helper'

describe PatientForm do

  subject { PatientForm.new(FactoryGirl.create(:patient)) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:age) }
  it { should validate_presence_of(:gender) }
  it { should validate_presence_of(:uhid) }
  it { should validate_numericality_of(:age) }

end
