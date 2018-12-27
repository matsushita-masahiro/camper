class Event < ApplicationRecord
  belongs_to :user
  has_many :event_members
  mount_uploaders :files, FilesUploader
end
