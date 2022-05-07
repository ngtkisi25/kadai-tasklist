class TasklistsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @tasklist = current_user.tasklists.build(tasklist_params)
    if @tasklist.save
      flash[:success] = 'タスクを作成しました'
      redirect_to root_url
    else
      @tasklists = current_user.tasklists.order(id: :desc)
      flash.now[:danger] = 'タスクの作成に失敗しました'
      render 'toppages/index'
    end
  end
  
  def destroy
    @tasklist.destroy
    flash[:success] = 'タスクを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def tasklist_params
    params.require(:tasklist).permit(:content)
  end
  
  def current_user
    @tasklist = current_user.tasklists.find_by(id: params[:id])
    unless @tasklist
      redirect_to root_url
    end
  end
end
