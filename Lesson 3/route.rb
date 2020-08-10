=begin
Класс Route (Маршрут):
Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной
=end

class Route
  attr_reader :stations

  def initialize(from, to)
    @stations = [from, to]
  end

  def from
    stations.first
  end

  def to
    stations.last
  end

  def add(new_station)
    stations.insert(-2, new_station)
  end

  def delete(station)
    stations.delete(station) if station != from && station != to
  end
end