class Connection < ApplicationRecord
  enum :status, %i[pending accepted rejected]
  
  belongs_to :user
  belongs_to :connected_user, class_name: "User"

  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= "pending"
  end
end
