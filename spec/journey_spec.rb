require 'journey'

describe Journey do
  subject(:journey) {described_class.new("Victoria")}

  it 'should receive an entry station at initialization' do
    expect(journey.entry_station).to eq "Victoria"
  end

  describe '#end_journey' do
    it 'should assign a value to exit_station' do
      journey.end_journey("Covent Garden")
      expect(journey.exit_station).to eq "Covent Garden"
    end
  end

  describe '#fare' do
    it 'should charge the mininum fare if there is a valid journey' do
      journey.end_journey("Covent Garden")
      expect(journey.fare).to eq Journey::MIN_FARE
    end

    it 'should charge a penalty if there is no valid journey' do
      expect(journey.fare).to eq Journey::PENALTY
    end
  end

  describe '#complete?' do
    it 'should know if a journey is complete' do
      journey.end_journey("Covent Garden")
      expect(journey).to be_complete
    end
  end
end
