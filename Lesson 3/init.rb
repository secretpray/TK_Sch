require "./station"
require "./route"
require "./train"
#validate :number, :format, /^\w{3}-?\w{2}$/

# Test Train class
puts "Тестируем класс Train (поезд)..."

puts "У поезда имеется номер, тип (пассажирский, грузовой) и количество вагонов."
p train6 = Train.new(12, "passenger", 6)
p train7 = Train.new(13, "cargo", 7)
puts '-*-' * 15

puts "Первый поезд (номер #{train6.number}) набирает скорость (без параметров)"
train6.accelerate
puts "Текущая скорость поезда:"
puts train6.speed

puts '-*-' * 15
puts "Первый поезд (номер #{train6.number}) набирает скорость (+20 км/ч)"
train6.accelerate(20)
puts train6.speed
puts '-*-' * 15

puts "Поезд останавливается..."
train6.stop
puts "Текущая скорость поезда номер #{train6.number}: #{train6.speed}"
puts '-*-' * 15

puts "В составе поезда #{train6.carriage} вагонов"
puts '-*-' * 15

puts "Добавляем вагоны в состав поезда..."
train6.attache_carriage
puts "В составе поезда номер #{train6.number} сцеплено #{train6.carriage} вагонов."
puts '-*-' * 15

puts "Отцепляем вагоны из состава поезда..."
train6.remove_carriage
puts "В составе поезда номер #{train6.number} сцеплено #{train6.carriage} вагонов."
puts '-*-' * 15

# Test Station class
puts "Тестируем класс Station (станции)..."

station1 = Station.new"Pulkovo"
train1 = [12, :passenger, 8]
train2 = [13, :cargo, 9]
train3 = [14, :cargo, 2]
train4 = [15, :cargo, 7]
train5 = [12, :passenger, 5]
puts "Добавление 5 поездов"
station1.add_train_to_list train1
station1.add_train_to_list train2
station1.add_train_to_list train3
station1.add_train_to_list train4
station1.add_train_to_list train5
puts '-*-' * 15
puts "1) Список всех поездов на станций: #{station1.name_station}"
puts '-*-' * 15
puts "1.1 Геттер: #{station1.list_trains}"
# station1.list_all_trains
puts "1.2 Функция: #{station1.list_all_trains}"
puts '-*-' * 15
puts "2) Вывод поездов на станции по типу - пассажирские ('passenger')"
station1.list_trains_by_type("passenger")
puts '-*-' * 15
puts "3) Удаление поезда с номером 12, тип: пассажирский ('passenger')"
station1.remove_train_from_list(train5)
station1.list_all_trains
puts '-*-' * 15


# Test route
puts "Тестируем класс route (маршруты)..."
route1 = Route.new('Moscow', 'Piter')
route2 = Route.new('Kiev', 'Lvov')
route3 = Route.new('Minsk', 'Gomel')
puts "Список станций"
puts '-*-' * 15
route1.list_stations
puts '-*-' * 15
route2.list_stations
puts '-*-' * 15
route3.list_stations
puts '-*-' * 15

puts "На машруте 1 станция назначения: #{route1.from_station}, конечная станция: #{route1.to_station}"
puts '- -' * 15
puts "На машруте 2 станция назначения: #{route2.from_station}, конечная станция: #{route2.to_station}"
puts '- -' * 15
puts "На машруте 3 станция назначения: #{route3.from_station}, конечная станция: #{route3.to_station}"

puts "Добавление новой станции в каждый машрут (Pulkovo, Zitomir, Pinsk)"
route1.add('Pulkovo')
route2.add('Zitomir')
route3.add('Pinsk')
puts '-*-' * 15
puts "На машруте 1 - #{route1.stations.size} станции(й)."
route1.list_stations
puts '-*-' * 15
puts "На машруте 2 - #{route2.stations.size} станции(й)."
route2.list_stations
puts '-*-' * 15
puts "На машруте 3 - #{route3.stations.size} станции(й)."
route3.list_stations

puts "Удаление станций на первом машруте - 'Pulkovo', на втором - 'Kiev', на третьтем - 'Gomel'"
puts '-*-' * 15
route1.delete('Pulkovo')
puts "На машруте 1: #{route1.stations.size} станции(й)."
route1.list_stations

puts '-*-' * 15
route2.delete('Kiev')
puts "На машруте 2: #{route2.stations.size} станции(й)."
route2.list_stations

puts '-*-' * 15
route3.delete('Gomel')
puts "На машруте 3: #{route3.stations.size} станции(й)."
route3.list_stations

puts ' - - ' * 15
puts 'Удаление несуществующей станции'
route1.delete('Gomel')
puts "На машруте 1 - #{route1.stations.size} станции(й)."
route1.list_stations


=begin
train7 = Train.new(91, 'passenger',  '15')
train8 = Train.new(24,'passenger',  '38')
train9 = Train.new(16,  'cargo',  '21')
route4 = Route.new(Station.new('Moscow'), Station.new('Dnepr'))
route1.list_stations
route4.add_station(Station.new('Tula'))
route4.add_station(Station.new('Belgorod'))
route4.add_station(Station.new('Harkov'))
train7.route_train(route1)
train7.current_station
train7.move_next
train8.route_train(route1)
train8.move_next
route1.stations[1].trains.size
train7.move_next
route1.stations[2].trains.size
train7.move_previous
route1.stations[1].trains.size
=end