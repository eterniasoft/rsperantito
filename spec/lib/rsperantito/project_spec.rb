describe RSperantito::Project do

  describe 'Project::list' do
    it "should get projects" do
      projects = VCR.use_cassette('projects:list') do
        RSperantito::Project.list
      end

      expect(projects.size).to eq 5
      expect(projects.map{|e| e['name']}).to include('Villa Hermanda', 'Edificio Smart Life')
    end
  end

  describe 'Project::find' do
    it "should project" do
      project = VCR.use_cassette('projects:find:3') do
        RSperantito::Project.find(4)
      end

      expect(project['code']).to eq('VIHE')
    end
  end

  describe 'Project::search' do
    it "should project search by code" do
      project = VCR.use_cassette('projects:search:SMART') do
        RSperantito::Project.search('SMART')
      end

      expect(project['code']).to eq('SMART')
    end

    it "should project search by name" do
      project = VCR.use_cassette('projects:search:Villa_Hermanda') do
        RSperantito::Project.search('Villa Hermanda')
      end

      expect(project['name']).to eq('Villa Hermanda')
    end
  end
end
