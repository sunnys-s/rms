class NominationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:push_back, :forward, :l1_approval, :l2_approval, :chairman_approval, :reject_single_nominee]
  before_action :set_nomination, only: [:show, :edit, :update, :destroy, :push_back, :forward, :l1_approval, :l2_approval, :justification, :chairman_approval, :reject_single_nominee]

  # GET /nominations
  # GET /nominations.json
  def index
    @nominations = Nomination.all
  end

  # GET /nominations/1
  # GET /nominations/1.json
  def show
  end

  def justification
    #@nomination = Nomination.find(params[:id]
    render json: {
      justification: @nomination.justification,
      attachment: (@nomination.nomination_attachments.last.attachment.identifier rescue ""),
      url: (@nomination.nomination_attachments.last.attachment.url rescue "#"),
      assessments: @nomination.assessments.as_json(:include => { :assessment_attachments => { only: :attachment } }),
    }
  end

  # GET /nominations/new
  def new
    @cycle = Cycle.current_cycle
    @awards = @cycle.awards - [@cycle.awards.find_by(title: "The Best Cross-Functional Team")]
    @users = current_user.peers.map { |u| ["#{u.emp_code.rjust(5, "0")} | #{u.employee.name rescue ""} | #{u.employee.location rescue ""} | #{u.employee.sbu rescue ""}", u.id] }
    @nomination = Nomination.new
    # @nomination.company_id = current_user.company.id rescue nil
    @nomination.nominees.build
    @nomination.nomination_attachments.build
    # if params[:award_id].nil?
    #   @award = @cycle.awards.last
    # else
    #   @award = Award.find(params[:award_id])
    # end
    # @award.award_master.rating_scales.each do |rs|
    #   @nomination.ratings.build(title: rs.title)
    # end
    # render json: @nomination.ratings
    # return
  end

  def individual_nominations
    @cycle = Cycle.current_cycle
    @type = params[:type]
    if (@type == "tmil")
      @award = @cycle.awards.find_by(title: "The Most Inspiring Leader")
      @users = current_user.peers.select { |u| @award.cadre_coverage.include?(u.employee.cadre) }.map { |u| ["#{u.emp_code.rjust(5, "0") rescue u.emp_code} | #{u.employee.name rescue ""} | #{u.employee.location rescue ""} | #{u.employee.sbu rescue ""}", u.id] }
      @color = "green"
    elsif (@type == "tbe")
      @award = @cycle.awards.find_by(title: "The Best Employee")
      @users = current_user.peers.select { |u| @award.cadre_coverage.include?(u.employee.cadre) }.map { |u| ["#{u.emp_code.rjust(5, "0") rescue u.emp_code} | #{u.employee.name rescue ""} | #{u.employee.location rescue ""} | #{u.employee.sbu rescue ""}", u.id] }
      @color = "blue"
    elsif (@type == "tmie")
      @award = @cycle.awards.find_by(title: "The Most Innovative Employee")
      @users = current_user.peers.select { |u| @award.cadre_coverage.include?(u.employee.cadre) }.map { |u| ["#{u.emp_code.rjust(5, "0") rescue u.emp_code} | #{u.employee.name rescue ""} | #{u.employee.location rescue ""} | #{u.employee.sbu rescue ""}", u.id] }
      @color = "orange"
    elsif (@type == "tbpm")
      @award = @cycle.awards.find_by(title: "The Best Project Manager")
      @users = current_user.peers.select { |u| u.employee.designation == "Project Manager" }.map { |u| ["#{u.emp_code.rjust(5, "0") rescue u.emp_code} | #{u.employee.name rescue ""} | #{u.employee.location rescue ""} | #{u.employee.sbu rescue ""}", u.id] }
      @color = "black"
    end
    @awards = [@award]

    @nomination = Nomination.new
    @nomination.nominees.build
    @nomination.nomination_attachments.build

    @award.award_master.assessment_masters.each do |am|
      a = @nomination.assessments.build(assessment_param: am.assessment_param, statement: am.statement)
      a.assessment_attachments.build
    end
    # render json: @award.award_master.assessment_masters
    # return
  end

  def team_nomination
    @cycle = Cycle.current_cycle
    @nomination = Nomination.new
    # @nomination.company_id = current_user.company.id rescue nil
    @color = "purple"
    @nomination.nominees.build
    @award = @cycle.awards.find_by(title: "The Best Cross-Functional Team")
    @users = current_user.peers.select { |u| @award.cadre_coverage.include?(u.employee.cadre) }.map { |u| ["#{u.emp_code.rjust(5, "0") rescue u.emp_code} | #{u.employee.name rescue ""} | #{u.employee.location rescue ""} | #{u.employee.sbu rescue ""}", u.id] }
    @awards = [@award]
    @nomination.award = @award
    @award.award_master.rating_scales.each do |rs|
      @nomination.ratings.build(title: rs.title)
    end
    @award.award_master.assessment_masters.each do |am|
      a = @nomination.assessments.build(assessment_param: am.assessment_param, statement: am.statement)
      a.assessment_attachments.build
    end
    @nomination.nomination_attachments.build
  end

  def load_rating_form
    @award = Award.find(params[:award_id])
    if !params[:nomination_id].nil?
      @nomination = Nomination.find(params[:nomination_id])
      @rating_scales = @nomination.ratings
    else
      @rating_scales = @award.award_master.rating_scales
    end
    render partial: "rating_form"
  end

  # GET /nominations/1/edit
  def edit
    @cycle = Cycle.current_cycle
    @awards = @cycle.awards
    @award = @nomination.award
    case @award.title
    when "The Most Inspiring Leader"
      @color = "green"
    when "The Best Employee"
      @color = "blue"
    when "The Most Innovative Employee"
      @color = "orange"
    when "The Best Project Manager"
      @color = "black"
    when "The Best Cross-Functional Team"
      @color = "purple"
    end
    @users = current_user.peers.map { |u| ["#{u.emp_code.rjust(5, "0") rescue u.emp_code} | #{u.employee.name rescue ""} | #{u.employee.location rescue ""} | #{u.employee.sbu rescue ""}", u.id] }
    # @selected_nominees = @nomination.nominees
  end

  # POST /nominations
  # POST /nominations.json
  def create
    # render json: params
    # return
    @nomination = Nomination.new(nomination_params)
    if params[:nomination][:nominees_attributes]["0"]["user_id"].class.to_s == "Array"
      @nomination.nominees.destroy_all
      params[:nomination][:nominees_attributes]["0"]["user_id"].each do |u|
        @nomination.nominees.new(user_id: u)
      end
    end
    respond_to do |format|
      @nomination.company_id = current_user.company.id rescue nil
      if @nomination.save
        format.html { redirect_to "/user_dashboard", notice: "Nomination was successfully created." }
        format.json { render :show, status: :created, location: @nomination }
      else
        format.html { redirect_to reverse_map_award_to_keyword(@nomination), notice: @nomination.errors }
        format.json { render json: @nomination.errors, status: :unprocessable_entity }
        # render json: @nomination.errors
      end
    end
  end

  # PATCH/PUT /nominations/1
  # PATCH/PUT /nominations/1.json
  def update
    respond_to do |format|
      if @nomination.update(nomination_params)
        @nomination.state = "review_pending"
        @nomination.save
        format.html { redirect_to "/user_dashboard", notice: "Nomination was successfully updated." }
        format.json { render :show, status: :ok, location: @nomination }
      else
        format.html { render :edit }
        format.json { render json: @nomination.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nominations/1
  # DELETE /nominations/1.json
  def destroy
    @nomination.destroy
    respond_to do |format|
      format.html { redirect_to "/user_dashboard", notice: "Nomination was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def pushback
    render json: params
    return
  end

  # POST /nominations/1/push_back
  def push_back
    @nomination.pushback_reason = params[:reason]
    @nomination.save!
    @nomination.push_back
    render json: { message: "Pushed back successfully" }
    return
  end

  # POST /nominations/1/forward
  def forward
    @nomination.summary = params[:summary]
    @nomination.subcommitee_member_ids = params[:members].map(&:to_i) rescue []
    @nomination.save!
    @nomination.forward
    render json: { message: "Pushed back successfully" }
    return
  end

  def l1_approval
    action_mode = params[:action_mode]
    members = params[:members].map(&:to_i)
    if action_mode == "approve"
      @nomination.l1_approval_reason = params[:comments]
      @nomination.approvers = members
      @nomination.save
      @nomination.l1_approve
      render json: { message: "Approved Successfully" }
      return
    elsif action_mode == "pushback"
      @nomination.pushback_reason = params[:comments]
      @nomination.save!
      @nomination.push_back
      render json: { message: "Approved Successfully" }
      return
    else
      @nomination.l1_rejection_reason = params[:comments]
      @nomination.rejectors = members
      @nomination.save
      @nomination.l1_reject
      render json: { message: "Rejected Successfully" }
      return
    end
  end

  def reject_single_nominee
    @nominee = @nomination.nominees.find_by(user_id: params[:user_id])
    @nominee.l1_rejection_reason = params[:reason]
    @nominee.state = "rejected"
    @nominee.save
    render json: { message: "Rejected Successfully" }
    return
  end

  def l2_approval
    action_mode = params[:action_mode]
    members = params[:members].map(&:to_i)
    if action_mode == "approve"
      @nomination.approvers = @nomination.approvers + members
      @nomination.save
      @nomination.l2_approve
      render json: { message: "Approved Successfully" }
      return
    elsif action_mode == "pushback"
      @nomination.pushback_reason = params[:comments]
      @nomination.save!
      @nomination.push_back
      render json: { message: "Approved Successfully" }
      return
    else
      @nomination.l1_rejection_reason = params[:comments]
      @nomination.rejectors = members
      @nomination.save
      @nomination.l2_reject
      render json: { message: "Rejected Successfully" }
      return
    end
  end

  def chairman_approval
    action_mode = params[:action_mode]
    members = [current_user.id]
    if action_mode == "approve"
      @nomination.approvers = @nomination.approvers + members
      @nomination.save
      @nomination.approve
      render json: { message: "Approved Successfully" }
      return
    elsif action_mode == "pushback"
      @nomination.pushback_reason = params[:reason]
      @nomination.save!
      @nomination.push_back
      render json: { message: "Approved Successfully" }
      return
    else
      # @nomination.l1_rejection_reason = params[:comments]
      @nomination.rejectors = members
      @nomination.save
      @nomination.reject
      render json: { message: "Rejected Successfully" }
      return
    end
  end

  private

  def reverse_map_award_to_keyword(nomination)
    @award = nomination.award
    case @award.title
    when "The Most Inspiring Leader"
      "/individual_nominations/tmil"
    when "The Best Employee"
      "/individual_nominations/tbe"
    when "The Most Innovative Employee"
      "/individual_nominations/tmie"
    when "The Best Project Manager"
      "/individual_nominations/tbpm"
    when "The Best Cross-Functional Team"
      "team_nominations/new"
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_nomination
    @nomination = Nomination.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def nomination_params
    params.require(:nomination).permit(
      :award_id, :nomination_type, :nominator_type,
      :nominator_id, :date, :justification, :user_id,
      :summary, :review_feedback, :company_id, :subcommitee_member_ids,
      :innovativeness, :agility, :responsiveness, :performance_driven, :ownership,
      ratings_attributes: [:id, :title, :nomination_id, :value, :_destroy],
      nominees_attributes: [:id, :nomination_id, :user_id, :emp_code, :_destroy],
      nomination_attachments_attributes: [:id, :nomination_id, :attachment, :_destroy],
      assessments_attributes: [:id, :nomination_id, :assessment_param, :statement, :feedback, :value_addition, :_destroy,
                               assessment_attachments_attributes: [:id, :assessment_id, :attachment, :_destroy]],
    )
  end
end
