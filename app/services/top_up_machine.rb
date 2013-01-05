class TopUpMachine

  def initialize(topup_credit)
  	@agent        = topup_credit.agent
  	@topup_credit = topup_credit
  end

  def top_up
    after_topup = @agent.credit + @topup_credit.amount
    @agent.update_attributes(:credit => after_topup)
  end


end