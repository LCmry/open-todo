class User < ActiveRecord::Base
  has_many :lists
  has_many :items, through: :lists

  validates :username, presence: true
  validates :password, presence: true

  def authenticate?(pass)
    password == pass
  end

  def can?(action, list)
    case list.permissions
    when 'private'  then owns?(list)
    when 'visible'  then action == :view
    when 'open' then true
    else false
    end
  end

  private

  def owns?(list)
    list.user_id == id
  end
end
