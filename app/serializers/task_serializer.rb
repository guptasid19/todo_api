class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :due_date, :description, :position
end
