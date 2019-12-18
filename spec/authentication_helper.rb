module AuthenticationHelper
  TOKEN = '174647bb3907a85fbbaf189efacdcc533d6edc53b702593eaf10219678aa9eee'

  def authenticate_client
    client_id = '7be79214adc249df43be17a2baca54ec9d892b581e8a5edb0c021b5b53ceea7e'
    client_secret = '2d1182c427e852c5cd4cc1811233abdd08a661dd95283bbeab70c3af0da351e8'

    VCR.use_cassette('authenticate:client') do
      RSperantito.authenticate(client_id, client_secret)
    end
  end
end
