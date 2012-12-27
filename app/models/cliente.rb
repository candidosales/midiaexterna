class Cliente
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :nome, type: String
  field :email, type: String
  field :tel, type: String
  field :cpf, type: String
  field :cnpj, type: String
  field :empresa, type: String
  field :cidade, type: String
  field :bairro, type: String
  field :estado, type: String
  field :endereco, type: String
  field :cep, type: String
  field :razao, type: String

  has_one :reserva, inverse_of: :cliente

  validates_presence_of :nome, :email
end
