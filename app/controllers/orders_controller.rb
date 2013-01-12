class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    #if is_admin?
      @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @jetties = Jetty.order(:name)
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  def reserve
    @jetties = Jetty.order(:name)
    @status_id = OrderStatus::PENDING
  end

  def search_departure
    @result = TripSearchEngine.search(params[:order])
    @agents = Agent.where("branch_id = ?", current_branch.id).order(:username)
    @warrants = Warrant.order(:name)
  end

  def payment
    @order = Order.find params[:id]
    @net_total = 0.00
    #redirect_to preview_order_path(@order) if  @order.is_voided?
  end

  def make_payment
    @order = Order.find params[:id]
    if @order.update_attributes(params[:order])
      PaymentMachine.make_payment(@order)
      flash[:notice] = "Payment completed"
      redirect_to preview_order_path(@order)
    else
      flash[:notice] = "Failed to save"
      redirect_to payment_order_path(@order)
    end
  end

  def preview
    @order = Order.find params[:id]
  end

  def preview_printable
    @order = Order.find params[:id]
    @count = 0
    render :layout => false
  end

  def void
    @order = Order.find params[:id]
    flash[:notice] = "Voided successfully"
    redirect_to :back
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    order = OrderingMachine.new(params[:order], system_company).process
    flash[:notice] = "Order created"
    redirect_to payment_order_path(order)
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
end
