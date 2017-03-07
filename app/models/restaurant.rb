class Restaurant < ApplicationRecord
  has_many :events, dependent: :destroy
   geocoded_by :address
  belongs_to :category
  after_validation :geocode, if: :address_changed?
end
