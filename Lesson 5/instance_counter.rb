=begin
Создать модуль InstanceCounter, содержащий следующие методы класса и инстанс-методы, которые подключаются автоматически при вызове include в классе:
Методы класса:
       - instances, который возвращает кол-во экземпляров данного класса
Инастанс-методы:
       - register_instance, который увеличивает счетчик кол-ва экземпляров класса и который можно вызвать из конструктора. 
       При этом данный метод не должен быть публичным.
Подключить этот модуль в классы поезда, маршрута и станции.
Примечание: инстансы подклассов могут считаться по отдельности, не увеличивая счетчик инстансев базового класса. 
=end

=begin 
module InstanceCounter

  def self.included(base)
    base.extended ClassMethod
    base.send :include, InstanceMethod 
  end
  
  module ClassMethod

    attr_accessor :class_count,
                  :instance_count

    @@class_count = 0

    def initialize
      @@class_count += 1
      self.class.register_instance
    end

    def self.instances
      @@class_count
    end
  end

  module InstanceMethod

    @instance_count = 0
   
    protected

    def register_instance
      @self.class.instance_count += 1
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
    def instances
      self.class_variable_get("@@instance_count")
    end
  end

  module InstanceMethods
    @@instance_count = 0

    protected

    def register_instance
      @@instance_count += 1
    end
  end  
end