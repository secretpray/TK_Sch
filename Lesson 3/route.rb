=begin
Класс Route (Маршрут):
Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной
=end

class Route
  attr_reader   :stations
                :name

  def initialize(from_station, to_station)
    @name = "#{from_station} - #{to_station}"
    @stations = [from_station, to_station]
    # @stations << @from_station << @to_station
    # puts "Создан маршрут из #{stations[0]} в #{stations[-1]}"
  end

  def from_station
    stations.first
  end

  def to_station
    stations.last
  end

  def add(new_station)
    # if stations.include?(new_station)
    # puts "Станция #{new_station.capitalize} уже присутствует в списке."
    # self.points.push(new_station) # надо вводить для новой станции геттер: attr_reader :points
    stations.insert(-2, new_station)
    puts "Станция «#{stations[-2]}» добавлена в текущий маршрут" # желательно присвоить имя маршруту или номер #{self.name} || #{self.name}
  end

  def delete(station)
    # if stations.delete(station).nil?
    # puts "#{station.name.capitalize} нет в вашем маршруте"
    stations.delete(station) if [stations.first, stations.last].none?(station)
    # stations.delete(station) if station != from_station && station != to_station
    # stations.delete(station) if station != (from_station || to__station)
    # self.points.delete(station)  # надо вводить для новой станции геттер: attr_reader :points
    puts "Станция «#{station}» удалена из текущего маршрута" # желательно присвоить имя маршруту или номер #{self.name} || #{self.name}
  end

  def list_stations
    puts "На заданном маршруте имеются станции:"
    stations.each { |station| puts " - #{station}" }
    # [@start, @points, @finish].flatten.compact # надо вводить для новой станции геттер: attr_reader :points
  end
  


=begin
  def next(current)
    if current != self.stations.last
      self.stations.at(self.stations.index(current) + 1)
    end
  end

  def prev(current)
    if current != self.stations.first
      self.stations.at(self.stations.index(current) - 1)
    end
  end
=end
end
