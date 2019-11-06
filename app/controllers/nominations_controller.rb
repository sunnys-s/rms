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
    @nomination = Nomination.new(nomination_params)

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
        :nominator_id, :date, 
        ratings_attributes: [
          :id, :title, :nomination_id, :value, :_destroy
        ], 
        nominees_attributes: 
        [:id, :nomination_id, :user_id, :emp_code, :_destroy]
      )
    end
end
