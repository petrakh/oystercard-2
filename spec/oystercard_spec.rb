require 'oystercard'

describe Oystercard do
  let(:station) {double :station}

  describe '#initialize' do
    it 'shows balance of 0 for newly initiated card' do
      expect(subject.balance).to eq 0
    end

    it 'starts with in_journey false value upon initialization' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#top_up' do
    before(:each) { subject.top_up(Oystercard::MAX_BALANCE) }

    it 'tops up the balance when requested' do
      expect(subject.balance).to eq Oystercard::MAX_BALANCE
    end

    it 'sets maximum limit of £90' do
      expect { subject.top_up Oystercard::MIN_FARE }.to raise_error "You tried to increase your balance by #{Oystercard::MAX_BALANCE + Oystercard::MIN_FARE}. This is impossible! The maximum limit is £#{Oystercard::MAX_BALANCE}!"
    end
  end

  describe '#touch_in' do
    before(:each) {subject.top_up(Oystercard::MAX_BALANCE)}
    before(:each) {subject.touch_in(station)}

    it 'changes in_journey to true with touch_in' do
      expect(subject).to be_in_journey
    end

    it 'assigns entry station name on touch_in' do
      expect(subject.entry_station).not_to be_nil
    end

    it 'doesnt allow touch_in unless the card has a minimum balance' do
      allow(subject).to receive(:balance) {0}
      expect {subject.touch_in(station)}.to raise_error "Insufficient funds!"
    end
  end


  describe '#touch_out' do
    before(:each) { subject.top_up(Oystercard::MAX_BALANCE)}
    before(:each) { subject.touch_in(station)}

    it 'changes in_journey to false with touch_out' do
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end

    it "deducts the minimum fare on touch_out" do
      expect{ subject.touch_out(station) }.to change{ subject.balance }.by (-Oystercard::MIN_FARE)
    end

    it 'assigns exit station on touch_out' do
      subject.touch_out(station)
      expect(subject.exit_station).not_to be_nil
    end
  end

  describe '#journey_history' do
    before(:each) { subject.top_up(Oystercard::MAX_BALANCE)}

    it 'is empty by default' do
      expect(subject.journey_history).to be_empty
    end

    it 'should show one journey after one touch in and out' do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.journey_history.length).to eq 1
    end
  end
end
