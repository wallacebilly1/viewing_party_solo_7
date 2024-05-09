class ViewingParty < ApplicationRecord
  has_many :user_parties
  has_many :users, through: :user_parties

  validates :date, presence: true
  validates :start_time, presence: true
  validates :duration, presence: true
  validate :duration_cannot_be_shorter_than_movie_length
  validate :date_cannot_be_in_past

  def find_host
    users.where("user_parties.host = true").first
  end

  def duration_cannot_be_shorter_than_movie_length
    if duration.present? && duration < movie_duration
      errors.add(:duration, "must be longer than the movie length")
    end
  end

  def date_cannot_be_in_past
    if date.present? && Date.strptime(date, "%m/%d/%Y") < Date.today
      errors.add(:date, "can't be in the past")
    end
  end
end
