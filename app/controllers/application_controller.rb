class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def render_not_found_response(message)
    render_response(message, 404)
  end

  def render_success_response(message)
    render_response(message, 200)
  end

  def render_error_response(message)
    render_response(message, 400)
  end

  def render_response(message, code)
    render json: { message: message }, status: code
  end
end