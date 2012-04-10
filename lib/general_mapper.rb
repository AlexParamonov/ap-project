class GeneralMapper
  class<<self
    attr_writer :persistence, :model

    def persistence(cls)
      @persistence = cls
    end

    def model(cls)
      @model = cls
    end

    def find(id)
      @model.new.tap do |model|
        model.persistence = @persistence.find(id)
        model.load_attributes_from_persistence
      end
    end
  end
end
