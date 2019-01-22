class Relationship < ApplicationRecord
  has_many :users
  
  validates :user_id, presence: true, :uniqueness => {:scope => :friend_id}
  validates :friend_id, presence: true
  validates :status, presence: true
end
