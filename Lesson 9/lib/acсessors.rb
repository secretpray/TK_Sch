# frozen_string_literal: true

module Acсessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      # raise 'Аргумент не является символом' unless name.is_a?(Symbol)
      var_name = "@#{name}".to_sym
      history_var_name = "#{var_name}_history".to_sym
      
      # create getter for var_name
      define_method(name) { instance_variable_get(var_name) }
      
      # create getter for history_var_name
      define_method("#{name}_histoty".to_sym) { instance_variable_get(history_var_name) }
      
      # create setter history_var_name
      define_method("#{name}=") do |value|
        history = instance_variable_get(history_var_name)
        history ||= []
        history << value
        instance_variable_set(history_var_name, value)
        instance_variable_set(var_name, value)
      end
    end
  end

  def strong_attraccessor(attr_name, class_name)
    # raise 'Аргумент не является символом' unless attr_name.is_a?(Symbol)
    # raise 'Аргумент не является классом' unless class_name.is_a?(Class)
    var_name = "@#{attr_name}".to_sym
    
    define_method(attr_name) { instance_variable_get(var_name) }
    
    define_method("#{attr_name}=".to_sym) do |value|
      unless valie.is_a?(class_name)
        raise TypeError, "#{attr_name} должен быть экземпляром класса #{class_name}"
      end
      instance_variable_set(var_name, value)
    end
  end
end
