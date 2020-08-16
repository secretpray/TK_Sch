=begin
Класс Route (Маршрут):
Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной
=end

class Route
  attr_reader   :routes
                :name

  def initialize(from_station, to_station)
    @name = "#{from_station} - #{to_station}"
    @routes = [from_station, to_station]
    # @routes << @from_station << @to_station
    # puts "Создан маршрут из #{routes[0]} в #{routes[-1]}"
  end

  def from_station
    routes.first
  end

  def to_station
    routes.last
  end

  def add(new_station)
    # routes.include?(new_station) ? (puts 'already in route list') : routes.insert(-2, new_station)
    # if routes.include?(new_station)
    #   puts "Станция #{new_station.capitalize} уже присутствует в списке."
    # self.points.push(new_station) # надо вводить для новой станции геттер: attr_reader :points
    routes.insert(-2, new_station)
    puts "Станция «#{routes[-2]}» добавлена в текущий маршрут" # желательно присвоить имя маршруту или номер #{self.name} || #{self.name}
  end

  def delete(station)
    # puts "#{station.name.capitalize} нет в вашем маршруте" if routes.delete(station).nil?
    routes.delete(station) if [routes.first, routes.last].none?(station)
    puts "Станция «#{station}» удалена из текущего маршрута" # желательно присвоить имя маршруту или номер #{self.name} || #{self.name}
  end

  def list_stations
    puts "На маршруте '#{@name}' имеются станции: #{routes.first} and #{routes.last}"
    # routes.each { |station| puts " - #{station}" }
    # [@start, @points, @finish].flatten.compact # надо вводить для новой станции геттер: attr_reader :points
  end
  
=begin
  def next(current)
    if current != self.routes.last
      self.routes.at(self.routes.index(current) + 1)
    end
  end

  def prev(current)
    if current != self.routes.first
      self.routes.at(self.routes.index(current) - 1)
    end
  end
=end
end
