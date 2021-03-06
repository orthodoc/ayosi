require 'spec_helper'

describe User do

  before(:each) do
    @user = FactoryGirl.create(:user, category: "hospital_staff")
    @designation = FactoryGirl.create(:designation, user: @user, is_default: true)
    @user.add_role :doctor
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_confirmation_of(:password) }
  it { should ensure_length_of(:password).is_at_least(8) }
  it { should validate_presence_of(:encrypted_password) }
  it { should respond_to(:encrypted_password) }

  it { should accept_nested_attributes_for(:designations) }
  it { should accept_nested_attributes_for(:clients) }
  it { should accept_nested_attributes_for(:memberships) }

  it { expect(User.hospital_staff).to include(@user) }
  it { expect(User.doctors).to include(@user) }
  it { expect(@user.default_designation).to eq(@designation) }
  it { expect(@user.default_hospital).to eq(@designation.hospital) }
end
