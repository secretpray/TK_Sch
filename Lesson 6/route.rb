class Route
  
  include InstanceCounter
  include Validate

  ROUTE_POINT_ERROR     = 'Станции прибытия и отправления должны отличаться'
  ROUTE_SIZE_ERROR      = 'В маршруте должно быть минимум 2 станций'

  attr_reader   :stations

  def initialize(departure_station, destination_station)
    @stations = [departure_station, destination_station]
    validate!
    register_instance
  end

  def to_s
    stations.join(' - ')   # => "Station 1 - Station 2"
  end

  # def name
  #  stations.map(&:name).join('-')
  # end

  def add_intermediate_station(station)
    raise ArgumentError, 'Станция не является промежуточной' if [stations.first, stations.last].include?(station)
    unless [stations.first, stations.last].include?(station)
      @stations.insert(-2, station)
    end
  end

  def remove_intermediate_station(station)
    raise ArgumentError, 'Станция не является промежуточной' if [stations.first, stations.last].include?(station)
    unless [stations.first, stations.last].include?(station)
      @stations.delete(station)
    end
  end

  protected

  def validate!
    raise InvalidData, ROUTE_POINT_ERROR if stations[0] == stations[-1]
    raise InvalidData, ROUTE_SIZE_ERROR if stations.size < 2
  end
end