class TasksController < ApplicationController

  def index
    render json: current_user.tasks
  end

  def create
    task = current_user.tasks.new(task_params)
    if task.save
      render json: task
    else
      render_error_response(task.errors.full_messages.to_sentence)
    end
  end

  def edit

  end
  
  private

  def task_params
    params.permit(:description, :due_date, :title)
  end
end