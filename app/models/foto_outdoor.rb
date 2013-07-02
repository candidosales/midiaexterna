class FotoOutdoor
	include Mongoid::Document
	include Mongoid::Paperclip

  	embedded_in :outdoor, :inverse_of => :foto_outdoors

  	#Dimensão 16:9
  	has_mongoid_attached_file :file,
  	:styles => {
      :small    => '124x70',
      :medium   => '356x200',
      :large    => '889x500'
    }
end