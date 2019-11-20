class CommiteeMember < ApplicationRecord
  belongs_to :commitee
  belongs_to :user

  after_create :assign_role

  def assign_role
    level = self.commitee.level
    if level.include?("Level 1")
      user = self.user
      user.role_masters << RoleMaster.find_by(name: 'l1')
      user.role_masters << RoleMaster.find_by(name: 'l1_rep')
      user.save
    elsif level.include?("Appex")
      user = self.user
      user.role_masters << RoleMaster.find_by(name: 'l2')
      user.role_masters << RoleMaster.find_by(name: 'l2_rep')
      user.save
    end
  end
end
