class HomesController < ApplicationController
  # GET /homes
  # GET /homes.json
  def index
    if current_user.hr?
      @cycle = Cycle.current_cycle
      @awards = @cycle.awards
      @current_location = current_user.employee.location
      location_peer_ids = Employee.where(location: @current_location).map(&:user_id)
      @most_inspiring_leaders_nominations = @awards.find_by(title: "The Most Inspiring Leader").nominations.where(company_id: current_user.company.id, nominator_id: location_peer_ids)
      @best_employee_nominations = @awards.find_by(title: "The Best Employee").nominations.where(company_id: current_user.company.id, nominator_id: location_peer_ids)
      @most_innovative_employee_nominations = @awards.find_by(title: "The Most Innovative Employee").nominations.where(company_id: current_user.company.id, nominator_id: location_peer_ids)
      @best_team_nominations = @awards.find_by(title: "The Best Cross-Functional Team").nominations.where(nominator_id: location_peer_ids)
      # @commitee_members = @cycle.commitees.find_by(level: "Level 1 for #{current_user.company.name}", company_id: current_user.company.id).commitee_members.map{|i| i.user.employee}.flatten
      @commitee_members = @cycle.commitees.find_by(level: "Level 1 for #{current_user.company.name}").commitee_members.map{|u| ["#{u.user.emp_code} | #{u.user.employee.name rescue ""} | #{u.user.employee.location rescue ""} | #{u.user.employee.sbu rescue ""}", u.user.id]}.flatten
      # render json: @commitee_members
      # return
    elsif((current_user.l1? or current_user.l1_rep?) and is_member(@cycle, current_user))
      redirect_to '/l1_dashboard'
    elsif(current_user.l2? or current_user.l2_rep?)
      redirect_to '/l2_dashboard'
    elsif(current_user.chairman?)
      redirect_to '/chairman_dashboard'
    else
      redirect_to '/user_dashboard'
    end
  end

  def l1_dashboard
    @cycle = Cycle.current_cycle
    if is_member(@cycle, current_user)
      @awards = @cycle.awards
      states = ["l1_review_pending", "l2_review_pending", "rejected"]
      @most_inspiring_leaders_nominations = @awards.find_by(title: "The Most Inspiring Leader").nominations.where(:state => states, company_id: current_user.company.id) rescue []
      @best_employee_nominations = @awards.find_by(title: "The Best Employee").nominations.where(:state => states, company_id: current_user.company.id) rescue []
      @most_innovative_employee_nominations = @awards.find_by(title: "The Most Innovative Employee").nominations.where(:state => states, company_id: current_user.company.id) rescue []
      @best_team_nominations = @awards.find_by(title: "The Best Cross-Functional Team").nominations.where(:state => states) rescue []
      #@commitee_members = @cycle.commitees.find_by(level: "Level 1", company_id: current_user.company.id).commitee_members.map{|i| i.user.employee}.flatten
      @commitee_members = @cycle.commitees.find_by(level: "Level 1 for #{current_user.company.name}", company_id: current_user.company.id).commitee_members.map{|i| i.user.employee}.flatten
    else
      redirect_to '/', alert: "You are not authorized for that action."
    end
  end

  def l2_dashboard
    @cycle = Cycle.current_cycle
    @awards = @cycle.awards
    states = ["l2_review_pending", "final_review_pending", "approved", "rejected"]
    @most_inspiring_leaders_nominations = @awards.find_by(title: "The Most Inspiring Leader").nominations.where(:state => states, company_id: current_user.company.id) rescue []
    @best_employee_nominations = @awards.find_by(title: "The Best Employee").nominations.where(:state => states, company_id: current_user.company.id)  rescue []
    @most_innovative_employee_nominations = @awards.find_by(title: "The Most Innovative Employee").nominations.where(:state => states, company_id: current_user.company.id)  rescue []
    @best_team_nominations = @awards.find_by(title: "The Best Cross-Functional Team").nominations.where(:state => states)  rescue []
    #@commitee_members = @cycle.commitees.find_by(level: "Appex", company_id: current_user.company.id).commitee_members.map{|i| i.user.employee}.flatten
    @commitee_members = @cycle.commitees.find_by(level: "Appex for #{current_user.company.name}", company_id: current_user.company.id).commitee_members.map{|i| i.user.employee}.flatten
  end

  def chairman_dashboard
    @cycle = Cycle.current_cycle
    @awards = @cycle.awards
    states = ["final_review_pending","approved"]
    @most_inspiring_leaders_nominations = @awards.find_by(title: "The Most Inspiring Leader").nominations.where(:state => states) rescue []
    @best_employee_nominations = @awards.find_by(title: "The Best Employee").nominations.where(:state => states) rescue []
    @most_innovative_employee_nominations = @awards.find_by(title: "The Most Innovative Employee").nominations.where(:state => states) rescue []
    @best_team_nominations = @awards.find_by(title: "The Best Cross-Functional Team").nominations.where(:state => states) rescue []

    @most_inspiring_leaders_verdict = @awards.find_by(title: "The Most Inspiring Leader").final_verdict rescue ''
    @best_employee_verdict = @awards.find_by(title: "The Best Employee").final_verdict rescue ''
    @most_innovative_employee_verdict = @awards.find_by(title: "The Most Innovative Employee").final_verdict rescue ''
    @best_team_verdict = @awards.find_by(title: "The Most Innovative Employee").final_verdict rescue ''
  end

  def user_dashboard
    @cycle = Cycle.current_cycle
    @team_award = @cycle.awards.find_by(title: "The Best Cross-Functional Team")
    @my_nominees = Nomination.where(nominator_id: current_user.id)
    @my_default_nominees = []
    @my_team_nominees = []
    @my_nominees.each do |mn|
      if mn.award_id == @team_award.id
        @my_team_nominees << mn
      else
        @my_default_nominees << mn
      end
    end
  end

end
