class NominationAttachment < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader
  belongs_to :nomination
end
