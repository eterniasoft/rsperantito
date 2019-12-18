# RSperantito

 rsperantito is a ruby gem for the [Sperant API](https://sperant.gitbooks.io/api-sperant/)

## Features

*  API Endpoint coverage `project` `client` `captation_way`
* OAuth and other authorization flows

## Installation

Add this line Gemfile:

    gem 'rsperantito'

execute:

    $ bundle

Or install:

    $ gem install rsperantito

## Usage

  RSperantito was designed to be used without thinking about what API calls should be made,
  require authentication to be accessed [here](https://sperant.gitbooks.io/api-sperant/oauth.html).

```ruby
require 'rsperantito'

RSperantito.authenticate("<client_id>", "<client_secret>")

clients = RSperantito::Client.list
clients.map { |client| client['name'] }
#=> ["Maxi Compra Sperant", "Maxi Sperant", "Raul Gambini", "Joceline  Arizabal Corimanya", "Gonzalo Chavez", "Mia Tatiana Chero Roman", "Jose Luis Rodriguez", "Jose Junnior  Roman Villavicencio", "Maria Miletich", "Edith Gambini", "Cinthia Roman Villavicencio", "Christian Hoyos Vigo", "Jorge  Collazos", "Yovanna Jackeline  Espichan Medina", "Luis Del Solar", "Carlos  Burneo", "Helen Meza Hernani40769514", "Gianmarco  Valencia ", "Manuel Eduardo Valderrama  Richard", "Carmen Rosa Ramirez Door"]

projects = RSperantito::Project.list
projects.map{|e| e['name']}
#=> ["Edificio Magnolias", "Edificio Smart Life", "Centro Comercial La Estación", "Villa Hermanda", "Arequipa 2"]
```
Search

```ruby
clients = RSperantito::Client.search('auto-103328')
clients[0]['full_name'] #=> Felix Diaz
clients[0]['document'] #=> auto-103328

projects = RSperantito::Project.search('VIHE')
projects[0]['name'] #=> Vivienda residencial
projects[0]['code'] #=> VIHE
```
Find by id:

```ruby
client =  RSperantito::Client.find(608)
# => {"id"=>610, "created_at"=>"2019-12-18T03:39:50Z", "full_name"=>"Maxi Sperant", "person_type_id"=>"natural", "gender"=>"m", "document_type_name"=>"DNI", "document"=>"auto-339106", "main_telephone"=>nil, "phones"=>[], "email"=>"maxi@sperant.com", "interest_type_name"=>nil, "captation_way"=>nil, "input_channel_name"=>"Contacto Web", "ubication"=>{"country"=>"Peru", "department"=>"Lima", "province"=>nil, "district"=>nil, "address"=>nil}, "couple"=>nil, "projects_related"=>[{"id"=>4, "code"=>"VIHE", "name"=>"Villa Hermanda", "link"=>"/v2/projects/4"}], "seller"=>[{"id"=>5, "full_name"=>"Desarrollo Desarrollo", "username"=>"desarrollo", "role_name"=>"administrador", "email"=>"heroku@eterniasoft.com", "phone"=>""}], "num_interactions"=>2, "last_interaction_date"=>"2019-12-18T03:39:50Z", "email_consent"=>true
project = RSperantito::Project.find(8)
project['name'] #=> "Edificio Smart Life"
project['project_type'] #=> "Vivienda residencial"
```


## Contributing

1. Fork it ( https://github.com/gersoneufra/rsperantito/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Test your changes (`bundle exec rspec`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request
