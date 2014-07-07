class Contact < ActiveRecord::Base
  /Validações/
  validates :name, :presence => true
  validates :phone, :presence => true
  validates :email, :presence => true
  validates :occupation, :presence => true
  validates :background, :presence => true


  /Relacionamento - Banco de Dados/
  belongs_to :client
end
