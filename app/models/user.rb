class User < ActiveRecord::Base

  validates :session_token, :username, :password_digest, presence:true
  validates :session_token, :username, uniqueness: true

  after_initialize :ensure_session_token

  attr_reader :password

  has_many :goals,
    dependent: :destroy

  has_many :comments,
    class_name: "UserComment",
    foreign_key: :user_id,
    dependent: :destroy

  has_many :authored_user_comments,
    class_name: "UserComment",
    foreign_key: :author_id,
    dependent: :destroy

  has_many :authored_goal_comments,
    class_name: "GoalComment",
    foreign_key: :author_id,
    dependent: :destroy


  def self.find_by_credentials(username, password)
    user = User.find_by(username:username)
    return nil unless user
    return user if user.is_password?(password)
    nil
  end

  def self.unique_token(field)
    token = SecureRandom.urlsafe_base64(16)
    while User.exists?( field => token )
      token = SecureRandom.urlsafe_base64(16)
    end
    return token
  end

  def password=(password)
    @password= password
    self.password_digest= BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= User.unique_token(:session_token)
  end

  def reset_session_token!
    self.session_token = User.unique_token(:session_token)
    save!
    self.session_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end











end
