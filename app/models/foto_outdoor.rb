class FotoOutdoor
	include Mongoid::Document

  	has_many :outdoor, :inverse_of => :foto_outdoor

  	mount_uploader :foto_outdoor, FotoOutdoorUploader

end