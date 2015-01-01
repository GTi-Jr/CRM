class User < ActiveRecord::Base

  after_create :password_notification

  after_update :recover_password, :if => :password_changed?

  /Validações/
  validates :name, :presence => true
  validates :email, :presence => true
  validates :occupation, :presence => true
  validates :phone, :presence => true

  /Auto Geração de Token/
  before_create { generate_token(:password) }
  
  /Relacionamentos - Banco de Dados/
  has_many :activities
  has_many :emails
  has_many :projects

  private
    def password_notification
      UserMailer.password_send(self).deliver
    end

    def recover_password
      UserMailer.recover_password(self).deliver
    end

    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64(6,false)
      end while User.exists?(column => self[column])    
    end
end
