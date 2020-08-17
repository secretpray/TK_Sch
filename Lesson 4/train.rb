class Train

  attr_reader   :number, 
                :speed,
                :route
  
  attr_accessor :wagons


  def initialize(number, wagons) 
    @number           = number
    @wagons           = wagons  # @wagons = []
    @speed            = 0
  end

  def to_s
    "поезд номер #{@number} (вагонов: #{@wagons.size})"
  end

  def speed_up(value = 20)
    @speed += value
    puts "Скорость увеличена на #{value} км/ч"
  end

  def speed_down(value = 20)
    return if @speed - value < 0  
    @speed -= value # unless stop?
    puts "Скорость снижена на #{value} км/ч"
  end

  def brake
    @speed = 0
    puts "Поезд остановился"
  end
  
  def attach_wagon(type_wagon)
    return unless valid_wagon!(type_wagon)
    if type_wagon == :cargo 
      @wagons << CargoWagon.new 
    else 
      @wagons << PassengerWagon.new
    end
    puts "Прицеплен #{type_wagon} вагон. В составе сейчас #{@wagons.size} вагонов."
  end

  def detach_wagon
    @wagons.pop if stop? && @wagons.size != 0
    puts "Отцеплен вагон. В составе осталось #{@wagons.size} вагонов."
  end

  def assign_a_route(route)
    current_station.depart(self) if @route
    @route = route
    @current_location_index = 0
    current_station.handle(self)
    # puts "Поезд находится на станции #{current_station.name_station} и проследует по марщруту: #{route.routes.first.name_station} - #{route.routes.last.name_station}" # " #{self.route.first} - #{self.route.last}"
  end

  def go_to_next_station
    current_station.depart(self)
    @current_location_index += 1
    current_station.handle(self)
  end

  def go_to_previous_station
    current_station.depart(self)
    @current_location_index -= 1
    current_station.handle(self)
  end
  

  def current_station
    @route.stations[@current_location_index] if @route
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

  def current_route?
    @current_route.nil?
  end

  def on_first_station?
    @current_location_index == 0    
  end

  def on_last_station?
    @current_location_index == @route.stations.size - 1
  end


end