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
  field :valor, type: Money

  embeds_many :foto_outdoors, :cascade_callbacks => true
  accepts_nested_attributes_for :foto_outdoors, :allow_destroy => true

  has_and_belongs_to_many :reservas

  default_scope asc :numero

  validates_presence_of :numero, :endereco, :bairro, :cidade, :valor

  validates :numero, :uniqueness => true

end
