class FotoOutdoor
	include Mongoid::Document
	include Mongoid::Paperclip

  	embedded_in :outdoor, :inverse_of => :foto_outdoors

  	has_mongoid_attached_file :file,
  	:styles => {
      :small    => '100x70',
      :medium   => '300x200'
    }
end