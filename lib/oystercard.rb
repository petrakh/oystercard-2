# this will become our main class for the Oystrcard challenge
class Oystercard
  MAX_BALANCE = 90
  MIN_FARE = 1
  attr_reader :balance, :entry_station, :exit_station, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    raise "You tried to increase your balance by #{MAX_BALANCE + 1}. This is impossible! The maximum limit is £#{MAX_BALANCE}!" if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station_name)
    raise "Insufficient funds!" if balance < MIN_FARE
    @in_journey = true
    @entry_station = station_name
  end

  def touch_out(station_name)
    @in_journey = false
    deduct(MIN_FARE)
    @exit_station = station_name
    save_journey
  end

  def in_journey?
    entry_station && !exit_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def save_journey
    @journey_history << {entry: entry_station, exit: exit_station}
  end
end
