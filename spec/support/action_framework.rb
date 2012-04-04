module ActionFramework
  attr_accessor :action_framework
  def method_missing(meth, *args, &blk)
    action_framework.send meth, *args, &blk
  end

  def respond_to?(*args)
    super || actions.respond_to?(*args)
  end
end
