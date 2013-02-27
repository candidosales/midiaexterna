class Parceiro
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :nome, type: String
  field :endereco, type: String
  field :bairro, type: String
  field :cep, type: String
  field :cidade, type: String
  field :estado, type: String
  field :tel, type: String
  field :email, type: String
  field :cnpj, type: String

  has_mongoid_attached_file :logo,
    :styles => {
      :small    => '90x90#',
      :medium   => '150x100'
    }

  has_one :outdoor, :class_name => "Outdoor", inverse_of: :parceiro, validate: false

  validates_presence_of :nome, :email, :tel
  validates_uniqueness_of :email, :cnpj
end
