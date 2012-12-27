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

  has_and_belongs_to_many :reservas

  default_scope asc :numero


  def full_title
  	%{#{numero} - #{endereco}, #{bairro}, #{sentido}}
  end
end
