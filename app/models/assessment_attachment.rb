class AssessmentAttachment < ApplicationRecord
  mount_uploader :attachment, AssessmentAttachmentUploader
  belongs_to :assessment
end
