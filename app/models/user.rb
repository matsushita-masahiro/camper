class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  has_many :posts, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :event_members, dependent: :destroy
  mount_uploader :image, ImageUploader
  
  validates :name, length: {maximum: 30}
  validates :intro, length: {maximum: 140}
  
  def self.search(search)
    if search
      User.where(['name LIKE ?', "%#{search}%"])
    else
      User.all
    end
  end
  
  def self.find_for_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.first_name
      
      image_url=auth.info.image.to_s + "?type=large"
      user.remote_image_url = image_url.gsub("http","https")
    end
  end
end
