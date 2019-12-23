class Cycle < ApplicationRecord
    has_many :awards, dependent: :destroy
    has_many :commitees, dependent: :destroy

    after_create :create_cycle_awards, :create_cycle_commitee

    accepts_nested_attributes_for :commitees
    
    def create_cycle_awards
        AwardMaster.all.each do |award_master|
            Award.create(award_master_id: award_master.id, cycle_id: self.id, financial_year: self.start_date.year, half: ((self.start_date.month >= 4 and self.start_date < 10) ? 1 : 2), title: award_master.title, award_type: award_master.award_type, cadre_coverage: award_master.cadre_coverage)
        end
    end

    def create_cycle_commitee
        Company.all.each do |company|
            levels = ["Level 1 for #{company.name}", "Appex for #{company.name}"]
            levels.each do |level|
                Commitee.create(cycle_id: self.id, level: level, company_id: company.id)
            end
        end
    end

    def self.pending_status_by_location(location)
        @awards = current_cycle.awards.map{ |i| {title: i.title, count: i.pending_count_by_location(location) }}
    end

    def self.current_cycle
        Cycle.where(status: "active").last
    end
end
