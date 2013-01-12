class PaymentMachine

	def self.make_payment(order)
	  @order = order
	  #if @order.is_pending?
		seller = @order.seller
		seller.credit -= @order.total_amount
		if seller.save
		  if @order.buyer_is_agent?
		  	buyer = @order.agent
		  	buyer.credit -= @order.total_amount
		    buyer.save!
		  end
		  @order.verified!
		end
	  #else

	  #end
	end

end