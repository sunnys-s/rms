namespace :migrate_award_master_assessment do
  desc "TODO"
  task create_project_manager: :environment do
    am = AwardMaster.create!(title: "The Best Project Manager", award_type: "The Best Project Manager".underscore)
    ["Monitoring", "Change Management", "Risk mitigation", "Compliance", "Reporting"].each do |rating|
      RatingScale.create(title: rating, award_master_id: am.id)
    end
    Cycle.all.each do |c|
      Award.create(award_master_id: am.id, cycle_id: c.id, financial_year: c.start_date.year, half: ((c.start_date.month >= 4 and c.start_date < 10) ? 1 : 2), title: am.title, award_type: am.award_type)
    end
  end

  desc "TODO"
  task create_assessment_masters: :environment do
    @award_master = AwardMaster.find_by(title: "The Most Inspiring Leader")
    @award_master.assessment_masters.create!(assessment_param: "Innovative | Innovation", statement: "Why was or is the innovation required? (need for this innovation)")
    @award_master.assessment_masters.create!(assessment_param: "Innovative | Innovation", statement: "What is the innovation about?")
    @award_master.assessment_masters.create!(assessment_param: "Innovative | Innovation", statement: "When was the innovation initiated and completed? (mention From Month & Year - To Month & Year - approximate timeline)")
    @award_master.assessment_masters.create!(assessment_param: "Innovative | Innovation", statement: "Where is or can the innovation be applied?")
    @award_master.assessment_masters.create!(assessment_param: "Innovative | Innovation", statement: "How the innovation has resulted or will result in value addition to business | company objective? (Monetary or Non-Monetary terms)")
    @award_master.assessment_masters.create!(assessment_param: "Agility", statement: "Why was the change required?")
    @award_master.assessment_masters.create!(assessment_param: "Agility", statement: "What was the situation or change all about?")
    @award_master.assessment_masters.create!(assessment_param: "Agility", statement: "Where has the situation change happened?")
    @award_master.assessment_masters.create!(assessment_param: "Agility", statement: "How was the change management delivered?")
    @award_master.assessment_masters.create!(assessment_param: "Agility", statement: "What was the impact of the change in terms of stakeholder value creation?")
    @award_master.assessment_masters.create!(assessment_param: "Responsive", statement: "What was the situation which demanded a response?")
    @award_master.assessment_masters.create!(assessment_param: "Responsive", statement: "How was the response managed?")
    @award_master.assessment_masters.create!(assessment_param: "Responsive", statement: "How was the team encouraged to respond to situation or change?")
    @award_master.assessment_masters.create!(assessment_param: "Responsive", statement: "How was stakeholder delight achieved?")
    @award_master.assessment_masters.create!(assessment_param: "Performance driven | Performance delivery", statement: "What did the Nominee do to lead by example?")
    @award_master.assessment_masters.create!(assessment_param: "Performance driven | Performance delivery", statement: "How did the Nominee manage team motivations for performance outcomes?")
    @award_master.assessment_masters.create!(assessment_param: "Performance driven | Performance delivery", statement: "How were the solutions to issues or situations thought about?")
    @award_master.assessment_masters.create!(assessment_param: "Performance driven | Performance delivery", statement: "Where has the delivery impacted?")
    @award_master.assessment_masters.create!(assessment_param: "Ownership", statement: "How did the Nominee respond to adverse situations?")
    @award_master.assessment_masters.create!(assessment_param: "Ownership", statement: "How has the Nominee demonstrated ownership of people or processes or situations or results?")
    @award_master.assessment_masters.create!(assessment_param: "Ownership", statement: "Describe the efforts taken by Nominee to support a colleague | team member overcome difficult situation or deliver as per expectations")
    @award_master.assessment_masters.create!(assessment_param: "Ownership", statement: "Mention initiatives taken by the Nominee to train or coach colleagues to facilitate their professional development")

    @award_master = AwardMaster.find_by(title: "The Best Employee")
    @award_master.assessment_masters.create!(assessment_param: "Initiative", statement: "Willing to accept assigned jobs readiness to take-up new responsibility (even beyond routine scope), devise new methods and experiment new ways to facilitate in achieving business objectives")
    @award_master.assessment_masters.create!(assessment_param: "Collaboration", statement: "Demonstrate collaborative working relationships, empathize with others' situations and exhibits positive attitude in achieving the goal")
    @award_master.assessment_masters.create!(assessment_param: "Quality of Work", statement: "Focus on accuracy, attention to details and thoroughness in completing required tasks")
    @award_master.assessment_masters.create!(assessment_param: "Quantity of Work", statement: "Focus on timeliness and volume of work completed")
    @award_master.assessment_masters.create!(assessment_param: "Adaptability", statement: "Ability to work under challenging situations, grasp the need of the situation and adapt to changing scenario")
    @award_master.assessment_masters.create!(assessment_param: "Problem Solving", statement: "Ability to identify the problem, exercise sound judgement and initiate actions for resolving the problem situations")
    @award_master.assessment_masters.create!(assessment_param: "Dependability", statement: "Follows established norms, rules and guidelines, is punctual and available, is ready to go that extra mile")

    @award_master = AwardMaster.find_by(title: "The Most Innovative Employee")
    @award_master.assessment_masters.create!(assessment_param: "Vision", statement: "Sees new possibilities; explores untried or untested methods, ")
    @award_master.assessment_masters.create!(assessment_param: "Ideation", statement: "Is receptive to new ideas, information and experiences; garners details to build or create an idea for implementation")
    @award_master.assessment_masters.create!(assessment_param: "Planning", statement: "Develops step-wise actions with risk mitigation controls, shares with stakeholders and implements")
    @award_master.assessment_masters.create!(assessment_param: "Execution", statement: "Implements the idea, works around unexpected scenarios to achieve the desired outcome and realized the goal")
    @award_master.assessment_masters.create!(assessment_param: "Documentation", statement: "Documents the process, supporting data and keeps stakeholders abreast of progress")
    @award_master.assessment_masters.create!(assessment_param: "Outcome", statement: "Details and data are recorded and customizable for replication across the organization (as applicable)")

    @award_master = AwardMaster.find_by(title: "The Best Cross-Functional Team")
    @award_master.assessment_masters.create!(assessment_param: "Team goal", statement: "Describe the team goal and its impact on business objectives")
    @award_master.assessment_masters.create!(assessment_param: "Service delivery", statement: "Process to set expectations with stakeholders, establish agreement and metrices for measuring delivery against targets")
    @award_master.assessment_masters.create!(assessment_param: "Respect and Appreciation", statement: "Maintain dignity, be respectful and supportive to all team members; be aware of other's work commitments or concerns faced, recognize small or large contributions to the team goal and express open appreciation")
    @award_master.assessment_masters.create!(assessment_param: "Collaboration", statement: "Seek inputs, request support from others, exhibit readiness to go that extra mile, maintain enthusiasm")
    @award_master.assessment_masters.create!(assessment_param: "Documentation", statement: "Document the process followed, problems or situations faced, list of ideas & alternatives generated, solutions implemented with support data")
    @award_master.assessment_masters.create!(assessment_param: "Deliverables and replication", statement: "Deliver on the agreed goal, present objectives vis-à-vis achievement, share learning along with possible customization for replication across organization")

    @award_master = AwardMaster.find_by(title: "The Best Project Manager")
    @award_master.assessment_masters.create!(assessment_param: "Project guidelines, monitoring mechanism", statement: "Establish guidelines at beginning of project, developing and communicating methodology to monitor & track progress")
    @award_master.assessment_masters.create!(assessment_param: "Managing change requests and proposals", statement: "Review, evaluate proposals, deliberate and incorporate needed changes to project in an effective manner")
    @award_master.assessment_masters.create!(assessment_param: "Risk mitigation | control plans", statement: "Develop and implement mechanisms and guidelines to mitigate risk situations")
    @award_master.assessment_masters.create!(assessment_param: "Project Financials", statement: "Thoroughly monitor and validate project spends, exercise required controls to meet budget")
    @award_master.assessment_masters.create!(assessment_param: "Compliance to project guidelines", statement: "Track and monitor project milestones vis-à-vis agreed guidelines; raise caution timely; pursue concerned stakeholders | functions to ensure project deadlines are met")
    @award_master.assessment_masters.create!(assessment_param: "Compliance to legal and safety requirements", statement: "Ensure adherence to all legal aspects and established safety standards")
    @award_master.assessment_masters.create!(assessment_param: "Reporting and communication within team", statement: "Review project status reports, share feedback and expectations periodically and keep team updated about progress")
    @award_master.assessment_masters.create!(assessment_param: "Reporting and communication with stakeholders", statement: "Share project status report, clarify expectations and actions, seek support wherever and whenever needed and maintain a continual flow of information")
    @award_master.assessment_masters.create!(assessment_param: "Project activity transparency", statement: "Communicate right information to stakeholders, share right feedback with team, maintain transparency in dealings with external agencies and document project activities with required supporting")
    @award_master.assessment_masters.create!(assessment_param: "Project outcomes met", statement: "Deliver project as per agreed plan, handhold the implementation team to establish the outcomes and provide required post-project support")
  end
end
