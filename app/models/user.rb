class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :roles, dependent: :destroy
  has_many :role_masters, through: :roles
  has_one :employee, dependent: :destroy
  has_many :nominations, as: :nominator, dependent: :destroy
  has_many :nominees, dependent: :destroy
  ############################################
  has_many :commitee_members, dependent: :destroy
  ############################################

  has_and_belongs_to_many :companies
  accepts_nested_attributes_for :employee

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

  def peers
    self.companies.map{|c| c.users}.flatten.compact
  end

  def self.all_hr
    RoleMaster.includes(users: :employee).find_by(name: "hr").users
  end

  def self.all_hr_group_by_location
    RoleMaster.includes(users: :employee).find_by(name: "hr").users.group_by{ |i| i.employee.location }
  end

  def self.user_ids_by_locations(location)
    Employee.where(location: location).map(&:user_id)
  end

  def company
    # TODO: Send some other value if condition does not matched
    self.companies.size == 1 ? self.companies.last : self.companies.last
  end

  def self.notify_all_hr
    User.all_hr_group_by_location.map do |location, users| 
      award_status = Cycle.pending_status_by_location(location)
      users.each do |user|
        NotificationMailer.notify_hr(user, award_status).deliver_later
      end
    end
  end
  
end
