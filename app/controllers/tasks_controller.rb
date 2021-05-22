class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = 'お仕事が正常に記録されました。お仕事頑張ってください。'
      redirect_to @task
    else
      flash.now[:danger] = 'お仕事が正常に記録されませんでした。もう一度記録してください。'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'お仕事の情報が正常に修正されました'
      redirect_to @task
    else
      flash.now[:danger] = 'お仕事の情報が正常に修正されませんでした。やり直してください。'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'このお仕事はお仕事リストから正常に削除されました。お疲れさまでした。'
    redirect_to tasks_url
  end

  private
  
  #共通
  def set_task
    @task = Task.find(params[:id])
  end
  
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end