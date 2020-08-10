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
    list_trains << train
  end

  # удаляем поезд со списка поездов при отбытии
  def remove_train_from_list(train)
    list_trains.delete(train)
    # list_trains.reject! { |ts| ts[0] == train[0] } # пересоздаем новый массив и проходимся по всем совпадениям
  end

  # выводим список всех поездов на станции
  def list_all_trains
    list_trains.each { |train| puts "Поезд номер: #{train[0]}, тип: #{train[1]}, вагонов: #{train[2]}"  }
  end

  # выводим список поездов на станции по типу (грузовые или пассажирские)
  def list_trains_by_type(type)
    # list_trains.select { |train| train[1] == type.to_sym }
    list_trains.each { |train| puts train[0] if train[1] == type.to_sym} # проверить нужно ли конвертировать в символ
  end
end


station1 = Station.new"Pulkovo"
train1 = [12, :pass, 8]
train2 = [13, :gruz, 9]
train3 = [14, :gruz, 2]
train4 = [15, :pass, 7]
train5 = [12, :pass, 5]
puts "Добавление 5 поездов"
station1.add_train_to_list train1
station1.add_train_to_list train2
station1.add_train_to_list train3
station1.add_train_to_list train4
station1.add_train_to_list train5
puts "1) Список всех поездов на станций: #{station1.name_station}"
puts "1.1 Геттер: #{station1.list_trains}"
# station1.list_all_trains
puts "1.2 Функция: #{station1.list_all_trains}"
puts "2) Вывод поездов на станции по типу pass"
station1.list_trains_by_type("pass")
puts "3) Удаление поезда с номером 12 pass"
station1.remove_train_from_list(train5)
station1.list_all_trains
