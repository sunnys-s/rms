class HomesController < ApplicationController
  # GET /homes
  # GET /homes.json
  def index
    if current_user.hr?
      @cycle = Cycle.current_cycle
      @awards = @cycle.awards
      @most_inspiring_leaders_nominations = @awards.find_by(title: "The Most Inspiring Leader").nominations
      @best_employee_nominations = @awards.find_by(title: "The Best Employee").nominations
      @most_innovative_employee_nominations = @awards.find_by(title: "The Most Innovative Employee").nominations
      @best_team_nominations = @awards.find_by(title: "The Best Cross-Functional Team").nominations
    elsif(current_user.l1? or current_user.l1_rep?)
      redirect_to '/l1_dashboard'
    elsif(current_user.l1? or current_user.l2_rep?)
      redirect_to '/l2_dashboard'
    elsif(current_user.chairman?)
      redirect_to '/chairman_dashboard'
    else
      redirect_to '/user_dashboard'
    end
  end

  def l1_dashboard
    @cycle = Cycle.current_cycle
    @awards = @cycle.awards
    states = ["l1_review_pending", "l2_review_pending", "rejected"]
    @most_inspiring_leaders_nominations = @awards.find_by(title: "The Most Inspiring Leader").nominations.where(:state => states)
    @best_employee_nominations = @awards.find_by(title: "The Best Employee").nominations.where(:state => states)
    @most_innovative_employee_nominations = @awards.find_by(title: "The Most Innovative Employee").nominations.where(:state => states)
    @best_team_nominations = @awards.find_by(title: "The Best Cross-Functional Team").nominations.where(:state => states)
    @commitee_members = @cycle.commitees.find_by(level: "Level 1").commitee_members.map{|i| i.user.employee}.flatten
  end

  def l2_dashboard
    @cycle = Cycle.current_cycle
    @awards = @cycle.awards
    states = ["l2_review_pending", "approved", "rejected"]
    @most_inspiring_leaders_nominations = @awards.find_by(title: "The Most Inspiring Leader").nominations.where(:state => states)
    @best_employee_nominations = @awards.find_by(title: "The Best Employee").nominations.where(:state => states)
    @most_innovative_employee_nominations = @awards.find_by(title: "The Most Innovative Employee").nominations.where(:state => states)
    @best_team_nominations = @awards.find_by(title: "The Best Cross-Functional Team").nominations.where(:state => states)
    @commitee_members = @cycle.commitees.find_by(level: "Appex").commitee_members.map{|i| i.user.employee}.flatten
  end

  def chairman_dashboard
    @cycle = Cycle.current_cycle
    @awards = @cycle.awards
    states = ["approved"]
    @most_inspiring_leaders_nominations = @awards.find_by(title: "The Most Inspiring Leader").nominations.where(:state => states)
    @best_employee_nominations = @awards.find_by(title: "The Best Employee").nominations.where(:state => states)
    @most_innovative_employee_nominations = @awards.find_by(title: "The Most Innovative Employee").nominations.where(:state => states)
    @best_team_nominations = @awards.find_by(title: "The Best Cross-Functional Team").nominations.where(:state => states)

    @most_inspiring_leaders_verdict = @awards.find_by(title: "The Most Inspiring Leader").final_verdict
    @best_employee_verdict = @awards.find_by(title: "The Best Employee").final_verdict
    @most_innovative_employee_verdict = @awards.find_by(title: "The Most Innovative Employee").final_verdict
    @best_team_verdict = @awards.find_by(title: "The Most Innovative Employee").final_verdict
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
