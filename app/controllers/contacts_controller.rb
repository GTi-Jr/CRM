class ContactsController < InheritedResources::Base
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token
  before_action :check_and_redirect 

  def index
    @contacts = Contact.order(:name).page(params[:page]).per(7)   
  end

  def show
  end

  def new
    @contact = Contact.new
    session[:client_id] = params[:id] 
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.client_id = session[:client_id]
    respond_to do |format|
      if @contact.save
        format.html { redirect_to "/clients/#{@contact.client_id}", notice: 'Criado com sucesso' }
      else
        format.html { render action: 'new'}        
      end
    end
  end

  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to "/clients/#{@contact.client_id}", notice: 'Editado com sucesso' }
      else
        format.html { render action: 'edit'}        
      end
    end
  end

  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to clients_path, notice: 'Deletado'  }      
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :facebook, :twitter, :background, :website, :occupation, :linkedin, :client_id)
    end
end
