class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :destroy] 

  
  def index
    if logged_in?
      @task = current_user.tasks.build  # form_with 用
      @tasks = current_user.tasks.order(id: :desc)
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    #前の課題版@task = Task.new(task_params)　current_userが必要になるのは当然だが、newとbuildの違いは？
    @task = current_user.tasks.build(task_params)    
    if @task.save
      flash[:success] = 'お仕事が正常に記録されました。お仕事頑張ってください。'
      #前の課題ではredirect_to @taskとしていたが、これで飛ぶtask/indexは結局rootなので、microposts版の記述を使う
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc)
      flash.now[:danger] = 'お仕事が正常に記録されませんでした。もう一度記録してください。'
      render :new
      #microposts版ではrender 'toppages/index'となっているが、たぶんnewの方がいい
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'お仕事の情報が正常に修正されました'
      #create同様
      redirect_to root_url
    else
      flash.now[:danger] = 'お仕事の情報が正常に修正されませんでした。やり直してください。'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'このお仕事はお仕事リストから正常に削除されました。お疲れさまでした。'
    #redirect_back(fallback_location: root_path)ではなく、rootに飛ばすことにする
    redirect_to root_url
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
  
  #edit,destroy用
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end 

end