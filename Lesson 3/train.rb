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
  attr_reader   :number, :type, :index
  attr_accessor :route, :speed, :carriage, :current_station

  def initialize(number, type, carriage)
    @number =   number
    @type =     type
    @carriage = carriage
    @speed =    0
  end

  def accelerate(value = 10)
    @speed += value
    puts "Скорость увеличена на #{value}, текущая скорость #{@speed} km/h"
  end

  def decrease_speed(value = 10)
    @speed -= value unless speed.zero?
    puts "Скорость снижена на #{value}, текущая скорость #{@speed} km/h"
  end

  def stop
    @speed = 0
    puts "Поезд остановился, текущая скорость: #{speed} km/h"
  end

  # Прицепляем вагон, если стоим на месте
  def attache_carriage
    @carriage += 1 if speed.zero?
    puts "Вагон прицеплен. В составе сейчас #{carriage} вагонов."
  end

  # Отцепляем вагон, если стоим на месте
  def remove_carriage
    @carriage -= 1 if speed.zero? && carriage != 0
    puts "Вагон отцеплен. В составе осталось #{carriage} вагонов."
  end

  def add_a_route(route)
    @route = route
    @index = 0
    current_location.take(self)
  end

  def current_location
    route.stations[index]
  end

  def next_location
    route.stations[index + 1] unless route.stations.last
  end

  def previous_location
    route.stations[index - 1] unless route.stations.first
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
end