class Location < ActiveRecord::Base
  attr_accessible :city, :latitude, :longitude, :state, :street, :user_id, :center_name
  belongs_to :user
  geocoded_by :address
  after_validation :geocode
  acts_as_gmappable process_geocoding: false
  
  validates :street, presence: true, length: { maximum: 50 }
  validates :city, presence: true, length: { maximum: 30 }
  validates :state, presence: true, length: { maximum: 25 }
  
  def address
    "#{self.street}, #{self.city}, #{self.state}"
  end
end
