# this will become our main class for the Oystrcard challenge
class Oystercard
  MAX_BALANCE = 90
  MIN_FARE = 1
  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station
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

  def touch_out
    @in_journey = false
    deduct(MIN_FARE)
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
