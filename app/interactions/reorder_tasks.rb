class ReorderTasks < ActiveInteraction::Base
  integer :id
  integer :new_position
  object :user

  set_callback :type_check, :after, :set_task

  def execute
    return unless @task
    current_position = @task.position
    ActiveRecord::Base.transaction do
      if current_position > new_position
        sql = "update tasks 
          set position = position + 1
          where position >= #{new_position} and 
          position < #{current_position} and user_id = #{user.id}"
      elsif current_position < new_position
        sql = "update tasks 
          set position = position - 1
          where position > #{current_position} and 
          position <= #{new_position} and user_id = #{user.id}"
      end
      ActiveRecord::Base.connection.execute(sql)
      @task.update(position: new_position)
    end
  end

  def set_task
    @task = user.tasks.find_by(id: id)
    errors.add(:base, 'Task not found') unless @task
  end
end
