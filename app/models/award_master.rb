class AwardMaster < ApplicationRecord
    has_many :awards
    has_many :rating_scales
end
