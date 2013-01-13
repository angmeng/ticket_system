class DepartureGenerator
  def self.process(routine_id, options = {})
  	@routine    = Routine.find_by_id routine_id
  	@from_date  = options[:from_date]
  	@to_date    = options[:to_date]
    #@vessel     = VesselGenerator.generate
  	@result     = {}
  	if validates
  	  generate
  	else
  	  return @result
  	end
  end

  def self.generate
  	#Todo
  	@routine.schedules.each do |schedule|
      @from_date.to_date.upto(@to_date.to_date).each do |date|
        add(schedule, date) if schedule.weekday == date.wday
      end
    end
  	@result[:status] = :success;@result[:message] = "Generated successfully"
  	@result
  end

  def self.add(schedule, option_date)
    depart = @routine.departures.new
    depart.sales_quota  = schedule.sales_quota
    depart.online_quota = schedule.online_quota
    depart.status_id    = DepartureStatusType::OPEN
    depart.extra_trip   = schedule.extra_trip
    if schedule.extra_trip?
      depart.date       = schedule.departure_date
    else
      depart.date       = option_date
    end
    depart.time         = schedule.departure_time
    #depart.vessel_id    = @vessel.id
    depart.save! unless @routine.departures.where("date = ? and time = ?", depart.date, depart.time).first
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
    rescue Exception => e
      @result[:status] = :error;@result[:message] = e.message
  end

  
end