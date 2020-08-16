class Train

  attr_reader   :number, 
                :index
  
  attr_accessor :route, 
                :speed,
                :wagons,  
                :current_station


  def initialize(number, wagons) 
    @number   =  number
    @speed    =  0
    @wagons = wagons
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

  def attache_wagon(type_wagon)
    return unless valid_wagon!(type_wagon)
    if type_wagon == :cargo 
      @wagons << CargoWagon.new 
    else 
      wagons << PassengerWagon.new
    end
    # @wagons += 1 if stop? # for integer count
    puts "Прицеплен #{type_wagon} вагон. В составе сейчас #{@wagons.size} вагонов."
  end

  def remove_wagon
    @wagons.pop if stop? && @wagons.size != 0
    # @wagons -= 1 if stop? && @wagons != 0  # for integer count
    puts "Отцеплен вагон. В составе осталось #{@wagons.size} вагонов."
  end

  def take_route(route)
    return unless @route.nil?
    @route = route
    @index = 0
    current_station.add_train_to_list(self)
    puts "Поезд находится на станции #{current_station.name_station} и проследует по марщруту: #{route.stations.first.name_station} - #{route.stations.last.name_station}" # " #{self.route.first} - #{self.route.last}"
  end

  def current_station
    return unless route
    route.stations[@index]
  end

  def next_station
    return if route? || last?
    route.stations[index + 1]
  end

  def previous_station
    return if route? || first?
    route.stations[index - 1] 
  end

  def go_forward
    return if last?
    current_station.remove_train_from_list(self)
    @index += 1
    # next_station.add_train_to_list(self)
    puts "Поезд приехал на станцию #{current_station.name_station}"  # self.current_location
  end

  def go_backward
    return if first?
    current_station.add_train_to_list(self)
    @index -= 1
    # previous_station.remove_train_from_list(self)
    puts "Поезд приехал на станцию #{current_station.name_station}"  #self.station_location
  end

  protected
  
  def valid_wagon!(type_wagon)
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