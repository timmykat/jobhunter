class OpportunitiesController < ApplicationController
  before_action :set_opportunity, only: [:show, :edit, :update, :destroy]

  # GET /opportunities
  # GET /opportunities.json
  def index
    @opportunities = Opportunity.order(:company).includes(:events)
  end

  # GET /opportunities/1
  # GET /opportunities/1.json
  def show
  end

  # GET /opportunities/new
  def new
    @opportunity = Opportunity.new
    @opportunity.recruiter_id = params[:recruiter] if params[:recruiter]
    @opportunity.phone_interview = nil unless @opportunity.phone_interview_scheduled?
    @opportunity.on_site_interview = nil unless @opportunity.on_site_interview_scheduled?
  end

  # GET /opportunities/1/edit
  def edit
  end

  # POST /opportunities
  # POST /opportunities.json
  def create
    @opportunity = Opportunity.new(opportunity_params)
    @opportunity.recruiter_id = params[:opportunity][:recruiter]
    @opportunity.state_id = params[:opportunity][:state]

    @opportunity.phone_interview = nil unless @opportunity.phone_interview_scheduled?
    @opportunity.on_site_interview = nil unless @opportunity.on_site_interview_scheduled?

    respond_to do |format|
      if @opportunity.save
        format.html { redirect_to @opportunity, notice: 'Opportunity was successfully created.' }
        format.json { render action: 'show', status: :created, location: @opportunity }
      else
        format.html { render action: 'new' }
        format.json { render json: @opportunity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opportunities/1
  # PATCH/PUT /opportunities/1.json
  def update
    respond_to do |format|
      @opportunity.state_id = params[:opportunity][:state]
      @opportunity.recruiter_id = params[:opportunity][:recruiter]
      if @opportunity.update(opportunity_params)
        format.html { redirect_to @opportunity, notice: 'Opportunity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @opportunity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opportunities/1
  # DELETE /opportunities/1.json
  def destroy
    @opportunity.destroy
    respond_to do |format|
      format.html { redirect_to opportunities_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opportunity
      @opportunity = Opportunity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opportunity_params
      params.require(:opportunity).permit(:company, :position, :phone_interview, :on_site_interview, :phone_interview_scheduled, :on_site_interview_scheduled, :recruiter_id, :state_id)
    end
end
