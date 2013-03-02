class StatsPositionsController < ApplicationController
  # GET /stats_positions
  # GET /stats_positions.json
  def index
    @stats_positions = StatsPosition.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stats_positions }
    end
  end

  # GET /stats_positions/1
  # GET /stats_positions/1.json
  def show
    @stats_position = StatsPosition.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stats_position }
    end
  end

  # GET /stats_positions/new
  # GET /stats_positions/new.json
  def new
    @stats_position = StatsPosition.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stats_position }
    end
  end

  # GET /stats_positions/1/edit
  def edit
    @stats_position = StatsPosition.find(params[:id])
  end

  # POST /stats_positions
  # POST /stats_positions.json
  def create
    @stats_position = StatsPosition.new(params[:stats_position])

    respond_to do |format|
      if @stats_position.save
        format.html { redirect_to @stats_position, notice: 'Stats position was successfully created.' }
        format.json { render json: @stats_position, status: :created, location: @stats_position }
      else
        format.html { render action: "new" }
        format.json { render json: @stats_position.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stats_positions/1
  # PUT /stats_positions/1.json
  def update
    @stats_position = StatsPosition.find(params[:id])

    respond_to do |format|
      if @stats_position.update_attributes(params[:stats_position])
        format.html { redirect_to @stats_position, notice: 'Stats position was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stats_position.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stats_positions/1
  # DELETE /stats_positions/1.json
  def destroy
    @stats_position = StatsPosition.find(params[:id])
    @stats_position.destroy

    respond_to do |format|
      format.html { redirect_to stats_positions_url }
      format.json { head :no_content }
    end
  end
end
