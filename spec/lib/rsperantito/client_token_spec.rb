describe RSperantito do
  describe '.client_token' do
    it "should return .client_token" do
      authenticate_client

      expect(RSperantito.client_token).to eq(AuthenticationHelper::TOKEN)
    end
  end
end
