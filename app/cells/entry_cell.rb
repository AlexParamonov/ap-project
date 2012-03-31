class EntryCell < Cell::Rails

  def index(options)
    @entries = options[:entries]

    render
  end

end
