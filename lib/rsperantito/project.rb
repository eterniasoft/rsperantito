module RSperantito

  class Project < Base

    def self.find(id)
      super(id, 'project')
    end

    def self.list(page=1, **options)
      super(page, 'project', options)
    end

    def self.search(query, page=1)
      super(query, 'project', page)
    end
  end
end
