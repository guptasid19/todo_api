class TasksController < ApplicationController

  def index
    render json: current_user.tasks.order(:position)
  end

  def create
    next_position = current_user.tasks.order(:position).last.position + 1
    task = current_user.tasks.new(task_params.merge(position: next_position))
    if task.save
      render json: task
    else
      render_error_response(task.errors.full_messages.to_sentence)
    end
  end

  def edit
    task = current_user.tasks.find_by(id: params[:id])
    render_not_found_response('Task not found') unless task
    if task.update(task_params)
      render json: task
    else
      render_error_response(task.errors.full_messages.to_sentence)
    end
  end

  def reorder
    result = ReorderTasks.run(reorder_params.merge(user: current_user))
    if result.errors.blank?
      render_success_response('Task successfully reordered')
    else
      render_error_response(result.errors.full_messages.to_sentence)
    end
  end

  private

  def task_params
    params.permit(:description, :due_date, :title)
  end

  def reorder_params
    params.permit(:id, :new_position)
  end
end