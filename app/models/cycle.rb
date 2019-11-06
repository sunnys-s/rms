class Cycle < ApplicationRecord
    has_many :awards

    after_create :create_cycle_awards

    def create_cycle_awards
        AwardMaster.all.each do |award_master|
            Award.create(award_master_id: award_master.id, cycle_id: self.id, financial_year: self.start_date.year, half: ((self.start_date.month >= 4 and self.start_date < 10) ? 1 : 2), title: award_master.title, award_type: award_master.award_type)
        end
    end

    def self.current_cycle
        Cycle.where(status: "active").last
    end
end
