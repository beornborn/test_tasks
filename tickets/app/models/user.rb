class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :tickets
  has_many :comments

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true

  def to_s
    name
  end
end
