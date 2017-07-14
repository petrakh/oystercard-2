# storing the array of journes
class JourneyLog

  attr_reader :journey_class

  def initialize(journey_class)
    @journey_class = journey_class
  end
end
