class WarrantPurchasesController < ApplicationController
  # GET /warrant_purchases
  # GET /warrant_purchases.json
  def index
    @warrant_purchases = WarrantPurchase.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @warrant_purchases }
    end
  end

  # GET /warrant_purchases/1
  # GET /warrant_purchases/1.json
  def show
    @warrant_purchase = WarrantPurchase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @warrant_purchase }
    end
  end

  # GET /warrant_purchases/new
  # GET /warrant_purchases/new.json
  def new
    @warrant_purchase = WarrantPurchase.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @warrant_purchase }
    end
  end

  # GET /warrant_purchases/1/edit
  def edit
    @warrant_purchase = WarrantPurchase.find(params[:id])
  end

  # POST /warrant_purchases
  # POST /warrant_purchases.json
  def create
    @warrant_purchase = WarrantPurchase.new(params[:warrant_purchase])

    respond_to do |format|
      if @warrant_purchase.save
        format.html { redirect_to @warrant_purchase, notice: 'Warrant purchase was successfully created.' }
        format.json { render json: @warrant_purchase, status: :created, location: @warrant_purchase }
      else
        format.html { render action: "new" }
        format.json { render json: @warrant_purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /warrant_purchases/1
  # PUT /warrant_purchases/1.json
  def update
    @warrant_purchase = WarrantPurchase.find(params[:id])

    respond_to do |format|
      if @warrant_purchase.update_attributes(params[:warrant_purchase])
        format.html { redirect_to @warrant_purchase, notice: 'Warrant purchase was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @warrant_purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /warrant_purchases/1
  # DELETE /warrant_purchases/1.json
  def destroy
    @warrant_purchase = WarrantPurchase.find(params[:id])
    @warrant_purchase.destroy

    respond_to do |format|
      format.html { redirect_to warrant_purchases_url }
      format.json { head :no_content }
    end
  end
end
