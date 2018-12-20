class Post < ApplicationRecord
  belongs_to :user
  mount_uploaders :files, FilesUploader
end
