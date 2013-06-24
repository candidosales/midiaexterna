class Outdoor
  include Mongoid::Document
  include Mongoid::Timestamps

  field :numero, type: Integer
  field :endereco, type: String
  field :bairro, type: String
  field :cidade, type: String
  field :estado, type: String
  field :zona, type: String
  field :sentido, type: String
  field :ponto_referencia, type: String
  field :valor_veiculacao, type: Money
  field :valor_impressao, type: Money

  #Fotos
  embeds_many :foto_outdoors, :cascade_callbacks => true
  accepts_nested_attributes_for :foto_outdoors, :allow_destroy => true

  has_many :outdoor_checkins

  has_and_belongs_to_many :reservas
  belongs_to :parceiro, class_name: "Parceiro"

  default_scope asc :numero

  validates_presence_of :numero, :endereco, :bairro, :cidade, :valor_veiculacao, :valor_impressao

  validates :numero, :uniqueness => true

end
