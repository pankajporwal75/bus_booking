class User < ApplicationRecord
  # Devise for Authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
   # Associations
  has_many :reservations, dependent: :destroy
  has_one_attached :profile_image
  has_many :buses, foreign_key: "bus_owner_id", dependent: :destroy
  
  # Enum
  enum role: { user: 'user', bus_owner: 'bus_owner', admin: 'admin' }

  # Validations
  validates :name, presence: true
  validates :email, format: { with: /\S+@\S+/ }, uniqueness: {case_sensitive: false}
  validate :valid_image

# Methods
  def generate_otp
    otp = '%06d' % rand(10**6)
    otp_sent_at = Time.now
    update(otp: otp, otp_sent_at: otp_sent_at)
    return otp
  end

  def valid_otp?(entered_otp)
    delay = (Time.now - otp_sent_at)
    return true if (entered_otp == self.otp) && (delay < 15.minutes)
  end

  def send_otp_email
    otp = generate_otp
    OtpMailer.send_verification_otp(self, otp).deliver_now
  end

  def valid_image
    return unless profile_image.attached?
    valid_types = ["image/jpeg", "image/png", "image/jpg", "image/webp"]
    unless valid_types.include?(profile_image.blob.content_type)
      errors.add(:profile_image, "must be a JPEG or PNG")
    end
  end
end
