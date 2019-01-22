class Post < ApplicationRecord
  belongs_to :user
  has_many :like, dependent: :destroy
  mount_uploaders :files, FilesUploader
  
  validates :user_id, presence: true
  validates :body, length: {maximum: 140}
  validates :files, presence: true
end
