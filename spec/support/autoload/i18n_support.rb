module I18nSupport
  def iclick(*args)
    click *inject_i18n(args)
  end

  def isee(*args)
    see *inject_i18n(args)
  end

  def inject_i18n(args)
    args.map do |arg|
      I18n.t arg
    end
  end
end
