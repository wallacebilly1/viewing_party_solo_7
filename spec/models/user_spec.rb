require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :password_confirmation}
    it { should have_secure_password }
    it { should allow_value('something@something.something').for(:email) }
    it { should_not allow_value('something somthing@something.something').for(:email) }
    it { should_not allow_value('something.something@').for(:email) }
    it { should_not allow_value('something').for(:email) }

    it "Does not return the password after creating a user" do
      user = User.create(name: 'Meg', email: 'meg@test.com', password: 'password123', password_confirmation: 'password123')
      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('password123')
    end

    it "is invalid if password and password_confirmation do not match" do
      user = User.new(name: 'Meg', email: 'meg@test.com', password: "password", password_confirmation: "different_password")
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end

  describe 'associations' do
    it { should have_many :user_parties }
    it { should have_many(:viewing_parties).through(:user_parties) }
  end
  
end
