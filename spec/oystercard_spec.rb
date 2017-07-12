require 'oystercard'

describe Oystercard do
  describe '#balance' do
    it 'shows balance of 0 for newly initiated card' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#change_balance' do
    before(:each) { subject.top_up(Oystercard::MAX_BALANCE) }
    it 'tops up the balance when requested' do
      expect(subject.balance).to eq Oystercard::MAX_BALANCE
    end

    it 'sets maximum limit of £90' do
      expect { subject.top_up 1 }.to raise_error "You tried to increase your balance by #{Oystercard::MAX_BALANCE + 1}. This is impossible! The maximum limit is £#{Oystercard::MAX_BALANCE}!"
    end

  end

  describe '#journey' do
    it 'starts with in_journey false value upon initialization' do
      expect(subject.in_journey).to eq false
    end

    it 'doesnt allow touch_in unless the card has a minimum balance' do
      expect {subject.touch_in}.to raise_error "Insufficient funds!"
    end

    it 'changes in_journey to true with touch_in' do
      subject.top_up(Oystercard::MAX_BALANCE)
      expect { subject.touch_in }.to change { subject.in_journey }.to true
    end

    it 'changes in_journey to false with touch_out' do
      subject.top_up(Oystercard::MAX_BALANCE)
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey).to eq false
    end

    it "deducts the minimum fare on touch_out" do
      subject.top_up(10)
      subject.touch_in
      expect{ subject.touch_out }.to change{ subject.balance }.by (-Oystercard::MIN_FARE)
    end
  end
end
