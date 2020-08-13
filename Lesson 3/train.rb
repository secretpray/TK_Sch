=begin
Класс Train (Поезд):
  Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при
создании экземпляра класса
  Может набирать скорость
  Может возвращать текущую скорость
  Может тормозить (сбрасывать скорость до нуля)
  Может возвращать количество вагонов
  Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  Может принимать маршрут следования (объект класса Route).
  При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
  Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
=end

class Train
  attr_reader   :number, 
                :type, 
                :index
  
  attr_accessor :route, 
                :speed, 
                :carriage, 
                :current_location

  def initialize(number, type, carriage)  #type ('passenger', 'cargo')
    @number   =  number
    @type     =  type.downcase.to_sym
    #validate!
    @carriage =  carriage.to_i
    @speed    =  0
    @route    =  nil
  end

  def accelerate(value = 10)
    @speed += value
    puts "Скорость увеличена на #{value}, текущая скорость #{speed} km/h"
  end

  def decrease_speed(value = 10)
    @speed -= value unless speed.zero?
    puts "Скорость снижена на #{value}, текущая скорость #{speed} km/h"
  end

  def stop
    # self.speed = 0
    @speed = 0
    puts "Поезд остановился, текущая скорость: #{speed} km/h"
  end

  # Прицепляем вагон, если стоим на месте
  def attache_carriage
    # if speed != 0
    #   puts "Cначала остановите поезд!"
    # else 
    #   @carriage += 1
    # end
    @carriage += 1 if speed.zero?
    puts "Вагон прицеплен. В составе сейчас #{carriage} вагонов."
  end

  # Отцепляем вагон, если стоим на месте
  def remove_carriage
    # if speed != 0
    #   puts "Cначала остановите поезд!"
    # else 
    #   carriage -= 1
    # end
    #valid_carriage!(carriage) - > для реализации надо передавать тип вагона!
    @carriage -= 1 if speed.zero? && carriage != 0
    puts "Вагон отцеплен. В составе осталось #{carriage} вагонов."
  end

  def take_route(route)
    return unless @route.nil?
    valid_route(route)
    @route = route
    @index = 0
    current_location.add_train_to_list(self)
    puts current_location.list_trains 
    # self.current_location = self.route.first
    # p self.route -> <Route:0x00007f96c29305e8 @stations=[#<Station:0x00007f96c2930750 @name_station="Moscow", @list_trains=[]>, #<Station:0x00007f96c2930638 @name_station="Dnepr", @list_trains=[]>]> 
    puts "Поезд находится на станции #{current_location.name_station} и проследует по марщруту: #{route.stations.first.name_station} - #{route.stations.last.name_station}" # " #{self.route.first} - #{self.route.last}"
  end

  def current_location
    return if route.nil?
    route.stations[index]
  end

  def next_location
    # return if route.stations.last
    # return if route.nil?
    route.stations[index + 1] unless route.stations.last
  end

  def previous_location
    # return if route.stations.first
    # return if route.nil?
    route.stations[index - 1] unless route.stations.first
  end

  def go_forward
    current_location.remove_train_from_list(self)
    @index += 1
    p route
    # next_location.add_train_to_list(self)
    puts "Поезд приехал на станцию #{current_location.name_station}"  # self.current_location
  end

  def go_backward
    return if @index < 1
    current_location.add_train_to_list(self)
    @index -= 1
    # previous_location.remove_train_from_list(self)
    puts "Поезд приехал на станцию #{current_location.name_station}"  #self.current_location
  end

  protected
  
  # стоит ли вводить проверку на тип прицепляемых вагонов?
  # def valid_carriage!(carriage)
  #   raise 'Тип вагона не совпадает с типом поезда' if carriage.type != type
  # end

  def valid_route(route)
    raise 'Это не маршрут!' if route.class != Route
  end
end

#  def route=(route)
#    if route.stations.size > 2
#      @route = route
#      self.current_station = route.stations.first
#      puts "Поезду номер #{train.number} передан маршрут."
#    else
#      puts 'Маршрут должен содержать 2 станции назначения'
#    end
#  end
#

#  def go(direction)
#    if direction != 'forward' && direction != 'back'
#      puts 'Please enter forward or back'
#    else
#      case direction
#      when 'forward'then index = current_location + 1
#      when 'back' then index = current_location - 1
#      end
#      move_train index
#    end
#  end
