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

  def hr?
    self.role_masters.map(&:name).include?('hr')
  end


  def l1?
    self.role_masters.map(&:name).include?('l1')
  end

  def l2?
    self.role_masters.map(&:name).include?('l2')
  end

  def chairman?
    self.role_masters.map(&:name).include?('chairman')
  end

  def l1_rep?
    self.role_masters.map(&:name).include?('l1_rep')
  end

  def l2_rep?
    self.role_masters.map(&:name).include?('l2_rep')
  end
end
