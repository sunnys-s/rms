class Company < ApplicationRecord
    mount_uploader :logo, LogoUploader
    has_and_belongs_to_many :users
    has_many :commitees
end
