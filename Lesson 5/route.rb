class Route
  attr_reader   :stations

  include InstanceCounter

  def initialize(departure_station, destination_station)
    @stations = [departure_station, destination_station]
  end

  def to_s
    stations.join(' - ')   # => "Station 1 - Station 2"
  end

  def add_intermediate_station(station)
    @stations.insert(-2, station)
    # puts "Станция '#{@stations[-2]}' добавлена в текущий маршрут" # s@tations.last
  end

  def remove_intermediate_station(station)
    unless [stations.first, stations.last].include?(station)
      @stations.delete(station)
      #puts "Станция «#{station}» удалена из текущего маршрута"
    end
  end
  
  def list_stations
    puts "На маршруте '#{@name}' имеются станции:" # отправления: #{@routes.first} и прибытия: #{@routes.last}\"
    @routes[0..-1].each_with_index { |station, index| p "#{index.next}. #{station}" }
  end
end