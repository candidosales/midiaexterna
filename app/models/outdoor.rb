class Outdoor
  include Mongoid::Document
  field :numero, type: Integer
  field :endereco, type: String
  field :bairro, type: String
  field :cidade, type: String
  field :estado, type: String
  field :posicao, type: String

  has_and_belongs_to_many :pedidos

  def full_title
  	%{#{numero} - #{endereco}, #{bairro}, #{posicao}}
  end
end
