# frozen_string_literal: true

class Route
  include InstanceCounter, Validation
  extend Accessors

  ROUTE_POINT_ERROR     = '-> станции прибытия и отправления должны отличаться'
  ROUTE_SIZE_ERROR      = '-> в маршруте должно быть минимум 2 станций'
  NOT_VALID_STATION     = 'Станция не является промежуточной'
  REGEXP                = /^[a-zа-я]$/i.freeze

  # attr_accessor :stations
  # attr_reader   :departure_station, :destination_station
  attr_accessor_with_history :stations, :departure_station, :destination_station

  validate :stations, :presence
  validate :stations, :type, Array
  # add validate double name in route! 

  def initialize(departure_station, destination_station)
    @stations = [departure_station, destination_station]
    register_instance
    validate!
  end

  def to_s
    stations.join(' - ')
  end

  def name
    stations.map(&:name).join(' - ')
  end

  def add_intermediate_station(station)
    raise ArgumentError, NOT_VALID_STATION if [stations.first, stations.last].include?(station)

    @stations.insert(-2, station)
  rescue StandardError => e
    puts "Возникла ошибка #{e.message}. Станция не добавлена."
  end

  def remove_intermediate_station(station)
    raise ArgumentError, NOT_VALID_STATION if [stations.first, stations.last].include?(station)

    @stations.delete(station)
  rescue StandardError => e
    puts "Возникла ошибка #{e.message}. Станция не удалена."
  end
end
