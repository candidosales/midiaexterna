class Outdoor
  include Mongoid::Document
  field :numero, type: Integer
  field :endereco, type: String
  field :bairro, type: String
  field :cidade, type: String
  field :estado, type: String
  field :sentido, type: String
  field :ponto_referencia, type: String
  field :valor, type: Money
  field :status, type: String, default: "aberto"

  has_and_belongs_to_many :pedidos

  def full_title
  	%{#{numero} - #{endereco}, #{bairro}, #{sentido}, #{status}}
  end
end
