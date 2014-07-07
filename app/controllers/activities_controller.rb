class ActivitiesController < InheritedResources::Base
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token
  before_action :check_and_redirect

  def index
    activities_status
    @activities = Activity.public_or_yours(current_user).order(!:created_at).page(params[:page]).per(7)   
  end

  def category  
    activities_status
    if params[:category] == "yours"
      @activities = Activity.order(!:date_sent).where(user: current_user).page(params[:page]).per(7)

    elsif params[:category] == "private"
      @activities = Activity.private_or_yours(current_user).order(!:created_at).page(params[:page]).per(7)

    elsif params[:category] == "urgent"
      @activities = Activity.public_or_yours(current_user).high_urgency.order(!:created_at).page(params[:page]).per(7)

    else
      redirect_to activities_path
    end   
  end

  def show
    activities_status
    @activity_list = Activity.public_or_yours(current_user).where(project: @activity.project).order(!:created_at)   
  end

  def new
    @activity = Activity.new
    @users = User.all
    @projects = Project.all
  end

  def edit
    @activity = Activity.find(params[:id])
    @users = User.all
    @projects = Project.all
  end

  def create
    @activity = Activity.new(activity_params)
    respond_to do |format|
      if @activity.save
        format.html { redirect_to activities_path, notice: 'Incrição feita com sucesso.' }
      else
        format.html { render action: 'new'}        
      end
    end
  end

  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: 'Email was successfully updated.' }
      else
        format.html { render action: 'edit'}        
      end
    end
  end

  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_path }      
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:name,:description,:category, :date_begin, :date_limit, :date_reminder, :priority, :status, :visibility, :description, :user_id, :project_id)
    end
end
