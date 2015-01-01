class ProjectsController < InheritedResources::Base
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token
  before_action :check_and_redirect, except: [:your]

  def index
    projects_status
    @projects = Project.where("visibility = ? OR user_id = ?", "Public",current_user).order(!:created_at).page(params[:page]).per(7)   
  end

  def category  
    projects_status
    if params[:category] == "yours"
      @projects = Project.order(!:date_sent).where(user: current_user).page(params[:page]).per(7)

    elsif params[:category] == "private"
      @projects = Project.private_or_yours(current_user).order(!:created_at).page(params[:page]).per(7)

    elsif params[:category] == "urgent"
      @projects = Project.public_or_yours(current_user).high_urgency.order(!:created_at).page(params[:page]).per(7)

    else
      redirect_to projects_path
    end   
  end

  def progress
    @project ||= Project.find_by token: params[:token]
    if @project == nil
      redirect_to "/log_in", :notice => "Projeto não encotrado"
    end   
  end

  def show
    projects_status
    @activity_list = @project.activities.order(!:created_at)   
  end

  def new
    @project = Project.new
    @users = User.all
    @clients = Client.all
  end

  def edit
    @project = Project.find(params[:id])
    @users = User.all
    @clients = Client.all
  end

  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: 'Criado com sucesso' }
      else
        format.html { render action: 'new'}        
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Editado com sucesso' }
      else
        format.html { render action: 'edit'}        
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_path, notice: 'Deletado'}      
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:token,:visibility,:title,:date_begin, :user_id, :client_id, :date_limit, :date_estimated,:status, :percent, :category, :priority, :revenue,:description)
    end
end
