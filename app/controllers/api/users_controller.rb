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
      respond_with @user.errors.full_messages
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end