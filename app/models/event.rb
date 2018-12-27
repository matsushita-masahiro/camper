class Event < ApplicationRecord
  mount_uploaders :files, FilesUploader
end
