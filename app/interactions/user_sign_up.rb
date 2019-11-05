class UserSignUp < ActiveInteraction::Base
  string :email
  string :password
  string :password_confirmation

  validates :email, :password, :password_confirmation, presence: true

  set_callback :type_check, :after, :user

  def execute
    if @user.valid?
      @user.save
    else
      errors.add(:base, @user.errors.full_messages.to_sentence)
    end
  end

  def user
    @user ||= User.new(inputs)
  end
end
