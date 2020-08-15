require_relative "station"
require_relative "route"
require_relative "train"
require_relative "train_cargo"
require_relative "train_passenger"
require_relative "wagon"
require_relative "wagon_cargo"
require_relative "wagon_passenger"



# Создадим class контроллер действий в меню.
# Что мы должны создавать и в каком алгоритме?
# 1) Поезд (train) с номером (number), типом (type): ('грузовой' :cargo  и 'пассажирский' :passenger):
#   -  train.name.to_i 		(attr_reader) 			- имя поезда   
#	-  train.type.to_sym 	(attr_reader)   		- тип поезда, учитывается при создании вагонов и их типа, при формировании состава
#   -  class wagon, с двумя пока пустыми типами (type): ('грузовой' :cargo  и 'пассажирский' :passenger) - []
#   -  количество вагонов (wagon || carriage)
# train = CargoTrain.new((name => 1212, type => :cargo, wagons => [WagonCargo.new, WagonCargo.new, WagonCargo.new, WagonCargo.new], carriage => wagons.size, speed =>)
# 2) Станция пока без изменений
# 3) Маршрут пока без изменений 

# Необходимо создание меню с возможностью выюора:
# 1 -> Создание станции, поезда, вагона, маршрута;
#  подпункты 	1.1 создание поезда 	(номер, тип, количество вагонов, которые должны создаваться автоматически по типу поезда в массиве)
#  				1.2 создание машрута 	(станция отправления и станция назначения в массиве)
# 	 			1.3 передача машрута поезду (как обьект)
# 2 -> Изменение маршрута, состава поездов, перемещение поезда;
# подпункты		2.1 формирование состава, перемещение поезда, изменение его скорости движения
# 				2.2 добавление/удаление (промежуточных) станций в маршрут 
# 3 -> Вывести текущие данные о машруте, поезде, станции и количестве обьектов.
# подпункты.    3.1 информация о поезде, его типе, количестве вагонов, скорости и местонахождении
#  				3.2	инофрмация о маршруте (количество и имена станций)
# 				3.3 инф-ция о станции (название, количество и тип поездов на станции)
# 4 -> Выход   




puts 'Выберите желаемое действие...'


class Menu
  attr_reader :stations, :trains

  def initialize
  	@routes = []
    @stations = []
    @trains = []
  end

  def start
    system 'clear'
    loop do
      
      help_main

      case gets.chomp.to_i
      when 0
        break
      when 1 
      	create_object
      when 2 
      	change_object
      when 3 
      	info_object
      else
        puts 'Неизвестная команда'
      end
    end
  end

  def help_main
    puts 'Введите 1 => для создания поезда, станции, маршрута;'
    puts 'Введите 2 => для изменение маршрута, состава поездов и их перемещения;'
    puts 'Введите 3 => для получения информации о поездах, маршрутах и станциях;'
    puts 'Введите 0 => для выхода из программы'
  end


  def create_object
  	system 'clear'
	puts 'Создаем обьекты'
	loop do
      
      help_create

      case gets.chomp.to_i
      when 0
        break
      when 1 
      	system 'clear'
      	puts 'Создаем поезд...'
      	print "Введите номер поезда: "
        number = gets.chomp.to_i
        puts "Введите тип поезда (1 - грузовой, 2 - пассажирский)"
        type = gets.chomp.to_i
        puts "Введите количество вагонов"
        carriage = gets.chomp.to_i
        if type == 1
          @trains << CargoTrain.new(number, carriage)
        elsif type == 2
          @trains << PassengerTrain.new(number, carriage)
        else
          puts "Неверный тип поезда"
        end
        @trains.each { |train| puts "Создан поезд #{train.number}, тип #{train.type}, в составе которого #{train.carriage} вагонов(а)" }
        puts "\n\n"
      when 2 
      	system 'clear'
      	puts 'Создаем станцию...'
   		print "Введите название станции: "
    	name = gets.chomp.to_s
    	@stations << Station.new(name)
    	@stations.each { |station| puts "Создана(ы) станция #{station.name_station}" }
    	puts "\n\n"
      when 3 
      	system 'clear'
      	puts 'Создаем маршрут...'
      	print "Введите имя начальной станции: "
      	from_station = gets.chomp.to_s
      	print "Введите имя конечнй станции: "
      	to_station = gets.chomp.to_s

      	#@stations.each do |station|
        #	@start = station if station.name == from_station
        #	@finish = station if station.name == to_station
      	#end
		@routes << Route.new(from_station, to_station)
		#@routes.each { |route| puts "Создан новый маршрут: #{route.list_stations}" }
		puts "\n\n"
      else
        puts 'Неизвестная команда'
      end
    end
  end

  def help_create
    puts 'Введите 1 => для создания поезда;'
    puts 'Введите 2 => для создания станции;'
    puts 'Введите 3 => для создания маршрута;;'
    puts 'Введите 0 => для выхода из программы'
  end


  def change_object
	puts 'Изменяем обьекты'
  end

  def info_object
	puts 'Информация об обьектах'
  end
end

menu = Menu.new

menu.start

=begin
		
end
def data_test
	# train1 = PassengerTrain.new(12, 6)
end

#data_test

train1 = PassengerTrain.new(12001, 16)
puts "Поезд номер #{train1.number} (#{train1.type.to_s.capitalize}) увеличивает скорость на +10 км/ч "
train1.accelerate
puts "Текущая скорость поезда номер #{train1.number} (#{train1.type.to_s.capitalize}): #{train1.speed} км/ч"
puts '-*-' * 15

train1.accelerate(20)
puts "Текущая скорость поезда номер #{train1.number} (#{train1.type.to_s.capitalize}): #{train1.speed} км/ч"
puts '-*-' * 15

puts "Поезд замедляется на 10 км/ч..."
train1.decrease_speed(10)
puts "Текущая скорость поезда номер #{train1.number} (#{train1.type.to_s.capitalize}): #{train1.speed} км/ч"
puts '-*-' * 15

puts "Поезд замедляется на 30 км/ч..."
train1.decrease_speed(30)
puts "Текущая скорость поезда номер #{train1.number} (#{train1.type.to_s.capitalize}): #{train1.speed} км/ч"
puts '-*-' * 15

puts "Поезд останавливается..."
train1.stop
puts "Текущая скорость поезда номер номер #{train1.number} (#{train1.type.to_s.capitalize}) = #{train1.speed} км/ч"
puts '-*-' * 15



train2 = CargoTrain.new(13119, 31)
puts "Поезд номер #{train2.number} (#{train2.type.to_s.capitalize}) увеличивает скорость на +10 км/ч "
train2.accelerate
puts "Текущая скорость поезда номер #{train2.number} (#{train2.type.to_s.capitalize}): #{train2.speed} км/ч"
puts '-*-' * 15

train2.accelerate(20)
puts "Текущая скорость поезда номер #{train2.number} (#{train2.type.to_s.capitalize}): #{train2.speed} км/ч"
puts '-*-' * 15

puts "Поезд замедляется на 10 км/ч..."
train2.decrease_speed(value = 10)
puts "Текущая скорость поезда номер #{train2.number} (#{train2.type.to_s.capitalize}): #{train2.speed} км/ч"
puts '-*-' * 15

puts "Поезд останавливается..."
train2.stop
puts "Текущая скорость поезда номер номер #{train2.number} (#{train2.type.to_s.capitalize}) = #{train2.speed} км/ч"
puts '-*-' * 15



puts "В составе поезда номер #{train1.number} (#{train1.type.to_s.capitalize}): #{train1.carriage} вагонов(а)"
puts '-*-' * 15

puts "Добавляем пассажирские вагоны в состав пассажирского поезда, в котором сейчас - #{train1.carriage} вагонов."
train1.attache_carriage('passenger')
puts "В составе пассажирского поезда номер #{train1.number} сцеплено #{train1.carriage} вагонов."
puts '-*-' * 15

puts "Пытаемся добавить грузовые вагоны в состав пассажирского поезда, в котором сейчас - #{train1.carriage} вагонов."
train1.attache_carriage('cargo')
puts "В составе пассажирского поезда номер #{train1.number} сцеплено #{train1.carriage} вагонов."
puts '-*-' * 15

puts "Отцепляем вагоны из состава поезда..." # нельзя от пассажирского поезда отцепить вагоны иного типа...
train1.remove_carriage
puts "В составе поезда номер #{train1.number} сцеплено #{train1.carriage} вагонов."
puts '-*-' * 15


train3 = CargoTrain.new(14001, 22)
train4 = PassengerTrain.new(15909, 9)
train5 = PassengerTrain.new(16121, 11)

station1 = Station.new "Pulkovo"

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
puts '- -' * 15
puts "1.2 Функция: #{station1.list_all_trains}"
puts '-*-' * 15

puts "2) Вывод поездов на станции по типу - пассажирские ('passenger')"
station1.list_trains_by_type("passenger")
puts '-*-' * 15

puts "3) Удаление поезда с номером 12"
station1.remove_train_from_list(train5)
station1.list_all_trains
puts '-*-' * 15


# Test Train class
puts "Тестируем класс Train (поезд)..."


# Test Station class
puts "Тестируем класс Station (станции)..."









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


puts '= = = ' * 15 
train7 = Train.new(	91,	'passenger',	'15')
train8 = Train.new( 24,	'passenger',	'38')
train9 = Train.new( 16,	'cargo',		'21')
route4 = Route.new(Station.new('Moscow'), Station.new('Dnepr'))
puts 'Создан новый маршрут (обьект):'
route4.stations.each { |station| p station.name_station }
#route4.list_stations # здесь не применимо, так как здесь маршрут обьект, а не array
puts '+ + ' * 15
station10 = Station.new('Tula')
puts "Создана новая станция #{station10.name_station}"
puts '= = = ' * 15

train8.take_route(route4)
#train8.current_location
puts "В настоящий момент поезд находится в #{train8.current_location.name_station}"
p train8.current_location.name_station
# puts '= = = ' * 15
train8.go_forward
puts "В настоящий момент поезд находится #{train8.current_location.name_station}"
puts '= = = ' * 15
puts "#{route4.stations[1].list_trains.size} поезда(ов)."
puts "В настоящий момент поезд находится #{train8.current_location.name_station}" unless train8.current_location.nil?
puts '= = = ' * 15
train8.go_backward
puts "В настоящий момент поезд находится #{train8.current_location.name_station}" unless train8.current_location.nil?
=end