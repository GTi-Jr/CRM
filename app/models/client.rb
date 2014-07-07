class Client < ActiveRecord::Base
  /Validações/
  validates :name, :presence => true
  validates :email, :presence => true
  validates :phone, :presence => true, :numericality => true
  
  /Relacionamentos - Banco de Dados/
  has_many :contacts
  has_many :emails
  has_many :projects
end
