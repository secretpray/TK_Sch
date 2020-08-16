class Train

  attr_reader   :number, 
                :index
  
  attr_accessor :route,
                :routes, 
                :speed,
                :wagons,
                :current_route,  
                :current_station


  def initialize(number, wagons) 
    @number           = number
    @wagons           = wagons
    @speed            = 0
    @current_route    = []
    @current_station  = []
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

  def set_route(route)
    # return unless @current_route?
    # @index = 0
    @current_route = route
    @current_station = route.routes[0]
    @current_station.add_train(self)
    puts "Поезд находится на станции #{current_station.name_station} и проследует по марщруту: #{route.routes.first.name_station} - #{route.routes.last.name_station}" # " #{self.route.first} - #{self.route.last}"
  end

  def current_station
    return unless current_route?    # return unless route
    puts @current_station           # route.stations[index]
  end

  def next_station
    return if current_route? || last?
    # current_route.routes[index + 1] 
    count = @current_route.routes.index(@current_station) + 1
    @current_station.emove_train_from_list(self)
    @current_station = @current_route.routes[count]
    @current_station.add_train_to_list(self)
  end

  def previous_station 
    return if current_route? || first?
    # current_route.routes[index - 1]
    count = @current_route.routes.index(@current_station) - 1
    @current_station.remove_train_from_list(self)
    @current_station = @current_route.routes[count]
    @current_station.add_train_to_list(self) 
    puts "Поезд приехал на станцию #{current_station.name_station}" 
  end

  protected

  # Чтобы запретить вмешиваться в проверки   
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
    raise 'Неверный маршрут!' if @current_route.class != Route && @current_route.routes.size < 2
  end

  def current_route?
    @current_route.nil?
  end

  def last?
    @current_station == @current_route.routes.last
    # @current_route.routes.last
  end

  def first?
    @current_station == @current_route.routes.first
    # @current_route.routes.first
  end
end