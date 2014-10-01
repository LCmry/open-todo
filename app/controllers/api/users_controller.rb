class Api::UsersController < Api::BaseController
  before_filter :restrict_access, except: [:create]
  wrap_parameters format: :json
  
  def create
    @user = User.new(user_params)
    if @user.save
      render "api/users/new.json"
    else
      render json: @user.errors.full_messages
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.id == @current_user.id
      @current_user.destroy
      render json: {message: "User destroyed."}
    else
      render json: {error: "Problem destroying user."}
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end