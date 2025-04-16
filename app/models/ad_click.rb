class AdClick < ApplicationRecord
  belongs_to :ad
  belongs_to :user, optional: true

  validates :clicked_at, presence: true
  validates :page, presence: true

  scope :recent, -> { order(clicked_at: :desc) }
  scope :by_date, -> { order(clicked_at: :desc) }
end 