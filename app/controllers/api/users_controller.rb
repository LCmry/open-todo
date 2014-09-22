class Api::UsersController < Api::BaseController
  before_action :set_response
  respond_to :json

  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user.as_json(only: [:username, :password])
    else
      render json: {error: @user.errors.full_messages}, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end