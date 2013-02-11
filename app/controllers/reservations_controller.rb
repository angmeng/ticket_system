class ReservationsController < ApplicationController
  def index
    if params[:time_eq] && !params[:time_eq].blank?
      @search = OrderItem.includes(:departure).where("departures.time = ?", params[:time_eq]).search(params[:search])
    else
      @search = OrderItem.search(params[:search])
    end
    @search.order_branch_id_equals  = current_branch.id #unless is_admin?
    @search.order_buyer_id_equals   = current_user.id if is_agent?
    @order_items = @search.order("order_items.departure_id DESC").select { |item| item.order.is_reservation? }
    @order_items = Kaminari.paginate_array(@order_items).page(params[:page]).per(25)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @order_items }
    end
  end

  def new
  	@jetties = Jetty.order(:name)
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.update_attributes!(params[:order])
    OrderingMachine.update_order_items_for_reservations(@order, system_company)
    PaymentMachine.bypass(@order, params[:show_manager_id]) if params[:show_manager_id].present?
    PaymentMachine.make_payment(@order)
    redirect_to preview_order_path(@order), :notice => "You have confirm the reservation."
  end

  def show
  	@order = Order.find(params[:id])
  	@net_total = 0
  end

  # def destroy
  #   @order = Order.find(params[:id])
  #   if @order.order_items.present?
  #     @order.order_items.each do |item|
  #       item.status_id = OrderStatus::VOIDED
  #       item.save!
  #       OrderingMachine.recover_departure_balance(item.routine)
  #     end
  #   end
  # end

  def printable
    @order = Order.find(params[:id])
    @net_total = 0
    render :layout => false
  end
end
