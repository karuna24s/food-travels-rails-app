class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  has_many :destinations
  has_many :foods, through: :destinations
  has_many :comments

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.most_destinations
    User.joins(:destinations).group(:user_id).order("count(user_id) DESC").first.email
  end

end
