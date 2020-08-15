class Train

  attr_reader   :number, 
                :index
  
  attr_accessor :route, 
                :speed, 
                :carriage, 
                :current_location

  
# создаем поезд, который должен иметь свойста: номер, тип обьект вагоны (массив), скорость, количество вагонов, маршрут, нынешнюю станцию, индекс,
# а также методы ускорения, замедления, остановки, прицепки и отцепки вагонов, получения маршрута и следования по маршруту.  

  def initialize(number, carriage = 0) 
    @number   =  number
    @carriage =  carriage.to_i
    @speed    =  0
  end

  def accelerate(value = 10)
    self.speed += value
    puts "Скорость увеличена на #{value} км/ч"
  end

  def decrease_speed(value = 10)
    return if self.speed - value < 0  
    self.speed -= value # unless stop?
    puts "Скорость снижена на #{value} км/ч"
  end

  def stop
    self.speed = 0
    puts "Скорость позда снижена до #{speed} км/ч. Поезд остановился"
  end

  def attache_carriage(type_wagon)
    return unless valid_carriage!(type_wagon)
    @carriage += 1 if stop?
    puts "Прицеплен #{type} вагон. В составе сейчас #{carriage} вагонов."
  end

  def remove_carriage
    @carriage -= 1 if stop? && carriage != 0
    puts "Отцеплен #{type} вагон. В составе осталось #{carriage} вагонов."
  end

  def take_route(route)
    return unless @route.nil?
    @route = route
    @index = 0
    current_location.add_train_to_list(self)
    puts "Поезд находится на станции #{current_location.name_station} и проследует по марщруту: #{route.stations.first.name_station} - #{route.stations.last.name_station}" # " #{self.route.first} - #{self.route.last}"
  end

  def current_location
    return unless route
    route.stations[@index]
  end

  def next_location
    return if route? || last?
    route.stations[index + 1]
  end

  def previous_location
    return if route? || first?
    route.stations[index - 1] 
  end

  def go_forward
    return if last?
    current_location.remove_train_from_list(self)
    @index += 1
    # next_location.add_train_to_list(self)
    puts "Поезд приехал на станцию #{current_location.name_station}"  # self.current_location
  end

  def go_backward
    return if first?
    current_location.add_train_to_list(self)
    @index -= 1
    # previous_location.remove_train_from_list(self)
    puts "Поезд приехал на станцию #{current_location.name_station}"  #self.current_location
  end

  protected
  
  def valid_carriage!(type_wagon)
    # raise 'Тип вагона не совпадает с типом поезда! Вагон не прицеплен.' if self.type != type_wagon.to_sym
    if self.type != type_wagon.to_sym
      puts 'Тип вагона не совпадает с типом поезда' if self.type != type_wagon.to_sym
      false
    else
      true
    end
  end

  def stop? 
    self.speed.zero?
  end

  def valid_route(route)
    raise 'Неверный маршрут!' if route.class != Route && route.stations.size < 2
  end

  def route?
    route.nil?
  end

  def last?
    route.stations.last
  end

  def first?
    route.stations.first
  end
end