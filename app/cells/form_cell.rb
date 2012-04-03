class FormCell < Cell::Rails
  include ActionView::Helpers::TagHelper
  # @param [Hash] options
  # @option options  [ActiveModel] :resource optional
  # @option options  [String] :errors optional
  # @option options  [String] :name optional
  def errors(options)
    resource = options[:resource]
    errors   = options[:errors] || resource.errors.full_messages rescue []
    name     = options[:name] || (resource.respond_to?( :human_class ) ? resource.human_class : resource.class.model_name.human) rescue ""
    return unless errors.any?

    @messages = errors.map { |msg| content_tag(:li, msg) }.join.html_safe
    @sentence = I18n.t("errors.messages.not_saved",
                      :count => errors.count,
                      :resource => name).html_safe
    render
  end

  def collection_errors(options)
    resources = options[:resources]
    return if resources.empty?

    @errors = []
    resources.each do |resource|
      errors = resource.errors
      name   = (resource.respond_to?( :human_class ) ? resource.human_class : resource.class.model_name.human) rescue ""
      name << " '#{resource.to_s}'"

      @errors << {
        :messages => errors.full_messages.map { |msg| content_tag(:li, msg) }.join.html_safe,
        :sentence => I18n.t("errors.messages.not_saved",
                            :count    => errors.count,
                            :resource => name).html_safe,
      }
    end

    render
  end
end
