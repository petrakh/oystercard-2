require 'journeylog'

describe JourneyLog do

  subject(:journeylog) {JourneyLog.new("class")}

  it 'has journey_class parameter on initialization' do
    expect(subject.journey_class).not_to be_nil
  end
end
