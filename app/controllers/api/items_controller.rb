class Api::ItemsController < Api::BaseController
  before_filter :restrict_access
  wrap_parameters format: :json

  def create
    @list = List.find(params[:list_id])
    if @current_user.can?(:create, @list)
      if @list.add(item_params[:description])
        render json: @list.items.as_json(only: [:description, :completed])
      else
        render json: @item.errors.full_messages
      end
    else
      render json: {error: "Error creating item."}
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @current_user.can?(:destroy, @list) && @item.mark_complete
      render json: {message: "Item destroyed."}
    else
      render json: {error: "Can't destroy item."}
    end
  end

  private

  def item_params
    params.require(:item).permit(:description, :list_id, :completed)
  end
end