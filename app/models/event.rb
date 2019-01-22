class Event < ApplicationRecord
  default_scope -> {order(created_at: :desc)}
  belongs_to :user
  has_many :event_members
  mount_uploaders :files, FilesUploader
  
  validates :title, presence: true, length: {maximum: 20}
  validates :body, length: {maximum: 500}
  validates :files, presence: true
  validates :recruit_num, presence: true, numericality: {only_integer: true,greater_than: 0}
  validates :place, presence: true, length: {maximum: 100}
  validates :event_date, presence: true
  validates :deadline, presence: true
  validates :user_id, presence: true
  
  def self.search(search)
    if search
      Event.joins(:user).where(['users.name LIKE ?',"%#{search["user_name"]}%"]).where(['title LIKE ?',"%#{search["title"]}%"]).where(['place LIKE ?',"%#{search["place"]}%"])
    else
      Event.all
    end
  end
end
