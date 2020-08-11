=begin
Класс Route (Маршрут):
Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной
=end

class Route
  attr_reader :stations

  def initialize(from_station, to_station)
    @stations = [from_station, to_station]
  end

  def from_station
    stations.first
  end

  def to_station
    stations.last
  end

  def add(new_station)
    stations.insert(-2, new_station)
  end

  def delete(station)
    stations.delete(station) if [@stations.first, @stations.last].none?(station)
    # stations.delete(station) if station != from_station && station != to_station
  end

  def list_stations
    puts "На заданном маршруте имеются станции:"
    stations.each { |station| puts " - #{station}" }
  end
end
