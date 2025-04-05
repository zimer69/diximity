class Chat < ApplicationRecord
    has_many :messages
    belongs_to :connection

    validates :connection_id, presence: true
end
