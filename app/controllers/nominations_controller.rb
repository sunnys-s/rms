class NominationsController < ApplicationController
  before_action :set_nomination, only: [:show, :edit, :update, :destroy]

  # GET /nominations
  # GET /nominations.json
  def index
    @nominations = Nomination.all
  end

  # GET /nominations/1
  # GET /nominations/1.json
  def show
  end

  # GET /nominations/new
  def new
    @cycle = Cycle.current_cycle
    @awards = @cycle.awards
    @users = User.all
    @nomination = Nomination.new
    @nomination.nominees.build
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

  def team_nomination
    @cycle = Cycle.current_cycle
    @awards = @cycle.awards
    @users = User.all
    @nomination = Nomination.new
    @nomination.nominees.build
    @award = @cycle.awards.find_by(award_master_id: AwardMaster.find_by(title: "The Best Cross-Functional Team").id)
    @nomination.award = @award
    @award.award_master.rating_scales.each do |rs|
      @nomination.ratings.build(title: rs.title)
    end
  end

  def load_rating_form
    @award = Award.find(params[:award_id])
    @rating_scales = @award.award_master.rating_scales
    render partial: 'rating_form'
  end

  # GET /nominations/1/edit
  def edit
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
      if @nomination.save
        format.html { redirect_to @nomination, notice: 'Nomination was successfully created.' }
        format.json { render :show, status: :created, location: @nomination }
      else
        # format.html { render :new }
        # format.json { render json: @nomination.errors, status: :unprocessable_entity }
        render json: @nomination.errors
      end
    end
  end

  # PATCH/PUT /nominations/1
  # PATCH/PUT /nominations/1.json
  def update
    respond_to do |format|
      if @nomination.update(nomination_params)
        format.html { redirect_to @nomination, notice: 'Nomination was successfully updated.' }
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
      format.html { redirect_to nominations_url, notice: 'Nomination was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nomination
      @nomination = Nomination.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nomination_params
      params.require(:nomination).permit(
        :award_id, :nomination_type, 
        :nominator_id, :date, :justification,
        ratings_attributes: [:id, :title, :nomination_id, :value, :_destroy], 
        nominees_attributes: [:id, :nomination_id, :user_id, :emp_code, :_destroy],
        nomination_attachments_attributes: [:id, :nomination_id, :attachment, :destroy]
      )
    end
end
