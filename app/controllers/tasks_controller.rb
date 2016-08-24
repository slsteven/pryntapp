class TasksController < ApplicationController
  def index
    @tasks = Task.all

    respond_to do |format|
      format.html { render action: 'index' }
      format.json { render json: @tasks }
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    new_task = User.find(current_user.id).tasks.new(task_parms)
    if new_task.save
      redirect_to "/tasks"
      #success message
    else
      #error message
      redirect_to "/tasks"
    end
  end

  def update
    task = Task.find(params[:id])
    if task.update_attributes(task_parms)
      redirect_to "/tasks"
    else
      flash[:errors] = task.errors.full_messages
      render "edit"
    end
  end

  def destroy
    Task.find(params[:id]).task_users.destroy
    Task.find(params[:id]).destroy
    redirect_to "/tasks"
  end

  def add_task
    if current_user
      user = current_user
      @new_task = User.find(user.id).task_users.create(task: Task.find(params[:task_id]))
      if @new_task.save
        flash[:success] = "task #{params[:task_id]} added to your profile"
        redirect_to "/tasks"
      else
        flash[:errors] = @new_task.errors.full_messages
        redirect_to "/tasks"
      end
    end
  end

  private
    def task_parms
      params.require(:task).permit(:title, :description, :owner)
    end
end

