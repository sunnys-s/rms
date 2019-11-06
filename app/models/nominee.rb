class Nominee < ApplicationRecord
  belongs_to :nomination
  belongs_to :user
end
