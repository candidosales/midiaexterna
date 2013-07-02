class FotoCheckin
	include Mongoid::Document
	include Mongoid::Paperclip
	
  	embedded_in :outdoor_checkin, :inverse_of => :foto_checkins

    #Dimensão 16:9
  	has_mongoid_attached_file :file,
    :styles => {
      :small    => '124x70',
      :medium   => '356x200',
      :large    => '889x500'
    }

end