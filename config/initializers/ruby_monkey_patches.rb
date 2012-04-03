require "xpath"
module XPath
  module HTML
    def link(locator, options={})
      href = options[:href]
      link = descendant(:a)[href ? attr(:href).everyquals(href) : attr(:href)]
      link[attr(:id).equals(locator) | string.n.is(locator) | attr(:rel).equals(locator) | attr(:title).is(locator) | descendant(:img)[attr(:alt).is(locator)]]
    end
  end
end
