require_relative "station"
require_relative "route"
require_relative "train"
require_relative "train_cargo"
require_relative "train_passenger"
require_relative "wagon"
require_relative "wagon_cargo"
require_relative "wagon_passenger"
#require_relative "ss"


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
  attr_reader :stations, :trains, :wagons, :type, :number

  def initialize
  	@routes     = []
    @stations   = []
    @trains     = []
    @carriages  = []
  end
  
  def show_stations_list
    @stations.each { |station| puts station.name_station }
  end

  def show_trains_list
    trains.each { |train| puts "Поезд номер: #{train.number}, тип #{train.type}, в составе которого #{train.wagons.size} вагонов(а)" }
  end

  def show_routes_list
    @routes.each { |route| puts route.list_stations }
  end

  def clear_screen
    print "\e[2J\e[f"
  end

=begin
  def list_object(arr_object)
    arr_object.each do |object|
      print "#{object}: "
      print " Номер: #{object.number}. " if object.methods.include?(:number)
      print " Тип: #{object.type}. " if object.methods.include?(:type)
      # object.list if object.methods.include?(:list)
      puts
    end
  end

  def create_train!(number, type, carriages_count)
    #carriage = get_carriage(type)
    train = if type == 1 ? @trains << CargoTrain.new(number, wagons) : @trains << PassengerTrain.new(number, wagons)
    @trains.each { |train| puts "Поезд номер: #{train.number}, тип #{train.type}, в составе которого #{train.wagons.size} вагонов(а)" }
    #train = get_train(number, type)
    #carriages_count.times { train.add_carriage(carriage) }
    #self.trains << train
    puts "Train with number #{number}, type #{type} has been created with #{wagon.size} carriages"
  end
=end

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
        puts 'Неизвестная команда!'
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
    clear_screen
  	# system 'clear'
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
        puts "Введите количество вагонов:"
        wagons_count = gets.chomp.to_i
        wagons = []
        if type == 1 
          wagons_count.times { wagons << CargoWagon.new} 
        elsif type == 2
          wagons_count.times { wagons << PassengerWagon.new}
        else
          puts "Неверный тип поезда"
        end

        if type == 1 
          @trains << CargoTrain.new(number, wagons) 
        else
          @trains << PassengerTrain.new(number, wagons)
        end
        
        # create_train!(number, type, @wagons)
        # carriages = carriage.times {if type == 1 ? CargoWagon.new(type) : PassengerWagon.new(type)}
        #if type == 1 ? @trains << CargoTrain.new(number, carriages) : @trains << PassengerTrain.new(number, carriages)
        # list_object(@trains)
        puts 'Создан(ы):'
        show_trains_list
        # puts '- -' * 15
        # trains.each { |train| puts "Создан поезд #{train.number}, тип #{train.type}, в составе которого #{train.wagons.size} вагонов(а)" }
        puts "\n\n"
      when 2 
      	system 'clear'
      	puts 'Создаем станцию...'
   		  print "Введите название станции: "
    	  name = gets.chomp.to_s
    	  @stations << Station.new(name)
        puts 'Создан(ы):'
        # list_object(@stations)
        show_stations_list
    	  # @stations.each { |station| puts "Создана(ы) станция #{station.name_station}" }
    	  puts "\n\n"
      when 3 
      	system 'clear'
      	puts 'Создаем маршрут...'
      	print "Введите имя начальной станции: "
      	@from_station = gets.chomp.to_s
      	print "Введите имя конечнй станции: "
      	@to_station = gets.chomp.to_s

		    @routes << Route.new(@from_station, @to_station)
        puts 'Создан(ы):'
        # list_object(@routes)
        show_routes_list
        # @routes.each { |route| puts "#{route.list_stations}" }
		    puts "\n\n"
      else
        puts 'Неизвестная команда!'
      end
    end
  end

  def help_create
    puts 'Введите 1 => для создания поезда;'
    puts 'Введите 2 => для создания станции;'
    puts 'Введите 3 => для создания маршрута;;'
    puts 'Введите 0 => для возврата в предыдущее меню'
  end


  def change_object
    clear_screen
    #system 'clear'
    puts 'Создаем обьекты'
    loop do
      
      help_edit
      puts 'Изменяем обьекты'
      case gets.chomp.to_i
      when 0
        break
      when 1  
        system 'clear'
        puts 'Управления станциями...'
        puts "Введите:\n 1 => для добавления промежуточной станции\n 2 => для удаления промежуточной станции\n 0 => для выхода из меню"
        select = gets.chomp.to_i
        return if select == 0
        if select == 1
          puts 'Add station'
          puts "Маршрут(ы):"
          # @routes.each { |route| puts "#{route.routes[0]} в #{route.routes[-1]}\n list_stations: #{route.list_stations}" }
          # @routes.each { |route| puts "#{route.list_stations}" }
          # show_routes_list
          list_object(@routes)

        elsif select == 2 
          puts 'Remove station'
          puts "Маршрут(ы):"
          # @routes.each { |route| puts "#{route.routes[0]} в #{route.routes[-1]}\n list_stations: #{route.list_stations}"} #{route.list_stations}
          # @routes.each { |route| puts "#{route.list_stations}" }
          # show_routes_list
          list_object(@routes)
        else
          puts 'Неизвестная команда!'
        end
      when 2  
        system 'clear'
        puts "Введите:\n 1 => для добавления вагона в состав\n 2 => для удаления вагона из состава\n 0 => для выхода из меню"
        selectw = gets.chomp.to_i
        return if selectw == 0
        if selectw == 1
          puts 'Доступны следующие поезда:'
          list_object(@trains)
          print 'Введите номер поезда для добавления вагона: '
          number_train = gets.chomp
          train = @trains.find{|train| train.number == number_train} if @trains
          puts 'Доступны следующие вагоны: '
          @wagons.each {|wagon| print " #{wagon.number} " if wagon.train.empty?}
          print "\nВведите номер вагона: "
          number_wagon = gets.chomp
          wagon = @wagons.find{|wagon| wagon.number == number_wagon} if @wagons
          if train && wagon && train.type == wagon.type && train.wagon_add(wagon)
            puts "Вагон добавлен"
          else
            puts "Вагон не добавлен"
          end
        end
        if selectw == 2
          puts 'Доступны следующие поезда:'
          list_object(@trains)
          print 'Введите номер поезда для удаления вагона: '
          number_train = gets.chomp
          train = @trains.find{|train| train.number == number_train} if @trains
          puts 'Доступны следующие вагоны: '
          train.wagons.each {|wagon| print " #{wagon.number} "}
          print "\nВведите номер вагона: "
          number_wagon = gets.chomp
          wagon = @wagons.find{|wagon| wagon.number == number_wagon} if @wagons
          if train && wagon && train.type == wagon.type && train.wagon_del(wagon)
            puts "Вагон удален"
          else
            puts "Вагон не удален"
          end
        end
      when 3  
        system 'clear'
        puts 'Назначения маршрута поезду...'
      when 4  
        system 'clear'
        puts 'Перемещение поезда по маршруту...'
        puts 'Доступны следующие поезда:'
        @trains.each{ |train| puts " Номер: #{train.number}" if train.current_station }
        print 'Введите номер поезда для отправления: '
        number_train = gets.chomp.to_i
        train = @trains.find{|train| train.number == number_train} if @trains
        #if train
        #  loop do
        #    puts "Поезд находится на станции: #{train.current_station.name}"
        #    puts 'Введите 1 для отправления поезда вперед'
        #    puts 'Введите 2 для отправления поезда назад'
        #    puts 'Введите 0 для выхода в предыдущее меню'
        #    optiont = gets.chomp
        #    case optiont
        #      when '1'
        #        train.route_forward
        #      when '2'
        #        train.route_backward
        #      when '0'
        #        break
        #      end
        #    end
        # end
        # end
      else
        puts 'Неизвестная команда!'
      end
    end
  end

  def help_edit
    puts 'Введите 1 => для управления станциями;'
    puts 'Введите 2 => для управления составом;'
    puts 'Введите 3 => для назначения маршрута поезду;'
    puts 'Введите 4 => для перемещения поезда по маршруту'
    puts 'Введите 0 => для возврата в предыдущее меню'
  end

  def info_object
    system 'clear'
    puts "Информация о поездах"
    show_trains_list
    puts '-*-' * 15
  
    puts "Информация о станциях и поездах на станциях"
    show_stations_list
    puts '-*-' * 15
  
    puts "Информация о маршрутах"
    show_routes_list
    puts '-*-' * 15
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