class UsersController < InheritedResources::Base
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token
  before_action :check_and_redirect  

  def dashboard
    if current_user.tour != true
      redirect_to "/tour"
    end
    @contacts = Contact.order(!:created_at).limit(5)
    @projects = Project.public_or_yours(current_user).order(!:created_at).limit(5)
    @emails = Email.public_or_yours(current_user).order(!:created_at).limit(5)
    @activities = Activity.public_or_yours(current_user).order(!:created_at).limit(5)

    @nclients = Client.count
    @nprojects = Project.public_or_yours(current_user).count
    @nemails = Email.public_or_yours(current_user).count
    @nactivities = Activity.public_or_yours(current_user).count
  end

  def index
    @users = User.order(:name).page(params[:page]).per(9)   
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'Criado com sucesso' }
      else
        format.html { render action: 'new'}        
      end
    end
  end

  def tour
    if current_user.tour != true
      current_user.update_attribute(tour: true)
    end    
    @contacts = Contact.order(!:created_at).limit(5)
    @projects = Project.public_or_yours(current_user).order(!:created_at).limit(5)
    @emails = Email.public_or_yours(current_user).order(!:created_at).limit(5)
    @activities = Activity.public_or_yours(current_user).order(!:created_at).limit(5)

    @nclients = Client.count
    @nprojects = Project.public_or_yours(current_user).count
    @nemails = Email.public_or_yours(current_user).count
    @nactivities = Activity.public_or_yours(current_user).count
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Editado com sucesso' }
      else
        format.html { render action: 'edit'}        
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'Deletado' }      
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :occupation, :password, :linkedin, :phone, :website, :background, :permission)
    end
end
