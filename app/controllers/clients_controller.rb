class ClientsController < InheritedResources::Base
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token
  before_action :check_and_redirect 

  def index
    @clients = Client.order(:name).page(params[:page]).per(7)   
  end

  def show
    @client = Client.find(params[:id])
    @contacts_list = @client.contacts
  end

  def new
    @client = Client.new
  end

  def edit
    @client = Client.find(params[:id])
  end

  def create
    @client = Client.new(client_params)
    respond_to do |format|
      if @client.save
        format.html { redirect_to clients_path, notice: 'Criado com sucesso' }
      else
        format.html { render action: 'new'}        
      end
    end
  end

  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Atualizado com sucesso' }
      else
        format.html { render action: 'edit'}        
      end
    end
  end

  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_path, notice: 'Deletado'  }      
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:name, :email, :phone, :facebook, :twitter, :description, :website)
    end
end
