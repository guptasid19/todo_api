class UsersController < ApplicationController

  skip_before_action :authenticate_request

  def create
    user = UserSignUp.run(sign_up_params)
    return render_error_response(user.errors.full_messages.to_sentence) if user.errors.present?
    render_success_response('User successfully signed up.')
  end

  private

  def sign_up_params
    params.permit(:email, :password_confirmation, :password)
  end
end