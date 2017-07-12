require_relative 'journey'

# this will become our main class for the Oystrcard challenge
class Oystercard
  MAX_BALANCE = 90
  attr_reader :balance, :current_journey, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    raise "Could not exceed maximum balance of £#{MAX_BALANCE}." if (balance + amount > MAX_BALANCE)
    @balance += amount
  end

  def touch_in(station_name)
    raise "Insufficient funds!" if balance < Journey::MIN_FARE
    no_touch_out
    @current_journey = Journey.new(station_name)
  end

  def touch_out(station_name)
    no_touch_in
    end_current_journey(station_name)
  end

  def in_journey?
    !current_journey.complete?
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def no_touch_in
    @current_journey = Journey.new if current_journey.complete?
  end

  def no_touch_out
    deduct(current_journey.fare) unless current_journey.nil? || current_journey.complete?
  end

  def end_current_journey(station_name)
    current_journey.end_journey(station_name)
    deduct(current_journey.fare)
    journey_history << current_journey
  end

end
