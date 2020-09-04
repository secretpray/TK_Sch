# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :validation_list

    def validate(attr_name, type, *args)
      @validation_list ||= []
      @validation_list << [attr_name, "validate_#{type}", args]
    end
  end

  module InstanceMethods
    def validate!
      @validation_errors ||= []
      
      self.class.validation_list.each do |validation|
        attr_name, method_name, args = validation
        attr = instance_variable_get("@#{attr_name}")

        if validation_errors = send(method_name, attr, *args)
          @validation_errors << "#{attr_name.capitalize} #{validation_errors}"
        end 
      end
      
      raise error_message if @validation_errors.any?
    end

    def valid?
      validate!
      @validation_errors.none?
    end

    protected

    def validate_presence(value, _)
      raise 'Значение должно присутствовать' if value.nil? || value == ''
    end

    def validate_format(value, pattern)
      raise 'Задан нверный формат значения' unless value =~ pattern # if value !~ format
    end

    def validate_type(value, class_name)
      raise 'Не соотвествующий тип значения' unless value.is_a?(class_name)
    end

    def error_message
      @validation_errors.join(' ')
    end
  end
end
