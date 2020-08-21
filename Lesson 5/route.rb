class Route
  attr_reader   :stations

  include InstanceCounter

  def initialize(departure_station, destination_station)
    @stations = [departure_station, destination_station]
    register_instance
  end

  def to_s
    stations.join(' - ')   # => "Station 1 - Station 2"
  end

  def add_intermediate_station(station)
    unless [stations.first, stations.last].include?(station)
      @stations.insert(-2, station)
      puts "Станция '#{station}' добавлена в текущий маршрут" # or #{stations[-2]}
    end
  end

  def remove_intermediate_station(station)
    unless [stations.first, stations.last].include?(station)
      @stations.delete(station)
      puts "Станция «#{station}» удалена из текущего маршрута"
    end
  end
end

=begin
  def add_intermediate_station(station)
    unless [stations.first, stations.last].include?(station)
    @stations.insert(-2, station)
    #@stations.insert(-2, Station.new(station))
  end

  def remove_intermediate_station(station)
    unless [stations.first, stations.last].include?(station)
    @stations.delete(station)
    puts "#{@stations.delete(station)}"
    puts "Станция «#{station}» удалена из текущего маршрута"
  end
=end