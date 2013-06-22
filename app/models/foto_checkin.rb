class FotoCheckin
	include Mongoid::Document
	include Mongoid::Paperclip

  	belongs_to :outdoor  	
  	embedded_in :checkin, :inverse_of => :foto_checkins

  	has_mongoid_attached_file :file,
  	:styles => {
      :small    => '100x70',
      :medium   => '300x200'
    }

end