class OutdoorCheckin 
	include Mongoid::Document
  	include Mongoid::Timestamps

  	belongs_to :outdoor, class_name: "Outdoor"
  	belongs_to :checkin, class_name: "Checkin"

  	#Fotos
  	embeds_many :foto_checkins, :cascade_callbacks => true
  	accepts_nested_attributes_for :foto_checkins, :allow_destroy => true
  	accepts_nested_attributes_for :outdoor, :checkin

end