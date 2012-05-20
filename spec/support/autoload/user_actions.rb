module UserActions
  def self.visitor(user, context)
    context.module_eval do
      def method_missing(method_name, *args)
        super
      rescue NameError
        return user.send method_name, *args
      end
    end
  end
end
