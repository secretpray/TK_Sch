=begin
Создать модуль InstanceCounter, содержащий следующие методы класса и инстанс-методы, которые подключаются автоматически при вызове include в классе:
Методы класса:
       - instances, который возвращает кол-во экземпляров данного класса
Инастанс-методы:
       - register_instance, который увеличивает счетчик кол-ва экземпляров класса и который можно вызвать из конструктора. 
       При этом данный метод не должен быть публичным.
Подключить этот модуль в классы поезда, маршрута и станции.
Примечание: инстансы подклассов могут считаться по отдельности, не увеличивая счетчик инстансев базового класса. 


module InstanceCounter
  def self.included(mod)
    mod.extend ClassMethods
    mod.send :include, InstanceMethods
  end

  module ClassMethods
    
    #@@instance_count = 0

    def instances
      #@@instance_count
      self.class_variable_get("@@instance_count")
    end
  end

  module InstanceMethods
    
    protected
    def register_instance
      @@instance_count ||= 0
      @@instance_count  += 1
    end
  end  
end

module InstanceCounter
  
  def self.included(mod)
    mod.extend ClassMethods
    mod.send :include, InstanceMethods
  end

  module ClassMethods
    
    attr_reader :instances

    def increase_instances
      @@instances ||= 0
      @@instances += 1
    end
  end

  module InstanceMethods
    
    protected

    def register_instance
      self.class.increase_instances
    end
  end
end
=end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

  attr_reader :instances

    @instances = 0 
    
    def counter_up
      @instances ||= 0
      @instances +=1
    end
  end

  module InstanceMethods
    
    private
    def register_instance
      self.class.send :counter_up
    end

  end
end