class Message < ApplicationRecord
  belongs_to :user
  
  validates :body, presence: true
  validates :user_id, presence: true
  validates :room_id, presence: true
end
