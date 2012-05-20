class GeneralMapper
  class<<self
    attr_accessor :persistence, :model
    attr_writer :model_methods

    def model_methods
      @model_methods ||= []
    end

    def new_model(item)
      model.new.load_attributes_from item
    end

    def method_missing(method, *args, &blk)
      result = @persistence.send method, *args, &blk

      process_method_call(method, result)
    end

    def process_method_call(method, result)
      if model_methods.include? method
        new_model(result)
      else
        new(result)
      end
    end
  end

  def initialize(obj)
    @obj = obj
  end

  def method_missing(method, *args, &blk)
    result = @obj.send method, *args, &blk

    self.class.process_method_call(method, result)
  end

  def respond_to?(*args)
    super || @obj.respond_to?(*args)
  end

  def to_a(*args)
    @obj.to_a(*args).map do |item|
      self.class.new_model(item)
    end
  end
end
