# frozen_string_literal: true
require_relative 'validation'
require_relative 'acсessors'

class Route
  include InstanceCounter, Validation, Acсessors

  ROUTE_POINT_ERROR     = '-> станции прибытия и отправления должны отличаться'.freeze
  ROUTE_SIZE_ERROR      = '-> в маршруте должно быть минимум 2 станций'.freeze
  NOT_VALID_STATION     = 'Станция не является промежуточной'.freeze
  REGEXP                = /^[a-zа-я]$/i.freeze

  attr_accessor :stations
  # attr_accessor_with_history :stations
  attr_reader   :departure_station, :destination_station

  validate  :name,  :presence
  validate  :name,  :type, String
  validate  :name,  :format, REGEXP 
  validate  :departure_station, :format, REGEXP
  validate  :departure_station, :format, REGEXP

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
