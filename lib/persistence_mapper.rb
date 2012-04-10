require "active_support"

module PersistenceMapper
  extend ActiveSupport::Concern

  module ClassMethods
    def load_from persistence, *args
      new.tap do |obj|
        obj.load_attributes_from persistence.find(*args)
      end
    end
  end

  def load_attributes_from persistence
    attributes.each_pair do |attr, _|
      self.public_send "#{attr}=", persistence.public_send(attr)
    end
  end

  def load_attributes_to persistence
    attributes.each_pair do |attr, _|
      persistence.public_send "#{attr}=", self.public_send(attr)
    end

    persistence.save!
  end
end
