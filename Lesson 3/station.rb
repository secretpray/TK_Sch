=begin
Класс Station (Станция):
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
=end

class Station
  attr_accessor :list_trains
  attr_reader   :name_station

  def initialize(name_station)
    @name_station = name_station
    @list_trains = []
  end

  # добавляем поезд в список поездов по прибытию
  def add_train_to_list(train)
    # if list_trains.include?(train)
    # puts "Поезд номер #{train.number} уже находится на станции #{name_station}."
    list_trains << train
  end

  # удаляем поезд со списка поездов при отбытии
  def remove_train_from_list(train)
    # if list_trains.delete(train).nil?
    # puts "Поезд номер #{train.number} не находится на станции #{name_station}."
    list_trains.delete(train)
    # list_trains.reject! { |ts| ts[0] == train[0] } # пересоздаем новый массив и проходимся по всем совпадениям
  end

  # выводим список всех поездов на станции
  def list_all_trains
    list_trains.each { |train| puts "Поезд номер: #{train[0]}, тип: #{train[1]}, вагонов: #{train[2]}"  }
  end

  # выводим список поездов на станции по типу (грузовые или пассажирские)
  def list_trains_by_type(type)
    # list_trains.group_by(&:type).each { |key, value| print "#{key}: #{value.count}" if key == type }
    # print list_trains.select { |train| train[1] == type.to_sym }
    list_trains.each { |train| puts "Поезд типа #{train[1]} имеет номер #{train[0]}" if train[1] == type.to_sym} # проверить нужно ли конвертировать в символ - YES
    puts "Общая информация по количеству поездов по типам на станции..."
    c = 0
    p = 0
    list_trains.each { |train| train[1] == type.to_sym ? c += 1 : p += 1 }
    puts "На станции пассажирских поездов: #{p}, грузовых поездов: #{c} "
  end
end