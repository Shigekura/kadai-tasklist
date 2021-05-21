class TasksController < ApplicationController
  def index
        @tasks = Task.all
  end

  def show
        @task = Task.find(params[:id])
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
        @task = Task.find(params[:id])
  end

  def update
        @task = Task.find(params[:id])
        if @task.update(task_params)
          flash[:success] = 'お仕事の情報が正常に修正されました'
          redirect_to @task
        else
          flash.now[:danger] = 'お仕事の情報が正常に修正されませんでした。やり直してください。'
          render :edit
        end
  end

  def destroy
        @task = Task.find(params[:id])
        @task.destroy
        flash[:success] = 'このお仕事はお仕事リストから正常に削除されました。お疲れさまでした。'
        redirect_to tasks_url
  end
end

private
# Strong Parameter
  def task_params
        params.require(:task).permit(:content)
  end