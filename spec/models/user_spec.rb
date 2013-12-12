require 'spec_helper'

describe User do

  subject { FactoryGirl.create(:user) }

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

end
