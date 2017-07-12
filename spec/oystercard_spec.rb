require 'oystercard'
require 'journey'

describe Oystercard do
  let(:station) {double :station}
  let(:journey) {double :journey}

  describe '#initialize' do
    it 'shows balance of 0 for newly initiated card' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    before(:each) { subject.top_up(Oystercard::MAX_BALANCE) }

    it 'tops up the balance when requested' do
      expect(subject.balance).to eq Oystercard::MAX_BALANCE
    end

    it 'sets maximum limit of £90' do
      expect { subject.top_up Journey::MIN_FARE }.to raise_error "Could not exceed maximum balance of £#{Oystercard::MAX_BALANCE}."
    end
  end

  describe '#touch_in' do
    before(:each) do
      subject.top_up(Oystercard::MAX_BALANCE)
      subject.touch_in(station)
    #  allow(subject).to receive(:current_journey) { double(:journey) }
      allow(journey).to receive_messages(:fare => Journey::PENALTY, :complete? => false)
    end

    it 'changes in_journey to true with touch_in' do
      expect(subject).to be_in_journey
    end

    it 'doesnt allow touch_in unless the card has a minimum balance' do
      allow(subject).to receive(:balance) {0}
      expect {subject.touch_in(station)}.to raise_error "Insufficient funds!"
    end

    it 'charges a penalty fare if there is an incomplete journey' do
      expect {subject.touch_in(station)}.to change{subject.balance}.by(-Journey::PENALTY)
    end
  end

  describe '#touch_out' do
    before(:each) do
      subject.top_up(Oystercard::MAX_BALANCE)
    end

    it 'changes in_journey to false with touch_out' do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end

    it "deducts the minimum fare on touch_out" do
      allow(journey).to receive_messages(:end_journey => station, :fare => Journey::MIN_FARE)
      subject.touch_in(station)
      expect{ subject.touch_out(station) }.to change{ subject.balance }.by (-Journey::MIN_FARE)
    end

    it 'deduct a penalty if there was no touch in' do
      allow(journey).to receive_messages(:end_journey => station, :fare => Journey::PENALTY, :complete? => true)
      expect{ subject.touch_out(station) }.to change{subject.balance}.by(-Journey::PENALTY)
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
