class Activity < ActiveRecord::Base

  scope :public_or_yours, ->(current_user) { where("visibility = 'Public' OR user_id = ?", current_user.id) }
  scope :private_or_yours, ->(current_user) { where("visibility = 'Private' OR user_id = ?", current_user.id) }
  scope :high_urgency, -> { where("priority = 'Alta' OR priority = 'Urgente'") }

  /Validações/
  validates :name, :presence => true
  validates :description, :presence => true
  validates :category, :presence => true
  validates :priority, :presence => true
  validates :status, :presence => true
  validates :visibility, :presence => true
  
  /Relacionamentos - Banco de Dados/
  belongs_to :user
  belongs_to :project  
end
