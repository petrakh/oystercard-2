require 'oystercard'

describe Oystercard do
  describe '#balance' do
    it 'shows balance of 0 for newly initiated card' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'tops up the balance when requested' do
      expect { subject.top_up 5 }.to change { subject.balance }.by 5
    end

    it 'sets maximum limit of £90' do
      expect { subject.top_up Oystercard::MAX_BALANCE + 1 }.to raise_error "You tried to increase your balance by #{Oystercard::MAX_BALANCE + 1}. This is impossible! The maximum limit is £#{Oystercard::MAX_BALANCE}!"
    end
  end

  describe '#deduct' do
    it 'deducts amount from card' do
      subject.top_up(20)
      expect { subject.deduct 5 }.to change { subject.balance }.by -5
    end
  end
end
