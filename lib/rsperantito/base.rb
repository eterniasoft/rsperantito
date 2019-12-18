module RSperantito
  class Base
    def self.find(id, type)
      url = "#{type}s/#{id}"
      response = RSperantito.get(url)
      response[type]
    end

    def self.list(page=1, type, **options)
      url = "#{type}s?page=#{page}"
      options.each do |option, value|
        url << "&#{option}=#{value}"
      end

      response = RSperantito.get(url)
      response["#{type}s"]
    end

    def self.search(query, type, page=1)
      url = "#{type}s?q=#{query}"

      response = RSperantito.get(url)
      response["#{type}s"][0]
    end
  end
end
