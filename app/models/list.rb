class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :user_id
  validates :permissions, presence: true
  validates_inclusion_of :permissions, in: %w(private viewable open), message: "not correct."
  validates :user_id, presence: true

  def self.permission_options
    %w(private viewable open)
  end

  def add(item_description)
    if items.create(description: item_description)
      true
    else
      false
    end
  end

  def remove(item_description)
    if item = items.find_by(description: item_description)
      item.mark_complete
    else
      false
    end
  end
end
