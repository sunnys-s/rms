class Assessment < ApplicationRecord
  belongs_to :nomination
  has_many :assessment_attachments, dependent: :destroy
  accepts_nested_attributes_for :assessment_attachments, reject_if: :all_blank, allow_destroy: true
end
