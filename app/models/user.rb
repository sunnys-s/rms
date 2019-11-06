class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :roles
  has_many :role_masters, through: :roles
  has_one :employee
  has_many :nominations, as: :nominator

  def admin?
    self.role_masters.map(&:name).include?("admin")
    # true
  end
end
