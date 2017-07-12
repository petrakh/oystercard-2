require 'station'

describe Station do
  subject(:station) { described_class.new("Victoria",1)}

  it 'has a name attribute on initialization' do
    expect(station.station_name).to eq "Victoria"
  end

  it 'has a zone attribute on initialization' do
    expect(station.zone).to eq 1
  end
end
