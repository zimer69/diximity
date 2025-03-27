class Address < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  geocoded_by :full_address
  after_validation :geocode, if: :address_changed?

  def full_address
    [address1, address2, city, state, zip, country].compact.join(', ')
  end

  private

  def address_changed?
    will_save_change_to_address1? ||
    will_save_change_to_address2? ||
    will_save_change_to_city? ||
    will_save_change_to_state? ||
    will_save_change_to_zip? ||
    will_save_change_to_country?
  end
end
