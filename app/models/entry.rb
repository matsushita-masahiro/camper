class Entry < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true, :uniqueness => {:scope => :room_id}
  validates :room_id, presence: true
end
