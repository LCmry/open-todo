class Api::BaseController < ActionController::Base
  before_action :set_response
  respond_to :json
  
  def set_response
    request.format = :json
  end
end