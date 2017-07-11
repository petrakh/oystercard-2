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
  end
end
