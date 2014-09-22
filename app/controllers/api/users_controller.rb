class Api::UsersController < Api::BaseController
  before_action :set_response
  respond_to :json

  def index
    @users = User.all
    respond_with @users.as_json(only: [:id, :username], root: true)
  end

  def create
    @user = User.new(params.permit(:username, :password))
    if @user.save
      render json: @user.as_json(only: [:username, :password])
    else
      render json: {error: @user.errors.full_messages}, status: 422
    end
  end
end