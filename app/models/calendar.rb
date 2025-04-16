class Calendar < ApplicationRecord
  belongs_to :user
  has_many :time_slots, dependent: :destroy

  validates :user_id, uniqueness: true
end
