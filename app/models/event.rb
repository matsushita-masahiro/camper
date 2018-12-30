class Event < ApplicationRecord
  default_scope -> {order(created_at: :desc)}
  belongs_to :user
  has_many :event_members
  mount_uploaders :files, FilesUploader
end
