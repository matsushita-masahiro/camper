class Post < ApplicationRecord
  belongs_to :user
  has_one :like, dependent: :destroy
  mount_uploaders :files, FilesUploader
end
