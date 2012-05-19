class GeneralMapper
  class<<self
    attr_accessor :persistence, :model
    attr_writer :model_methods

    def model_methods
      Array(@model_methods)
    end

    def new_model(item)
      model.new.load_attributes_from item
    end

    def method_missing(meth, *args, &blk)
      result = @persistence.send meth, *args, &blk

      return new_model(result) if model_methods.include? meth
      new(result)
    end
  end

  def initialize(obj)
    @obj = obj
  end

  def method_missing(meth, *args)
    self.class.new(@obj.send meth, *args)
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
