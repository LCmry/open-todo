class Api::ListsController < Api::BaseController
  before_filter :restrict_access, except: [:index]
  wrap_parameters format: :json

  def index
    if restrict_access_by_header
      @lists = @api_key.user.lists
    else
      @lists = List.all(conditions: ["permissions != ?", 'private'])
    end
    render json: @lists.as_json(only: [:id, :name, :permissions])
  end

  def create
    lp = list_params
    lp[:user_id] = @current_user.id
    @list = List.new(lp)
    if @list.save
      render json: @list.as_json(only: [:id, :name, :permissions])
    else
      render json: @list.errors.full_messages
    end
  end

  def destroy
    @list = List.find(params[:id])
    if @current_user.can?(:destroy, @list)
      @list.destroy
      render json: {message: "List was destroyed."}
    else
      render json: {error: "Problem destroying list."}
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :permissions, :user_id)
  end
end