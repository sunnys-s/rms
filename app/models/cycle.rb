class Cycle < ApplicationRecord
    has_many :awards
    has_many :commitees

    after_create :create_cycle_awards, :create_cycle_commitee

    accepts_nested_attributes_for :commitees
    
    def create_cycle_awards
        AwardMaster.all.each do |award_master|
            Award.create(award_master_id: award_master.id, cycle_id: self.id, financial_year: self.start_date.year, half: ((self.start_date.month >= 4 and self.start_date < 10) ? 1 : 2), title: award_master.title, award_type: award_master.award_type)
        end
    end

    def create_cycle_commitee
        levels = ["Level 1", "Appex"]
        levels.each do |level|
            Commitee.create(cycle_id: self.id, level: level)
        end
    end

    def self.current_cycle
        Cycle.where(status: "active").last
    end
end
