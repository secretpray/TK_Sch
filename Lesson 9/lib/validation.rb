# frozen_string_literal: true
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(attribute, type, params = nil)
      @validations ||= {}
      @validations[attribute] ||= []
      @validations[attribute] << { type: type, params: params }
    end
  end

  module InstanceMethods
    def validations
      self.class.validations || {}
    end

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    protected

    def presence_validation(value, *)
      raise 'Значение должно быть определено' if (value.nil? || value == '')
    end

    def format_validation(value, format)
      raise 'Неверный формат значения' if value !~ format
    end

    def type_validation(value, type)
      raise 'Неверный тип значения' unless value.is_a?(type)
    end

    def validate!
      validations.each do |attribute, validation|
        value = instance_variable_get("@#{attribute}".to_sym)

        validation.each do |details|
          method_name = "#{details[:type]}_validation".to_sym

          raise 'Неверный тип валидации' unless InstanceMethods::method_defined?(method_name)

          send method_name, value, details[:params]
        end
      end
    end
  end
end
