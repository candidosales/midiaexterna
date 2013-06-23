class Checkin
	include Mongoid::Document
  	include Mongoid::Timestamps
  	
  	#Fotos
	embeds_many :foto_checkins, :cascade_callbacks => true
	accepts_nested_attributes_for :foto_checkins, :allow_destroy => true
	
  	belongs_to :reserva, class_name: "Reserva"
  	belongs_to :outdoor, class_name: "Outdoor" 
end