class LayoutCell < Cell::Rails

  # @param [Hash] options
  # @option options :flash
  def flash_message(options)
    flash = options[:flash]
    @flash_message = {}
    flash.each do |name, msg|
      @flash_message[name] =
        case msg
          when String
            msg
          when Array
            msg.join('<br />')
          else
            nil
        end
    end
    render
  end

  def header(options = {})
    @header

    render
  end

end
