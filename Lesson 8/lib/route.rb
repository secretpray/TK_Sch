class Route
  include InstanceCounter
  include Validate

  ROUTE_POINT_ERROR     = '-> станции прибытия и отправления должны отличаться'.freeze
  ROUTE_SIZE_ERROR      = '-> в маршруте должно быть минимум 2 станций'.freeze
  NOT_VALID_STATION     = 'Станция не является промежуточной'.freeze
  attr_reader :stations

  def initialize(departure_station, destination_station)
    @stations = [departure_station, destination_station]
    validate!
    register_instance
  end

  def to_s
    stations.join(' - ') # => "Station 1 - Station 2"
  end

  # def name
  #  stations.map(&:name).join('-')
  # end

  def add_intermediate_station(station)
    raise ArgumentError, NOT_VALID_STATION if [stations.first, stations.last].include?(station)

    @stations.insert(-2, station) # unless [stations.first, stations.last].include?(station)
  rescue StandardError => e
    puts "Возникла ошибка #{e.message}. Станция не добавлена."
  end

  def remove_intermediate_station(station)
    raise ArgumentError, NOT_VALID_STATION if [stations.first, stations.last].include?(station)

    @stations.delete(station) # unless [stations.first, stations.last].include?(station)
  rescue StandardError => e
    puts "Возникла ошибка #{e.message}. Станция не удалена."
  end

  protected

  def validate!
    raise ROUTE_POINT_ERROR if stations[0] == stations[-1]
    raise ROUTE_SIZE_ERROR if stations.size < 2
  end
end
