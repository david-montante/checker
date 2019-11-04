class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :assists
  enum role: %i[user admin]

  validates :first_name, presence: true, length: {maximum: 100, allow_blank: false}
  validates :last_name, presence: true, length: {maximum: 100, allow_blank: false}

  def full_name
    (first_name.to_s + ' ' + last_name.to_s).titleize
  end
end
