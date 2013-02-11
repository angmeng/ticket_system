class ReservationDetailsController < ApplicationController
  # GET /reservation_details
  # GET /reservation_details.json
  def index
    @reservation_details = ReservationDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reservation_details }
    end
  end

  # GET /reservation_details/1
  # GET /reservation_details/1.json
  def show
    @reservation_detail = ReservationDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reservation_detail }
    end
  end

  # GET /reservation_details/new
  # GET /reservation_details/new.json
  def new
    @reservation_detail = ReservationDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reservation_detail }
    end
  end

  # GET /reservation_details/1/edit
  def edit
    @reservation_detail = ReservationDetail.find(params[:id])
  end

  # POST /reservation_details
  # POST /reservation_details.json
  def create
    @reservation_detail = ReservationDetail.new(params[:reservation_detail])

    respond_to do |format|
      if @reservation_detail.save
        format.html { redirect_to @reservation_detail, notice: 'Reservation detail was successfully created.' }
        format.json { render json: @reservation_detail, status: :created, location: @reservation_detail }
      else
        format.html { render action: "new" }
        format.json { render json: @reservation_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reservation_details/1
  # PUT /reservation_details/1.json
  def update
    @reservation_detail = ReservationDetail.find(params[:id])

    respond_to do |format|
      if @reservation_detail.update_attributes(params[:reservation_detail])
        format.html { redirect_to @reservation_detail, notice: 'Reservation detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reservation_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservation_details/1
  # DELETE /reservation_details/1.json
  def destroy
    @reservation_detail = ReservationDetail.find(params[:id])
    @reservation_detail.destroy

    respond_to do |format|
      format.html { redirect_to reservation_details_url }
      format.json { head :no_content }
    end
  end
end
