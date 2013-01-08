class FotoOutdoor
	include Mongoid::Document
  	include Mongoid::Paperclip

  	has_many :outdoor, :inverse_of => :foto_outdoor

  	has_mongoid_attached_file :attachment
end