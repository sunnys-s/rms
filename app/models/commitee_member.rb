class CommiteeMember < ApplicationRecord
  belongs_to :commitee
  belongs_to :user
end
