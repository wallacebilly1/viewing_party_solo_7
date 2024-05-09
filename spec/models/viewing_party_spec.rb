require 'rails_helper'

RSpec.describe ViewingParty, type: :model do
  before(:each) do
      @user_1 = User.create!(name: 'Sam', email: 'sam@email.com')
      @user_2 = User.create!(name: 'Tommy', email: 'tommy@email.com')
      @party = ViewingParty.create!(date: "2024/06/30", start_time: "07:25", duration: 175, movie_id: 1, movie_duration: 170)
      UserParty.create!(user_id: @user_1.id, viewing_party_id: @party.id, host: true)
      UserParty.create!(user_id: @user_2.id, viewing_party_id: @party.id, host: false)
  end

  describe 'validations' do
    it { should validate_presence_of :date }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :duration }
    
    it 'duration cannot be shorter than movie length' do
      viewing_party = ViewingParty.new(date: "2024/06/30", start_time: "07:25", duration: 20, movie_id: 1, movie_duration: 170)

      assert viewing_party.invalid?
      assert_equal ["must be longer than the movie length"], viewing_party.errors[:duration]
    end

    it 'date cannot be in past' do
      viewing_party = ViewingParty.new(date: "2020/06/30", start_time: "07:25", duration: 20, movie_id: 1, movie_duration: 170)

      assert viewing_party.invalid?
      assert_equal ["can't be in the past"], viewing_party.errors[:date]
    end
  end
  
  describe 'assocations' do
      it { should have_many :user_parties }
      it { should have_many(:users).through(:user_parties) }
  end

  describe "instance methods" do
    it "returns user that is hosting the party" do
      expect(@party.find_host).to eq (@user_1)
    end
  end
end