class AwardMastersController < ApplicationController
  before_action :set_award_master, only: [:show, :edit, :update, :destroy]

  # GET /award_masters
  # GET /award_masters.json
  def index
    @award_masters = AwardMaster.all
  end

  # GET /award_masters/1
  # GET /award_masters/1.json
  def show
  end

  # GET /award_masters/new
  def new
    @award_master = AwardMaster.new
  end

  # GET /award_masters/1/edit
  def edit
  end

  # POST /award_masters
  # POST /award_masters.json
  def create
    @award_master = AwardMaster.new(award_master_params)

    respond_to do |format|
      if @award_master.save
        format.html { redirect_to @award_master, notice: 'Award master was successfully created.' }
        format.json { render :show, status: :created, location: @award_master }
      else
        format.html { render :new }
        format.json { render json: @award_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /award_masters/1
  # PATCH/PUT /award_masters/1.json
  def update
    respond_to do |format|
      if @award_master.update(award_master_params)
        format.html { redirect_to @award_master, notice: 'Award master was successfully updated.' }
        format.json { render :show, status: :ok, location: @award_master }
      else
        format.html { render :edit }
        format.json { render json: @award_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /award_masters/1
  # DELETE /award_masters/1.json
  def destroy
    @award_master.destroy
    respond_to do |format|
      format.html { redirect_to award_masters_url, notice: 'Award master was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_award_master
      @award_master = AwardMaster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def award_master_params
      params.require(:award_master).permit(:title, :award_type)
    end
end
