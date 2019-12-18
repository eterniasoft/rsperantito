describe RSperantito::CaptationWay do

  describe 'CaptationWay::list' do
    it "should get captation_ways" do
      captation_ways = VCR.use_cassette('captation_ways:list') do
        RSperantito::CaptationWay.list
      end

      expect(captation_ways.size).to eq(16)
    end
  end
end
