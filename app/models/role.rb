class Role < ApplicationRecord
  belongs_to :user
  belongs_to :role_master
end
