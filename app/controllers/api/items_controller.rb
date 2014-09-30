class Api::ItemsController < Api::BaseController
  before_filter :restrict_access
  wrap_parameters format: :json

  def create
    @item = Item.new(item_params)
    @list = List.find(params[:list_id])
    if @current_user.can?(:create, @list)
      @item.save
      render json: @list.items.as_json(only: [:description, :completed])
    else
      render json: @item.errors.full_messages
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @list = List.find(params[:list_id])
    if @current_user.can?(:destroy, @list)
      @item.destroy
      render json: {message: "Item destroyed."}
    else
      render json: {error: "Cannot destroy item."}
    end
  end

  private

  def item_params
    params.require(:item).permit(:description, :list_id, :completed)
  end
end