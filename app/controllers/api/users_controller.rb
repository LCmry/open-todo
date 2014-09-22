class Api::UsersController < Api::BaseController
  before_action :set_response
  respond_to :json

  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(params.permit(:username, :password))
    if @user.save
      render json: @user
    else
      render json: {error: @user.errors.full_messages}, status: 422
    end
  end
end