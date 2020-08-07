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
  attr_reader   :number, :type, :railway_carriageб :index
  attr_accessor :route, :speed,

  def initialize(number, type, railway_carriage)
    @number = number
    @type = type
    @railway_carriage = railway_carriage
    @speed = 0
  end

  def accelerate(value = 10)  # если без передачи аргумента
    puts "Скорость увеличена на #{value}, текущая скорость #{@speed} km/h"
    @speed += value
  end

  def decrease_speed(value = 10)  # если без передачи аргумента
    puts "Скорость снижена на #{value}, текущая скорость #{@speed} km/h"
    @speed -= value unless @speed.zero?
  end

  def attache_carriage
    @railway_carriage += 1 if @speed.zero?
  end

  def remove_carriage
    puts 'Вагон отцеплен. В составе осталось #{@railway_carriage} вагонов'
    @railway_carriage -= 1 if @speed.zero? && @railway_carriage != 0
  end

  def add_a_route(route)
    @route = route
    @index = 0
    #@station = @route.stations[0]
    #@station.add_train(self)
    current_location.take(self)
  end

  def current_location
    route.stations[@index]
  end

  def next_location
    route.stations[@index + 1] unless last_station?
  end

  def previous_location
    route.stations[@index - 1] unless first_station?
  end

  def go_forward
    current_location.send_a_train(self)
    next_location.take_the_train(self)
    @index += 1
  end

  def go_backward
    current_location.send_a_train(self)
    previous_location.take_the_train(self)
    @index -= 1
  end

  def last_station?
    current_location == route.stations.last
  end

  def first_station?
    current_location == route.stations.first
  end
end