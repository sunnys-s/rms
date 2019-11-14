class Company < ApplicationRecord
    mount_uploader :logo, LoggUploader
end
