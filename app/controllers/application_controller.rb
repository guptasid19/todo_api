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

  def pagination_dict(collection)
    {
      total_count: collection.count,
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.previous_page,
      total_pages: collection.total_pages
    }
  end

  def render_collection(collection, options = {})
    render_args = { json: collection, meta: pagination_dict(collection).merge(options) }.merge(options)
    render render_args
  end
end