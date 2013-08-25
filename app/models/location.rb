class Location < ActiveRecord::Base
  attr_accessible :city, :latitude, :longitude, :state, :street, :user_id
  belongs_to :user
  geocoded_by :address
  after_validation :geocode
  
  def address
    "#{street}, #{city}, #{state}"
  end
end
