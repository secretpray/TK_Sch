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
#	  -  train.type.to_sym 	(attr_reader)   		- тип поезда, учитывается при создании вагонов и их типа, при формировании состава
#   -  class wagon: ('грузовой' :cargo  и 'пассажирский' :passenger) - []
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
    @routes.each { |route| route.list_stations }
  end

  def show_train_on_station
    show_stations_list
    puts '-*-' * 15
    stations.each_with_index { |station, index| puts "#{index}. #{station.name_station} #{station.trains.size}"}
  end

  def clear_screen
    print "\e[2J\e[f"
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
        puts 'Неизвестная команда!'
      end
    end
  end

  def help_main
    puts 'Введите 1 => для создания поезда, станции, маршрута;'
    puts 'Введите 2 => для изменение маршрута, состава поездов и их перемещения;'
    puts 'Введите 3 => для получения информации о поездах, маршрутах и станциях;'
    puts 'Введите 0 => для выхода из программы'
    puts 'Выберите желаемое действие...'
  end


  def create_object
    clear_screen  # system 'clear'
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
        puts 'Создан(ы):'
        show_trains_list
        puts "\n\n"
      when 2 
      	system 'clear'
      	puts 'Создаем станцию...'
   		  print "Введите название станции: "
    	  name = gets.chomp.to_s
    	  @stations << Station.new(name)
        puts 'Создан(ы):'
        show_stations_list  # @stations.each { |station| puts "Создана(ы) станция #{station.name_station}" }
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
        show_routes_list  # @routes.each { |route| puts "#{route.list_stations}" }
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
    clear_screen  #system 'clear'
    puts 'Изменяем обьекты'
    loop do
      
      help_edit
      
      case gets.chomp.to_i
      when 0
        break
      when 1  
        system 'clear'
        puts 'Управления станциями...'
        puts "Введите:\n 1 => для добавления промежуточной станции\n 2 => для удаления промежуточной станции\n 0 => для выхода из меню"
        selects = gets.chomp.to_i
        return if selects == 0
        if selects == 1
          puts 'Добавление станции.'
          puts "Имеющиеся маршрут(ы):"
          puts  '-*-' * 15
          @routes.each_with_index { |route,index| puts " #{index.next}. Из #{route.routes[0]} в #{route.routes[-1]}"}
          puts  '-*-' * 15
          puts 'Выберите маршрут для добавления промежуточной станции'
          index_r = gets.chomp.to_i
          puts "Выбран маршрут: #{@routes[index_r - 1].routes[0]} => #{@routes[index_r - 1].routes[-1]}"
          
          puts 'Введите назавние новой промежуточной станции ...'
          new_station = gets.chomp.capitalize
          @routes[index_r - 1].list_stations
          @routes[index_r - 1].add(new_station)
          puts '-*-' * 15 
          #puts "Станций:" + @routes[index_r - 1].size
          @routes[index_r - 1].list_stations
        elsif selects == 2 
          puts 'Удадение станции'
          puts "Имеющиеся маршрут(ы):"
          @routes.each_with_index { |route,index| puts " #{index.next}. Из #{route.routes[0]} в #{route.routes[-1]}"}
          puts  '-*-' * 15
          puts 'Выберите маршрут для удаления промежуточной станции'
          index_d = gets.chomp.to_i
          puts "Выбран маршрут: #{@routes[index_d - 1].routes[0]} => #{@routes[index_d - 1].routes[-1]}"
          puts 'Введите назавние промежуточной станции для удаления...'
          station = gets.chomp.capitalize
          @routes[index_d - 1].list_stations
          @routes[index_d - 1].delete(station)
          puts '-*-' * 15 
          #puts "Станций:" + @routes[index_d - 1].size
          @routes[index_d - 1].list_stations
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
          show_trains_list
          print 'Введите номер поезда для добавления вагона: '
          number_train = gets.chomp.to_i
          train = @trains.find { |train| train.number == number_train } if @trains
          puts 'Доступны: '
          @trains.each {|train| print " #{train.wagons.size} вагонов(а) типа: #{train.wagons.type_wagon} " if train.wagons.empty?}  #if wagon.train.empty? ; #{train.wagons.size}
          print ' Введеите 1 для добавления товарного (cargo) вагона и 2 - для добавления пассажирского (passenger) '
          wagon_type = gets.chomp.to_i
          if wagon_type == 1 
            train.attache_wagon(:cargo) 
            puts "Вагон добавлен"
          elsif wagon_type == 2 
            train.attache_wagon(:cargo)
            puts "Вагон добавлен"
          else
            puts "Вагон не добавлен"
          end
        end
        if selectw == 2
          puts 'Доступны следующие поезда:'
          show_trains_list
          print 'Введите номер поезда для удаления вагона: '
          number_train = gets.chomp.to_i
          train = @trains.find { |train| train.number == number_train} if @trains
          puts 'Доступны: '
          @trains.each {|train| print " #{train.wagons.size} вагонов(а) типа: #{train.wagons.type_wagon} " if train.wagons.empty?}
          train.remove_wagon
        end
      when 3  
        system 'clear'
        puts 'Назначения маршрута поезду...'
        if @trains.empty? || @routes.empty?
          puts "Нужно сначала создать поезд/маршрут"
        else
          show_trains_list
          puts 'Введите номер поезда для назначения маршрута. '
          trainr = gets.chomp.to_i
          puts 'Введите номер маршрута для его назначения.'
          @routes.each_with_index { |route, index|  puts "#{index.next}. Из #{route.routes[0]} в #{route.routes[-1]}" }
          router = gets.chomp.to_i
          @trains[trainr].set_route(@routes[router])
          puts "Маршрут успешно присвоен"
        end
      when 4  # need work
        system 'clear'
        puts 'Перемещение поезда по маршруту...'
        puts 'Доступны следующие поезда:'
        @trains.each { |train| puts "Поезд Номер: #{train.number}" if train.current_station }
        print 'Введите номер поезда для отправления: '
        number_train = gets.chomp.to_i
        train = @trains.find { |train| train.number == number_train} if @trains
        if train
          loop do
            puts "Поезд находится на станции: #{train.current_station}"
            puts 'Введите 1 для отправления поезда вперед'
            puts 'Введите 2 для отправления поезда назад'
            puts 'Введите 0 для выхода в предыдущее меню'
            opt = gets.chomp
            case opt
            when '0'
              break
            when '1'
              train.next_station
            when '2'
              train.previous_station
            end
          end
        end
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
    puts '-*-' * 20
  
    puts "Информация о станциях и поездах на станциях"
    show_stations_list
    puts '-*-' * 20
  
    puts "Информация о маршрутах"
    show_routes_list
    puts '-*-' * 20
  end
end

menu = Menu.new
menu.start