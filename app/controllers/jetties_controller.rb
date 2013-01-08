class JettiesController < ApplicationController
  # GET /jetties
  # GET /jetties.json
  def index
    @search = Jetty.search(params[:search])
    @jetties = @search.page(params[:page]).per(25)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jetties }
    end
  end

  # GET /jetties/1
  # GET /jetties/1.json
  def show
    @jetty = Jetty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @jetty }
    end
  end

  # GET /jetties/new
  # GET /jetties/new.json
  def new
    @jetty = Jetty.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @jetty }
    end
  end

  # GET /jetties/1/edit
  def edit
    @jetty = Jetty.find(params[:id])
  end

  # POST /jetties
  # POST /jetties.json
  def create
    @jetty = Jetty.new(params[:jetty])

    respond_to do |format|
      if @jetty.save
        format.html { redirect_to @jetty, notice: 'Jetty was successfully created.' }
        format.json { render json: @jetty, status: :created, location: @jetty }
      else
        format.html { render action: "new" }
        format.json { render json: @jetty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jetties/1
  # PUT /jetties/1.json
  def update
    @jetty = Jetty.find(params[:id])

    respond_to do |format|
      if @jetty.update_attributes(params[:jetty])
        format.html { redirect_to @jetty, notice: 'Jetty was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @jetty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jetties/1
  # DELETE /jetties/1.json
  def destroy
    @jetty = Jetty.find(params[:id])
    @jetty.destroy

    respond_to do |format|
      format.html { redirect_to jetties_url }
      format.json { head :no_content }
    end
  end
end
