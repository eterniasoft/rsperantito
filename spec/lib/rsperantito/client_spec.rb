describe RSperantito::Client do

  before do
    authenticate_client
  end

  describe 'Client::list' do
    it "should get clients" do
      clients = VCR.use_cassette('clients:list') do
        RSperantito::Client.list
      end

      expect(clients.size).to eq(20)
    end

    it "should get clients:list by captation_ways_id" do
      clients = VCR.use_cassette("clients:list:captation_way") do
        RSperantito::Client.list(1, captation_ways_id: 5)
      end

      expect(clients[0]['captation_way']).to eq('facebook')
    end
  end

  describe 'Client::find' do
    it 'should client 587' do
      client = VCR.use_cassette('clients:find:587') do
        RSperantito::Client.find(587)
      end

      expect(client['full_name']).to eq('Carolina Gaitan')
      expect(client['document']).to eq('auto-272684')
    end
  end

  describe 'Client::search' do
    it "should client by document" do
      client = VCR.use_cassette('clients:search:document:auto-103328') do
        RSperantito::Client.search('auto-103328')
      end

      expect(client['document']).to eq('auto-103328')
    end
  end

  describe 'Client::create' do
    let(:project) do
      VCR.use_cassette('projects:find:3') do
        RSperantito::Project.find(4)
      end
    end

    let('info_basic') do
      {
        data: {
          fname: 'maxi',
          lname: 'sperant',
          email: 'maxi@sperant.com',
          project_related: project['id']
        }
      }
    end

    let('info_complete') do
      {
        data: {
          fname: 'maxi compra',
          lname: 'sperant',
          email: 'maxi_compra@sperant.com',
          project_related: project['id'],
          main_telephone: '987654321',
          country: 'PE',
          departament: 'PAS',
          document: '04023413',
          address:  'Av. los aolvidados'
        }
      }
    end

    it "should info basic" do
      client = VCR.use_cassette('client:create:info:basic') do
        RSperantito::Client.create(info_basic)
      end

      expect(client['email']).to eq('maxi@sperant.com')
      expect(client['projects_related'].map { |e| e['id'] }).to include(4)
      #values return default
      #error not return "Por Contactar"
      # expect(client['interest_type_name']).to eq('Por Contactar')
      expect(client['person_type_id']).to eq('natural')
      expect(client['document_type_name']).to eq('DNI')
      expect(client['input_channel_name']).to include('Contacto Web')
    end

    it "should info complete" do
      client = VCR.use_cassette('client:create:info:complete') do
        RSperantito::Client.create(info_complete)
      end

      expect(client['email']).to eq('maxi_compra@sperant.com')
      expect(client['projects_related'].map { |e| e['id'] }).to include(4)
      expect(client['main_telephone']).to include('987654321')
      expect(client['ubication']['country']).to include('Peru')
      #error not return value send return
      # expect(client['ubication']['departament']).to include('Pasco')
      expect(client['ubication']['address']).to include('Av. los aolvidados')
      expect(client['document']).to include('04023413')
      expect(client['phones']).to include('987654321')
    end
  end
end
