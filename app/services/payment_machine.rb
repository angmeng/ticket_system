class PaymentMachine
    def self.bypass(order, manager_id)
      	order.bypass_credit = true
	    order.bypass_credit_manager_id = manager_id.to_s
	    return order
    end

	def self.make_payment(order)
	  	@order = order
		seller = @order.seller
		seller.credit -= @order.total_amount
		if seller.save
		  if @order.buyer_is_agent?
		  	buyer = @order.agent
		  	buyer.credit -= @order.total_amount
		    buyer.save!
		  end
		end

		if order.payment_type_is_credit? && order.buyer_is_warrant?
			wp = WarrantPurchase.new(:warrant_id => order.warrant.id, :order_id => order.id)
			wp.save!
		end
	end

end