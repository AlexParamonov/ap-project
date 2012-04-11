class GeneralMapper
  class<<self
    attr_accessor :persistence, :model

    def find(id)
      @model.new.tap do |model|
        model.persistence = @persistence.find(id)
        model.load_attributes_from_persistence
      end
    end

    def method_missing(meth, *args, &blk)
      new(@persistence.send meth, *args, &blk)
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
      on_eval(item)
    end
  end

  def on_eval(item)
    self.class.model.new.load_attributes_from item
  end
end
