class OrderStatus

  PENDING   = 0
  VERIFIED  = 1
  VOIDED    = 2

	OPTIONS = [
	  ["PENDING", PENDING],
	  ["VERIFIED", VERIFIED],
	  ["VOIDED", VOIDED]
	].freeze

end

