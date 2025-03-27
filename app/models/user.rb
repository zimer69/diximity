class User < ApplicationRecord
  acts_as_paranoid

  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address, update_only: true

  after_initialize :build_address, if: -> { new_record? && address.nil? }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
