class Api::UsersController < Api::BaseController
  before_filter :restrict_access, except: [:create]
  
  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render "api/users/new.json"
    else
      render json: @user.errors.full_messages
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end