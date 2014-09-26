class User < ActiveRecord::Base
  has_many :lists
  has_many :items, through: :lists
  has_one :api_key, dependent: :destroy

  validates :username, presence: true
  validates :password, presence: true

  after_create :create_api_key

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

  def create_api_key
    ApiKey.create user: self
  end
end
