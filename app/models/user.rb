class User < ActiveRecord::Base
  attr_accessor :remember_token
  before_save { self.email_address = email_address.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email_address, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email_address, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  has_many :microposts, dependent: :destroy
  self.per_page = 10
  validates :password, length: { minimum: 6, maximum: 10 }

  has_many :active_relationships,  class_name:  'Relationship',
                                   foreign_key: 'follower_id',
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  mount_uploader :avatar, AvatarUploader
  validate  :picture_size



  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def feed
    Micropost.where("user_id IN (?) OR user_id = ?", following_ids, id)
        end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end
end
private

   # Validates the size of an uploaded picture.
   def picture_size
     if avatar.size > 5.megabytes
       errors.add(:avatar, "should be less than 5MB")
     end
   end

