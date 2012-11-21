class TopupCredit < ActiveRecord::Base
  attr_accessible :agent_id, :amount, :remark, :staff_id

  belongs_to :agent
  belongs_to :staff

  validates :agent, :staff, :presence => true
  validates :amount,:numericality => {:greater_than => 0.00}

  after_create :topup_agent_credit


  private

    def topup_agent_credit
      after_topup = self.agent.credit + self.amount
      self.agent.update_attributes(:credit => after_topup)
    end
end
