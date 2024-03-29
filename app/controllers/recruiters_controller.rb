class RecruitersController < ApplicationController
  before_action :set_recruiter, only: [:show, :edit, :update, :destroy]
  
  # GET /recruiters
  # GET /recruiters.json
  def index
    @recruiters = Recruiter.order(:company)
    respond_to do |format|
      format.html
      format.json do
        puts "Sending JSON"
        render json: @recruiters
      end
    end
  end

  # GET /recruiters/1
  # GET /recruiters/1.json
  def show
  end

  # GET /recruiters/new
  def new
    @recruiter = Recruiter.new
  end

  # GET /recruiters/1/edit
  def edit
  end

  # POST /recruiters
  # POST /recruiters.json
  def create
    @recruiter = Recruiter.new(recruiter_params)

    respond_to do |format|
      if @recruiter.save
        format.html { redirect_to @recruiter, notice: 'Recruiter was successfully created.' }
        format.json { render action: 'show', status: :created, location: @recruiter }
      else
        format.html { render action: 'new' }
        format.json { render json: @recruiter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recruiters/1
  # PATCH/PUT /recruiters/1.json
  def update
    respond_to do |format|
      if @recruiter.update(recruiter_params)
        format.html { redirect_to @recruiter, notice: 'Recruiter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @recruiter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recruiters/1
  # DELETE /recruiters/1.json
  def destroy
    @recruiter.destroy
    respond_to do |format|
      format.html { redirect_to recruiters_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recruiter
      @recruiter = Recruiter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recruiter_params
      params.require(:recruiter).permit(:company)
    end
end
