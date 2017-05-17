class User < ApplicationRecord
  has_many :posts

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name, :last_name

  def full_name
    last_name.upcase + ', ' + first_name.upcase
  end

  def admin_types
    ['AdminUser']
  end

  def is_admin?
    admin_types.include?(type)
  end
end
