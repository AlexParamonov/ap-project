require "active_support"

module PersistenceMapper
  extend ActiveSupport::Concern

  def persisted?
    return false unless @persistence
    @persistence.persisted?
  end

  module ClassMethods
    def load_from persistence, *args
      new.tap do |obj|
        obj.load_attributes_from persistence.find(*args)
      end
    end
  end

  def persistence
    @persistence ||= instance_eval('Mapper.persistence.new')
  end

  attr_writer :persistence

  def load_attributes_from persistence
    attributes.each_pair do |attr, _|
      self.public_send "#{attr}=", persistence.public_send(attr)
    end
    self
  end

  def load_attributes_from_persistence
    load_attributes_from persistence
  end

  def load_attributes_to_persistence
    attributes.each_pair do |attr, _|
      persistence.public_send "#{attr}=", self.public_send(attr)
    end

    persistence.save!
  end
end
