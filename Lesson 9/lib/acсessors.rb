module Acсessors
	def attr_accessor_with_history(*names)
		names.each do |name|
		  var_name = "@#{name}".to_sym
			history_var_name = "#{var_name}_history".to_sym

			define_method(name) { instance_variable_get(var_name) }

			define_method("#{name}_histoty".to_sym) do
				instance_variable_get(history_var_name)
			end

			define_method("#{name}=".to_sym) do |value|
				vals = instance_variable_get(history_var_name) ||
					[instance_variable_get(var_name)]
				vals.push value

				instance_variable_set(history_var_name, vals)
				instance_variable_set(var_name, value)
			end
		end
  end

  def strong_attraccessor(attr_name, class_name)
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
