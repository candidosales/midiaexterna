class Checkin
	include Mongoid::Document
  	include Mongoid::Timestamps
  	
  	#Outdoors
	has_many :outdoor_checkins
	accepts_nested_attributes_for :outdoor_checkins, :allow_destroy => true
	
  	belongs_to :reserva, class_name: "Reserva"

end