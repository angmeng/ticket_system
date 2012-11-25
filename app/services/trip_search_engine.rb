class TripSearchEngine
  
  def self.search(order)
  	@result = {}
  	@order = order
  	@result[:order] = order
  	@departure_jetty = Jetty.find order["departure_jetty_id"]
  	@arrival_jetty   = Jetty.find order["arrival_jetty_id"]
  	@result[:departure_title] = "#{@departure_jetty.name} to #{@arrival_jetty.name}"
  	@result[:return_title] = "#{@arrival_jetty.name} to #{@departure_jetty.name}"
    departure_routine = Routine.where("departure_jetty_id = ?", @order["departure_jetty_id"]).first
    @result[:departures] = Departure.where("routine_id = ? and date = ?", departure_routine.id, order["depart_date"].to_date).order(:time)
    @result[:departure_ticket] = Ticket.where("routine_id = ?", departure_routine.id).order(:ticket_category_id)
    if @order["trip_type"] == "round"
      arrival_routine = Routine.where("departure_jetty_id = ?", @order["arrival_jetty_id"]).first
      @result[:arrivals] = Departure.where("routine_id = ? and date = ?", arrival_routine.id, order["return_date"].to_date).order(:time)
      @result[:arrival_ticket] = Ticket.where("routine_id = ?", arrival_routine.id).order(:ticket_category_id)
    end
    @result
  end

end