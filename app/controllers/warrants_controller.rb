class WarrantsController < ApplicationController
  # GET /warrants
  # GET /warrants.json
  def index
    @search = Warrant.search(params[:search])
    @warrants = @search.page(params[:page]).per(25)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @warrants }
    end
  end

  # GET /warrants/1
  # GET /warrants/1.json
  def show
    @warrant = Warrant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @warrant }
    end
  end

  # GET /warrants/new
  # GET /warrants/new.json
  def new
    @warrant = Warrant.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @warrant }
    end
  end

  # GET /warrants/1/edit
  def edit
    @warrant = Warrant.find(params[:id])
  end

  # POST /warrants
  # POST /warrants.json
  def create
    @warrant = Warrant.new(params[:warrant])

    respond_to do |format|
      if @warrant.save
        format.html { redirect_to @warrant, notice: 'Warrant was successfully created.' }
        format.json { render json: @warrant, status: :created, location: @warrant }
      else
        format.html { render action: "new" }
        format.json { render json: @warrant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /warrants/1
  # PUT /warrants/1.json
  def update
    @warrant = Warrant.find(params[:id])

    respond_to do |format|
      if @warrant.update_attributes(params[:warrant])
        format.html { redirect_to @warrant, notice: 'Warrant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @warrant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /warrants/1
  # DELETE /warrants/1.json
  def destroy
    @warrant = Warrant.find(params[:id])
    @warrant.destroy

    respond_to do |format|
      format.html { redirect_to warrants_url }
      format.json { head :no_content }
    end
  end
end
