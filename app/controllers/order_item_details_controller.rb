class OrderItemDetailsController < ApplicationController
  # GET /order_item_details
  # GET /order_item_details.json
  def index
    @order_item_details = OrderItemDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @order_item_details }
    end
  end

  # GET /order_item_details/1
  # GET /order_item_details/1.json
  def show
    @order_item_detail = OrderItemDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order_item_detail }
    end
  end

  # GET /order_item_details/new
  # GET /order_item_details/new.json
  def new
    @order_item_detail = OrderItemDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order_item_detail }
    end
  end

  # GET /order_item_details/1/edit
  def edit
    @order_item_detail = OrderItemDetail.find(params[:id])
  end

  # POST /order_item_details
  # POST /order_item_details.json
  def create
    @order_item_detail = OrderItemDetail.new(params[:order_item_detail])

    respond_to do |format|
      if @order_item_detail.save
        format.html { redirect_to @order_item_detail, notice: 'Order item detail was successfully created.' }
        format.json { render json: @order_item_detail, status: :created, location: @order_item_detail }
      else
        format.html { render action: "new" }
        format.json { render json: @order_item_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /order_item_details/1
  # PUT /order_item_details/1.json
  def update
    @order_item_detail = OrderItemDetail.find(params[:id])

    respond_to do |format|
      if @order_item_detail.update_attributes(params[:order_item_detail])
        format.html { redirect_to @order_item_detail, notice: 'Order item detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order_item_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_item_details/1
  # DELETE /order_item_details/1.json
  def destroy
    @order_item_detail = OrderItemDetail.find(params[:id])
    @order_item_detail.destroy

    respond_to do |format|
      format.html { redirect_to order_item_details_url }
      format.json { head :no_content }
    end
  end
end
