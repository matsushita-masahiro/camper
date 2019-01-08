class Event < ApplicationRecord
  default_scope -> {order(created_at: :desc)}
  belongs_to :user
  has_many :event_members
  mount_uploaders :files, FilesUploader
  
  def self.search(search)
    if search
      Event.joins(:user).where(['users.name LIKE ?',"%#{search["user_name"]}%"]).where(['title LIKE ?',"%#{search["title"]}%"]).where(['place LIKE ?',"%#{search["place"]}%"])
    else
      Event.all
    end
  end
end
