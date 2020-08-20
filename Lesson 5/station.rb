class Station
  
  attr_reader   :trains

  include InstanceCounter

  @@list_all_station = []

  def initialize(name)
    @name = name
    @trains = []
    register_instance
    @@list_all_station << self
  end

  def self.all
    @@list_all_station
  end
  
  def to_s
    @name
  end
  
  def handle(train)
    if @trains.include?(train)
      puts "Поезд номер #{train.name} уже находится на станции #{name}."
    else 
      @trains.push(train)
    end
  end

  def depart(train)
    if @trains.delete(train).nil?
      puts "Нет станции для удаления!"
    else
      @trains.delete(train)
    end
  end
 

  def list_all_trains
    puts "#{@trains.length} поезда(ов) на станции."
    @trains.each { |train| puts "Поезд номер: #{train[0]}, тип: #{train[1]}, вагонов: #{train[2]}"  }
  end

  def current_trains(type=:all)
    return @trains if type == :all
    @trains.select { |train| train.type == type }
  end

  def total_trains(type=:all)
    current_trains(type).size
  end

  def list_trains_by_type(type = nil)
    return list_trains unless type
    list_trains.each { |train| puts "Поезд типа #{train[1]} имеет номер #{train[0]}" if train[1] == type.to_sym} 
    puts "Общая информация по количеству поездов по типам на станции..."
    c = 0
    p = 0
    list_trains.each { |train| train[1] == type.to_sym ? c += 1 : p += 1 }
    puts "На станции пассажирских поездов: #{p}, грузовых поездов: #{c} "
  end
end