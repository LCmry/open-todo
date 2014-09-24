class Api::ListsController < Api::BaseController

  def create
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