# frozen_string_literal: true

class Train
  include Manufacture, InstanceCounter, Validation 
  extend Accessors

  TRAIN_STOPPED       = 'Поезд остановился'
  COMPANY_NAME        = 'Ford Inc.'
  NUMBER_FORMAT_ERROR = 'Неверный формат номера (3 знака (опционально дефис) 2 знака)'
  NUMBER_WAGONS_ERROR = 'Некорректное количество вагонов'
  REGEXP              = /^[a-zа-яё\d]{3}[-]*[a-zа-яё\d]{2}$/i

  # attr_reader   :number, :speed, :route
  # attr_accessor :wagons
  attr_accessor_with_history :number, :speed, :route, :wagons 

  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, REGEXP 

  @@train_all = {}

  class << self
    attr_accessor :train_all
  end

  def initialize(number, wagons)
    @number = number
    @wagons = wagons
    @speed = 0
    @company_name = COMPANY_NAME
    @@train_all[number] = self
    register_instance
    validate!
  end

  def to_s
    "поезд номер #{@number} (вагонов: #{@wagons.size})"
  end

  def self.find(number)
    @@train_all[number]
  end

  def each_wagons
    wagons.each { |wagon| yield(wagon) }
  end

  def speed_up(value = 20)
    @speed += value
    puts "Скорость увеличена на #{value} км/ч"
  end

  def speed_down(value = 20)
    return if (@speed - value).negative?

    @speed -= value # unless stop?
    puts "Скорость снижена на #{value} км/ч"
  end

  def brake
    @speed = 0
    puts TRAIN_STOPPED
  end

  def attach_wagon(type_wagon)
    return @wagons << CargoWagon.new(rand(60...120)) if type_wagon == :cargo

    @wagons << PassengerWagon.new(rand(18...64))
    # puts "Прицеплен #{type_wagon} вагон. В составе поезда #{@wagons.size} вагонов."
  end

  def detach_wagon
    @wagons.pop unless !stop? && @wagons.size.zero?
    puts "Отцеплен вагон. В составе осталось #{@wagons.size} вагонов."
  end

  def assign_a_route(route)
    current_station.depart(self) if @route
    @route = route
    @current_location_index = 0
    current_station.handle(self)
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

  def on_first_station?
    @current_location_index.zero?
  end

  def on_last_station?
    @current_location_index == @route.stations.size - 1
  end

  def stop?
    @speed.zero?
  end

  def current_route?
    @current_route.nil?
  end
end
