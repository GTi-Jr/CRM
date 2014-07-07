class Email < ActiveRecord::Base

  /Escopos/
  scope :public_or_yours, ->(current_user) { where("visibility = 'Public' OR user_id = ?", current_user.id) }
  scope :private_or_yours, ->(current_user) { where("visibility = 'Private' OR user_id = ?", current_user.id) }
  
  /Validações/
  validates :message, :presence => true

  /Relacionamento - Banco de Dados/
  belongs_to :user
  belongs_to :client
end
