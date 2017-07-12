# Going on an epic.....

class Journey
  MIN_FARE = 1
  PENALTY = 6
  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
  end

  def end_journey(exit_station)
    @exit_station = exit_station
  end

  def complete?
    !!exit_station || false
  end

  def fare
    complete? ?  MIN_FARE : PENALTY
  end
end
