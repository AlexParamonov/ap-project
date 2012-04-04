module Capybara
  module DSL
    def follow rel
      find("//a[@rel='#{rel}']").click
    end

    def press button
      find("//input[@data-rel='#{button}']").click
    end
  end
end

