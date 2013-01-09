class Outdoor
  include Mongoid::Document
  include Mongoid::Timestamps

  
  field :numero, type: Integer
  field :endereco, type: String
  field :bairro, type: String
  field :cidade, type: String
  field :estado, type: String
  field :sentido, type: String
  field :ponto_referencia, type: String
  field :valor, type: Money

  embeds_many :foto_outdoors, :cascade_callbacks => true
  accepts_nested_attributes_for :foto_outdoors, :allow_destroy => true

  #mount_uploader :foto_outdoor, FotoOutdoorUploader
  #has_mongoid_attached_file :foto_outdoor,
  #:styles => {
  #    :small    => '100x70',
  #    :medium   => '300x200'
  #  }

  has_and_belongs_to_many :reservas

  default_scope asc :numero

  validates_presence_of :numero, :endereco, :bairro, :cidade, :valor

end
