class Pedido
  include Mongoid::Document
  field :criado_em, type: Time

  belongs_to :cliente, class_name: "Cliente"
  has_and_belongs_to_many :outdoors
 
end
