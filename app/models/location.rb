class Location < ActiveRecord::Base
  attr_accessible :city, :latitude, :longitude, :state, :street, :user_id
  belongs_to :user
end
