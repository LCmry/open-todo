class Api::BaseController < ActionController::Base
  before_action :set_response
  respond_to :json
  
  def set_response
    request.format = :json
  end

  private

  def restrict_access
    unless restrict_access_by_header
      render json: {message: 'Invalid API token'}, status: 401
      return
    end
    @current_user = @api_key.user if @api_key
  end

  def restrict_access_by_header
    return true if @api_key

    authenticate_with_http_token do |token|
      @api_key = ApiKey.find_by_token(token)
    end
  end
end
# Above methods and api process from https://www.amberbit.com/blog/2014/2/19/building-and-documenting-api-in-rails/