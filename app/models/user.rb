class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reservations, dependent: :destroy
  has_one_attached :profile_image
  has_many :buses, foreign_key: "bus_owner_id", dependent: :destroy
  enum role: { user: 'user', bus_owner: 'bus_owner', admin: 'admin' }

  validates :name, presence: true
  validates :email, format: { with: /\S+@\S+/ }, uniqueness: {case_sensitive: false}
  validate :valid_image


  def valid_image
    return unless profile_image.attached?
    valid_types = ["image/jpeg", "image/png", "image/jpg", "image/webp"]
    unless valid_types.include?(profile_image.blob.content_type)
      errors.add(:profile_image, "must be a JPEG or PNG")
    end
  end
end
