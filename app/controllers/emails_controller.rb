class EmailsController < InheritedResources::Base
  before_action :set_email, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token
  before_action :check_and_redirect

  def index
    emails_status

    @emails = Email.where("visibility = ? OR user_id = ?", "Public",current_user).order(!:date_sent).page(params[:page]).per(7)   
  end

  def category
    emails_status
    if params[:category] == "yours"
      @emails = Email.where("visibility = ? OR user_id = ?", "Public",current_user).order(!:date_sent).where(user: current_user).page(params[:page]).per(7)

    elsif params[:category] == "newest"
      @emails = Email.where("visibility = ? OR user_id = ?", "Public",current_user).order(!:date_sent).where(created_at: (Time.now - 1.day)..Time.now).page(params[:page]).per(7)

    else
      redirect_to emails_path
    end 
  end

  def show
    emails_status
    @email_list = Email.where(subject: @email.subject).where(client: @email.client).where("date_sent <= ?", @email.date_sent).where("id != ?",@email.id).order(:date_sent)   
  end

  def new
    @email = Email.new
    @users = User.all
    @clients = Client.all
  end

  def edit
    @email = Email.find(params[:id])
    @users = User.all
    @clients = Client.all
  end

  def create
    @email = Email.new(email_params)
    @email.user = current_user
    if @email.sender == "Cliente"
      @email.sender = @email.client.name
    else
      @email.sender = @email.user.name
    end


    respond_to do |format|
      if @email.save
        format.html { redirect_to emails_path, notice: 'Criado com sucesso.' }
      else
        format.html { render action: 'new'}        
      end
    end
  end

  def update
    respond_to do |format|
      if @email.update(email_params)
        format.html { redirect_to @email, notice: 'Editado com sucesso' }
      else
        format.html { render action: 'edit'}        
      end
    end
  end

  def destroy
    @email.destroy
    respond_to do |format|
      format.html { redirect_to emails_path, notice: 'Deletado'}      
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_params
      params.require(:email).permit(:message, :user_id, :client_id, :date_sent, :subject,:sender,:visibility)
    end
end
