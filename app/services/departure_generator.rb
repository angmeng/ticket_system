class DepartureGenerator
  def self.process(routine_id, options = {})
  	@routine    = Routine.find_by_id routine_id
  	@from_date  = options[:from_date]
  	@to_date    = options[:to_date]
  	@result     = {}
  	if validates
  	  generate
  	else
  	  return @result
  	end
  end

  def self.generate
  	#Todo
  	
  	@result[:status] = :success;@result[:message] = "Generated successfully"
  	@result
  end

  def self.validates
  	validate_routine
  	validate_date
  	@result[:status] == :error ? false : true
  end

  def self.validate_routine
  	unless @routine
  	  @result[:status] = :error;@result[:message] = "Must select a route" 
  	end
  end

  def self.validate_date
  	if @from_date.blank? || @to_date.blank?
  	  @result[:status] = :error;@result[:message] = "Must select date from and date to"
  	  return
    end
    unless @from_date.to_date <= @to_date.to_date
      @result[:status] = :error;@result[:message] = "Must select a valid range of date"
    end
  end

  
end