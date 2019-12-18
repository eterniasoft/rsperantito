module RSperantito
  class CaptationWay < Base
    def self.list(page=1)
      super(page, 'captation_way')
    end
  end
end
