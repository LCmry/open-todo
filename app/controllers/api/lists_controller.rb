class Api::ListsController < Api::BaseController

  def index
    @user = User.find(params[:user_id])
    @lists = List.all
    render json: @lists.as_json(only: [:name, :permissions])
  end

  def create
    @user = User.find(list_params[:user_id])
    @list = List.new(list_params)
    if @list.save
      render json: @list.as_json(only: [:name, :permissions])
    else
      render json: @list.errors.full_messages
    end
  end

  private

  def list_params
    params.require(:list).permit(:user_id, :name, :permissions)
  end
end