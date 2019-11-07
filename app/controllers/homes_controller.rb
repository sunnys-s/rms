class HomesController < ApplicationController
  # GET /homes
  # GET /homes.json
  def index
    @cycle = Cycle.current_cycle
    @awards = @cycle.awards
    @most_inspiring_leaders_nominations = @awards.find_by(title: "The Most Inspiring Leader").nominations
    @best_employee_nominations = @awards.find_by(title: "The Best Employee").nominations
    @most_innovative_employee_nominations = @awards.find_by(title: "The Most Innovative Employee").nominations
    @best_team_nominations = @awards.find_by(title: "The Best Cross-Functional Team").nominations
  end

  def l1_dashboard
    @cycle = Cycle.current_cycle
    @awards = @cycle.awards
    @most_inspiring_leaders_nominations = @awards.find_by(title: "The Most Inspiring Leader").nominations
    @best_employee_nominations = @awards.find_by(title: "The Best Employee").nominations
    @most_innovative_employee_nominations = @awards.find_by(title: "The Most Innovative Employee").nominations
    @best_team_nominations = @awards.find_by(title: "The Best Cross-Functional Team").nominations
  end

  def l2_dashboard
    @cycle = Cycle.current_cycle
    @awards = @cycle.awards
    @most_inspiring_leaders_nominations = @awards.find_by(title: "The Most Inspiring Leader").nominations
    @best_employee_nominations = @awards.find_by(title: "The Best Employee").nominations
    @most_innovative_employee_nominations = @awards.find_by(title: "The Most Innovative Employee").nominations
    @best_team_nominations = @awards.find_by(title: "The Best Cross-Functional Team").nominations
  end

  def chairman_dashboard
    @cycle = Cycle.current_cycle
    @awards = @cycle.awards
    @most_inspiring_leaders_nominations = @awards.find_by(title: "The Most Inspiring Leader").nominations
    @best_employee_nominations = @awards.find_by(title: "The Best Employee").nominations
    @most_innovative_employee_nominations = @awards.find_by(title: "The Most Innovative Employee").nominations
    @best_team_nominations = @awards.find_by(title: "The Best Cross-Functional Team").nominations
  end
end
