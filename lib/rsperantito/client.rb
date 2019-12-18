module RSperantito
  class Client < Base

    def self.find(id)
      super(id, 'client')
    end

    def self.list(page=1, **options)
      super(page, 'client', options)
    end

    def self.search(q, page=1)
      super(q, 'client', page)
    end

    def self.create(**params)
      url = 'clients'

      response = RSperantito.post(url, params)
      response['client']
    end
  end
end
