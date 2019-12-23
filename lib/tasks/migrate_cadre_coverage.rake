namespace :migrate_cadre_coverage do
  desc "TODO"
  task add_coverage: :environment do
    awards = [
      { title: "The Best Cross-Functional Team", cadre_coverage: ["SMC", "MMC", "JMC", "OC"] },
      { title: "The Most Inspiring Leader", cadre_coverage: ["SMC", "MMC"] },
      { title: "The Best Employee", cadre_coverage: ["MMC", "JMC", "OC"] },
      { title: "The Most Innovative Employee", cadre_coverage: ["SMC", "MMC", "JMC", "OC"] },
    ]
    awards.each do |award|
      award_master = AwardMaster.find_by(title: award[:title])
      award_master.cadre_coverage = award[:cadre_coverage]
      award_master.save!
      award_master.awards.each do |a|
        a.cadre_coverage = award[:cadre_coverage]
        a.save!
      end
    end
  end
end
