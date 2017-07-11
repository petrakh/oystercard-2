class Oystercard
  MAX_BALANCE = 90
  attr_reader :balance
  attr_accessor :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "You tried to increase your balance by #{Oystercard::MAX_BALANCE + 1}. This is impossible! The maximum limit is £#{Oystercard::MAX_BALANCE}!" if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
end
