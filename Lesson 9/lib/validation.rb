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

    def presence_validation(value, _)
      raise ValidationError, 'имя не может быть пустым' if value.nil? || value == ''
    end

    def format_validation(value, format)
      raise ValidationError, 'неверный формат введенного значения' if value !~ format
    end

    def type_validation(value, type)
      raise ValidationError, 'неверный тип значения' unless value.is_a?(type)
    end

    def length_validation(value, length)
      raise ValidationError, "минимальная длина не меньше #{length} символа(ов)" unless length < value.size
    end

    def positive_validation(value, _)
      raise ValidationError, 'отрицательное значение не допустимо' unless value.positive?
    end

    def uniq_validation(value, _)
      raise ValidationError, 'первый и последний элементы идентичны' if value.first == value.last
      # raise ValidationError, 'первый и последний элементы идентичны' unless value[0] != value[-1]
    end

    def validate!
      validations.each do |attribute, validation|
        value = instance_variable_get("@#{attribute}".to_sym)

        validation.each do |details|
          method_name = "#{details[:type]}_validation".to_sym

          raise ValidationError, 'Неверный тип валидации' unless InstanceMethods.method_defined?(method_name)

          send method_name, value, details[:params]
        end
      end
    end
  end
end
