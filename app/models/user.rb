# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string
#  password_digest :string
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord

  validates :username,:password_digest, presence: true
  validates :password, length:{minimum:6,allow_nil:true}
  before_validation :ensure_session_token

  has_many :sub_moderator,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: :Sub

    has_many :posts,
      primary_key: :id,
      foreign_key: :author_id,
      class_name: :Post

attr_reader :password
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token
    self.session_token = nil
    generate_session_token
    self.save
    self.session_token
  end

  def generate_session_token
    self.session_token = SecureRandom.urlsafe_base64
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def self.find_by_credentials(username,password)
    @user = User.find_by(username: username)
    if @user && @user.is_password?(password)
      return @user
    else
      nil
    end
  end

end
