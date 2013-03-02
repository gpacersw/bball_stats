class StatsPitchersController < ApplicationController
  # GET /stats_pitchers
  # GET /stats_pitchers.json
  def index
    @stats_pitchers = StatsPitcher.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stats_pitchers }
    end
  end

  # GET /stats_pitchers/1
  # GET /stats_pitchers/1.json
  def show
    @stats_pitcher = StatsPitcher.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stats_pitcher }
    end
  end

  # GET /stats_pitchers/new
  # GET /stats_pitchers/new.json
  def new
    @stats_pitcher = StatsPitcher.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stats_pitcher }
    end
  end

  # GET /stats_pitchers/1/edit
  def edit
    @stats_pitcher = StatsPitcher.find(params[:id])
  end

  # POST /stats_pitchers
  # POST /stats_pitchers.json
  def create
    @stats_pitcher = StatsPitcher.new(params[:stats_pitcher])

    respond_to do |format|
      if @stats_pitcher.save
        format.html { redirect_to @stats_pitcher, notice: 'Stats pitcher was successfully created.' }
        format.json { render json: @stats_pitcher, status: :created, location: @stats_pitcher }
      else
        format.html { render action: "new" }
        format.json { render json: @stats_pitcher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stats_pitchers/1
  # PUT /stats_pitchers/1.json
  def update
    @stats_pitcher = StatsPitcher.find(params[:id])

    respond_to do |format|
      if @stats_pitcher.update_attributes(params[:stats_pitcher])
        format.html { redirect_to @stats_pitcher, notice: 'Stats pitcher was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stats_pitcher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stats_pitchers/1
  # DELETE /stats_pitchers/1.json
  def destroy
    @stats_pitcher = StatsPitcher.find(params[:id])
    @stats_pitcher.destroy

    respond_to do |format|
      format.html { redirect_to stats_pitchers_url }
      format.json { head :no_content }
    end
  end
end
