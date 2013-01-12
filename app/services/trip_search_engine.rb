class TripSearchEngine
  
  def self.search(order)
  	@result = {}
  	@result[:order] = order
    # @total_ticket = order["adult"].to_i + order["kid"].to_i
  	search_jetty
    search_trip
    @result
  end

  def self.search_jetty
    @departure_jetty = Jetty.find @result[:order]["departure_jetty_id"]
    @arrival_jetty   = Jetty.find @result[:order]["arrival_jetty_id"]
    @result[:departure_title] = "#{@departure_jetty.name} to #{@arrival_jetty.name}"
    @result[:return_title] = "#{@arrival_jetty.name} to #{@departure_jetty.name}"
  end

  def self.search_trip
    departure_routine = Routine.where("departure_jetty_id = ?", @result[:order]["departure_jetty_id"]).first
    if departure_routine
      # @result[:departures] = Departure.where("routine_id = ? and date = ? and available_counter_sales >= ?", departure_routine.id, @result[:order]["depart_date"].to_date, @total_ticket.to_i).order(:time)
      @result[:departures] = Departure.where("routine_id = ? and date = ?", departure_routine.id, @result[:order]["depart_date"].to_date).order(:time)
      @result[:departure_ticket] = Ticket.where("routine_id = ?", departure_routine.id).order(:ticket_category_id)
    else
      @result[:departures] = nil
      @result[:departure_ticket] = nil
    end
    if @result[:order]["trip_type"] == "round"
      arrival_routine = Routine.where("departure_jetty_id = ?", @result[:order]["arrival_jetty_id"]).first
      if arrival_routine
        # @result[:arrivals] = Departure.where("routine_id = ? and date = ? and available_counter_sales >= ?", arrival_routine.id, @result[:order]["return_date"].to_date, @total_ticket.to_i).order(:time)
        @result[:arrivals] = Departure.where("routine_id = ? and date = ?", arrival_routine.id, @result[:order]["return_date"].to_date).order(:time)
        @result[:arrival_ticket] = Ticket.where("routine_id = ?", arrival_routine.id).order(:ticket_category_id)
      else
        @result[:arrivals] = nil
        @result[:arrival_ticket] = nil
      end
    end
  end

end