class DeparturesController < ApplicationController
  # GET /departures
  # GET /departures.json
  def index
    @search = Departure.search(params[:search])
    @departures = @search.includes(:routine, :vessel).order("departures.date, departures.time, routines.code")
    @departures = @departures.page(params[:page]).per(25)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @departures }
    end
  end

  # GET /departures/1
  # GET /departures/1.json
  def show
    @departure = Departure.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @departure }
    end
  end

  # GET /departures/new
  # GET /departures/new.json
  def new
    @departure = Departure.new
    @routines = Routine.order(:code)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @departure }
    end
  end

  # GET /departures/1/edit
  def edit
    @departure = Departure.find(params[:id])
    @routines = Routine.order(:code)
  end

  # POST /departures
  # POST /departures.json
  def create
    @departure = Departure.new(params[:departure])

    respond_to do |format|
      if @departure.save
        format.html { redirect_to @departure, notice: 'Departure was successfully created.' }
        format.json { render json: @departure, status: :created, location: @departure }
      else
        format.html { render action: "new" }
        format.json { render json: @departure.errors, status: :unprocessable_entity }
      end
    end
  end

  def generate
    result = DepartureGenerator.process(params[:routine_id], :from_date => params[:from_date], :to_date => params[:to_date])
    if result[:status] == :success
      flash[:notice] = result[:message]
      redirect_to departures_url
    else
      flash[:error]   = result[:message]
      redirect_to :back
    end
  end

  # PUT /departures/1
  # PUT /departures/1.json
  def update
    @departure = Departure.find(params[:id])
    respond_to do |format|
      if @departure.update_attributes(params[:departure])
        format.html { redirect_to @departure, notice: 'Departure was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @departure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departures/1
  # DELETE /departures/1.json
  def destroy
    @departure = Departure.find(params[:id])
    @departure.destroy

    respond_to do |format|
      format.html { redirect_to departures_url }
      format.json { head :no_content }
    end
  end
end
