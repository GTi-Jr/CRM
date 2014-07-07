class Project < ActiveRecord::Base

  /Escopos/
  scope :public_or_yours, ->(current_user) { where("visibility = 'Public' OR user_id = ?", current_user.id) }
  scope :private_or_yours, ->(current_user) { where("visibility = 'Private' OR user_id = ?", current_user.id) }
  
  /Validações/
  validates :status, :presence => true
  validates :category, :presence => true
  validates :revenue, :presence => true, :numericality => true
  validates :percent, :presence => true, :numericality => true
  validates :description, :presence => true

  /Auto Geração de Token/
  before_create { generate_token(:token) }

  /Relacionamento - Banco de Dados/
  belongs_to :user
  belongs_to :client
  has_many :activities

  /Método para Gerar Senha Randomica/
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64(6,false)
    end while Project.exists?(column => self[column])    
  end
end
