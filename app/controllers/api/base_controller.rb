class Api::BaseController < ActionController::Base
  def set_response
    request.format = :json
  end
end