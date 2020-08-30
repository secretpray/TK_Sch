require_relative "lib/instance_counter"
require_relative "lib/manufacture"
require_relative 'lib/validate'
require_relative "lib/interface"
require_relative "lib/station"
require_relative "lib/route"
require_relative "lib/train"
require_relative "lib/train_passenger"
require_relative "lib/train_cargo"
require_relative "lib/wagon"
require_relative "lib/wagon_passenger"
require_relative "lib/wagon_cargo"
require_relative "lib/string"
# require_relative "lib/test"
require 'io/console' # (для использования STDIN.getch вместо gets)


class Main
  
  UNKNOWN_COMMAND       = 'Неизвестная команда!'
  PRESS_KEY_BLINK       = "\nДля продолжения нажмите пробел или Enter.. \033[1;5m_\033[0;25m"
  RESET_COLOR           = system 'printf "\033[0m\033[2J\e[f"'
  CYAN_ON_BLACK_COLOR   = system 'printf "\033[1;40;96m\033[2J\e[f"'

  attr_reader :stations, :trains, :routes, :interface

  def initialize
    @interface = Interface.new(self)
    @trains   = []
    @routes   = []
    @stations = []
  end

  def start
    loop do
      input = interface.help_main
      case input
      when 0
        color_reset
        break 
      when 1
        create_object
      when 2
        change_object
      when 3
        info_object
      else
        puts UNKNOWN_COMMAND
      end
    end
  end
  
  def create_object
	  puts 'Создаем обьекты'
	  loop do
      input = interface.help_create
      case input
      when 0
        color_main_menu
        break
      when 1
        create_train
      when 2
        create_station
      when 3
        create_route
      else
        puts UNKNOWN_COMMAND
      end
    end
  end

  def change_object
    puts 'Изменяем обьекты'
    loop do
      input = interface.help_edit
      case input
      when 0
        color_main_menu
        break
      when 1
        edit_station
      when 2
        edit_train
      when 3
        assign_route
      when 4
        move_train
      else
        puts UNKNOWN_COMMAND
      end
    end
  end

  def info_object
    loop do
      input = interface.help_info
      case input
      when 0
        color_main_menu
        break
      when 1
        all_information
      when 2
        train_on_station
      when 3
        exist_train_by_number
      else
        puts UNKNOWN_COMMAND
      end
    end
  end

  def color_main_menu
    CYAN_ON_BLACK_COLOR
  end

  def color_reset
    RESET_COLOR 
  end

  def press_key
    printf PRESS_KEY_BLINK
      loop do
        break if [' ', "\r"].include?(STDIN.getch)
      end
  end

  def select_station
    show_stations_list
    puts 'Выберите станцию:'
    station = @stations[gets.chomp.to_i - 1]
  end

  def select_route
    puts 'Выберите маршрут для его корректировки...'
    route = @routes[gets.chomp.to_i - 1]
  end

  def select_train
    puts 'Выберите поезд для управления его составом...'
    train = @trains[gets.chomp.to_i - 1]
  end

  def show_stations_list
    @stations.each.with_index(1) { |station, index| puts "#{index}. #{station}" } 
  end

  def show_stations_list_route
    @stations.each { |station| puts "#{station}" }
  end

  def show_station_info_yield
    station = select_station
    puts "Выбрана станция #{station}"
    if station.trains.empty?
      puts "На станции #{station} нет поездов"
    else
      station.each_train do |train|
      puts "Количество поездов на станции #{station}: #{station.trains.size}."
      puts "Номер поезда: #{train.number}, тип поезда: #{train.type}, количество вагонов: #{train.wagons.size}"
      end
    end
  end

  def show_trains_list
    @trains.each do |train| 
      puts "Поезд номер: #{train.number}, тип #{train.type}, в составе которого #{train.wagons.size} вагонов(а)."
      puts "Вместимость вагонов - #{train.wagons.last.size}." 
      end
  end

  def show_trains_list_number
    @trains.each.with_index(1) { |train, index| puts "#{index}. Поезд номер: #{train.number}, тип #{train.type}, #{train.wagons.size} вагонов(а)" }
  end

  def show_routes_list
    @routes.each.with_index(1) { |route, index| puts "#{index}. #{route}" }  
  end

  def show_train_wagon_yield(train)
    train.each_wagons do |wagon| 
      puts "Номер вагона: #{wagon.number}, тип вагона: #{wagon.type_wagon}, свободно: #{wagon.free_size}, занято: #{wagon.filled_size}"
      end
  end

  def show_station_info
    station = select_station
    if station.trains.empty?
      puts "На станции #{station} нет поездов"
    else
      puts "Сейчас на станции #{station} следующие поезда (#{station.trains.size}):\n#{station.current_trains.join("\n")}"
    end
  end

  def create_train
    system 'clear'
    puts "Введите тип поезда:\n 1. Грузовой,\n 2. Пассажирский"
    type = gets.chomp.to_i
    raise ArgumentError, 'Введен неверный тип вагона' unless type == 1 || type == 2
    puts "Введите количество вагонов:"
    wagons_count = gets.chomp.to_i
    wagons = []
    if type == 1
      puts 'Введите грузоподьемность вагона в тоннах (от 60 до 120)'
      volume_size = gets.chomp.to_i
      wagons_count.times { wagons << CargoWagon.new(volume_size) }
    elsif type == 2
      puts 'Введите количество мест в вагоне (от 18 до 64)'
      place_count = gets.chomp.to_i
      wagons_count.times { wagons << PassengerWagon.new(place_count) }
    else
      raise ArgumentError, "Введен неверный тип поезда."
    end
    begin
      print "Введите номер поезда (формат -> xxx-xx): "
      number = gets.chomp
    
      if type == 1
        @trains << CargoTrain.new(number, wagons)
      elsif type == 2
        @trains << PassengerTrain.new(number, wagons)
      else 
        raise ArgumentError, UNKNOWN_COMMAND
      end
    rescue RuntimeError => e
      puts "Ошибка: #{e.message}. Попробуйте еще раз."
      retry
    end
    
    puts 'Создан(ы):'
    show_trains_list
    press_key
    puts "Производитель созданных вагонов: #{wagons.last.company_name}, поезда: #{@trains.last.company_name}"
    rescue Exception => e
      puts "Возникла ошибка #{e.message}. Поезд не создан."
    press_key
  end

  def create_station
    system 'clear'
    puts 'Создаем станцию...'
    print "Введите название для новой станции: "
    @stations << Station.new(gets.chomp.to_s)
    puts "Станция #{@stations.last} создана."
    puts 'Список всех станций:'
    show_stations_list
    puts "Общее количество созданных станций - #{Station.all.size}"
    press_key
    rescue Exception => e
      puts "Возникла ошибка #{e.message}. Станция не создана."
    press_key
  end

  def create_route
    system 'clear'
    puts 'Создаем маршрут...'
    show_stations_list
    puts  'Ввберите номер начальной станции...'
    departure_station = @stations[gets.chomp.to_i - 1]
    puts  'Выберите номер конечной станции...'
    destination_station = @stations[gets.chomp.to_i - 1]
    @routes << Route.new(departure_station, destination_station)
    puts "Маршрут #{@routes.last} создан."
    # show(routes)
    puts 'Создан(ы):'
    show_routes_list
    press_key
    rescue Exception => e
      puts "Возникла ошибка #{e.message}. Маршрут не создан."
    press_key
  end

  def add_station_to_route(route)
    puts "Добавление новой, промежуточной станции в маршрут #{route}."
    stations_to_add = @stations - route.stations
      if stations_to_add.any?
        stations_to_add.each.with_index(1) { |station, index| puts "#{index}. #{station}" } #
        puts 'Введите номер новой промежуточной станции ...'
        intermediate_station = stations_to_add[gets.chomp.to_i - 1]
        route.add_intermediate_station(intermediate_station)
        puts "Станция '#{intermediate_station}' добавлена в текущий маршрут" # or #{stations[-2]}
        puts "Сейчас выбранный маршрут содержит #{route.stations.size} cтанции(й): #{route.stations.join(' - ')}"
        press_key
      else
        raise ArgumentError, 'Ошибка, нет станций, которые можно было бы добавить в маршрут.'
        press_key
      end
      rescue Exception => e
        puts "Возникла ошибка #{e.message}."
      press_key
  end

  def del_station_to_route(route)
    puts 'Удаление промежуточной станции'
    stations_to_remove = route.stations[1...-1]
    if stations_to_remove.any?
      stations_to_remove.each.with_index(1) { |station, index| puts "#{index}. #{station}" } 
      remove_station = stations_to_remove[gets.chomp.to_i - 1] 
      route.remove_intermediate_station(remove_station)
      puts "Станция #{remove_station} удалена из маршрута."
      puts "Сейчас выбранный маршрут содержит #{route.stations.size} cтанции(й): #{route.stations.join(' - ')}"
      press_key
    else
      raise ArgumentError, 'Ошибка, в маршруте нет промежуточных станций.'
      press_key
    end
    rescue Exception => e
      puts "Возникла ошибка #{e.message}."
    press_key
  end

  def edit_station
    system 'clear'
    puts 'Управление станциями на маршруте...'
    puts  '-*-' * 15
    show_routes_list
    puts  '-*-' * 15
    route = select_route
    puts "Выбран маршрут: #{route}" 
    puts "Введите:\n 1 => для добавления промежуточной станции\n 2 => для удаления промежуточной станции\n 0 => для выхода из меню"
    selects = gets.chomp.to_i
    return if selects == 0
    if selects == 1
      add_station_to_route(route)
    elsif selects == 2
      del_station_to_route(route)
    else
      puts UNKNOWN_COMMAND
      press_key
    end
  end

  def add_wagon_to_train(train)
    puts "Введеите:\n 1 - для добавления товарного (cargo) вагона\n 2 - для добавления пассажирского (passenger) вагона"
    wagon_type = gets.chomp.to_i
    if wagon_type == 1
      puts 'Введите грузоподьемность вагона в тоннах (от 60 до 120)'
      volume_size = gets.chomp.to_i
      # volume_size = 60 if volume_size > 120 || volume_size < 60
      train.attach_wagon(CargoWagon.new(volume_size))
    elsif wagon_type == 2
      puts 'Введите количество мест в вагоне (от 18 до 64)'
      place_count = gets.chomp.to_i
      # place_count = 54 if place_count > 64 || place_count < 18
      train.attach_wagon(PassengerWagon.new(place_count))
    else
      raise ArgumentError, "Вагон неверного типа не может быть добавлен в состав."
      press_key
    end
    rescue Exception => e
      puts "Возникла ошибка #{e.message}."
    press_key  
  end

  def change_wagon_size(train)
    show_train_wagon_yield(train)
    puts 'Укажите номер вагона'
    number_select = gets.chomp.to_i
    wagon_select = 0
    train.wagons.each { |wagon| wagon_select = wagon if wagon.number == number_select }
    puts "Выбран вагон #{wagon_select}: (свободно: #{wagon_select.free_size}, занято: #{wagon_select.filled_size})"
    puts "1. Заполнить вагон\n2. Освободить вагон\n"
    wg = gets.chomp.to_i
    case wg
      when 1
        wagon_select.fill
        puts "Номер вагона: #{wagon_select.number}, свободно: #{wagon_select.free_size}, занято: #{wagon_select.filled_size}"
      when 2
        wagon_select.clear
        puts "Номер вагона: #{wagon_select.number}, свободно: #{wagon_select.free_size}, занято: #{wagon_select.filled_size}"
      else
        raise ArgumentError, UNKNOWN_COMMAND
        press_key
      end
    rescue Exception => e
      puts "Возникла ошибка #{e.message}."
    press_key
  end

  def edit_train
    system 'clear'
    puts  '-*-' * 15
    # show(trains)
    show_trains_list_number
    puts  '-*-' * 15
    train = select_train
    puts "Выбран поезд: #{train}"
    puts "1 -> чтобы добавить или отцепить вагоны в состав\n2 -> чтобы занять или освободить место в вагоне"
    operation = gets.chomp.to_i
      if operation == 1
        puts "Введите:\n 1 => для добавления вагона в состав\n 2 => для удаления вагона из состава"
        sel = gets.chomp.to_i
        case sel
          when 1
            add_wagon_to_train(train)
          when 2
            train.detach_wagon
          else
            raise ArgumentError, UNKNOWN_COMMAND
            press_key
        end
      elsif operation == 2
        change_wagon_size(train)
      else
        raise ArgumentError, UNKNOWN_COMMAND
        press_key
      end
    rescue Exception => e
      puts "Возникла ошибка #{e.message}."
    press_key
  end

  def assign_route
    system 'clear'
    puts 'Назначаем маршрут поезду...'
    if @trains.empty? || @routes.empty?
      puts "Нужно сначала создать поезд/маршрут"
    else
      puts  '-*-' * 15
      show_trains_list_number
      puts  '-*-' * 15
      puts 'Выберите поезд для назначения маршрута...'
      train = @trains[gets.chomp.to_i - 1]
      puts "Выбран - #{train}"
      puts
      show_routes_list
      puts 'Введите номер маршрута для его назначения.'
      route = @routes[gets.chomp.to_i - 1]
      train.assign_a_route(route)
      puts 'Маршрут успешно назначен'
      press_key
      # STDIN.getch
    end
  end

  def move_train
    system 'clear'
    puts 'Перемещение поезда по маршруту...'
    puts 'Доступны следующие поезда:'
    show_trains_list_number
    puts 'Введите номер поезда для отправления: '
    train = @trains[gets.chomp.to_i - 1]
    if train
      loop do
        system 'clear'
        puts "Поезд находится на станции: #{train.current_station}"
        puts 'Введите 1 для отправления поезда вперед'
        puts 'Введите 2 для отправления поезда назад'
        puts
        puts 'Для возврата в предыдущее меню нажмите Enter или 0 ...'
        opt = gets.chomp.to_i
        case opt
        when 0
          break
        when 1
          if train.on_last_station?
            puts 'Ошибка, поезд на последней станции маршрута.'
          else
            system 'clear'
            train.go_to_next_station
            puts "Поезд прибыл на станцию #{train.current_station}"
            STDIN.getch
          end
        when 2
          if train.on_first_station?
            puts 'Ошибка, поезд на первой станции маршрута.'
          else
            system 'clear'
            train.go_to_previous_station
            puts "Поезд прибыл на станцию #{train.current_station}"
            press_key
          end
        else
          puts UNKNOWN_COMMAND
        end
      end
    end
  end

  def all_information
    system 'clear'
    puts "Информация о поездах"
    show_trains_list
    puts '-*-' * 20
    puts "Информация о станциях"
    show_stations_list
    puts '-*-' * 20
    puts "Информация о маршрутах"
    show_routes_list
    puts '-*-' * 20
    puts "Общая ннформация о всех созданных обьектах (при их наличии):"
    puts "Всего создано поездов: #{PassengerTrain.instances + CargoTrain.instances} (пассажирских - #{PassengerTrain.instances}, грузовых - #{CargoTrain.instances})" unless @trains.size <1
    puts "Всего создано станций: #{Station.instances}"  unless @stations.size < 1
    puts "Всего создано маршрутов: #{Route.instances}"  unless @routes.size < 1
    press_key
  end

  def train_on_station
    system 'clear'
    puts  'Информация о поездах на станциях (стандарт)'
    show_station_info
    puts '-*-' * 20
    press_key
    puts 'Информация о поездах на станции (yield)'
    show_station_info_yield
    puts '-*-' * 20
    press_key
  end

  def exist_train_by_number
    if @trains.size == 0
      puts 'Поезда отсутствуют...'
    else
      puts 'Для удобстав выводим список поездов:'
      show_trains_list
      print 'Для проверки наличия поезда введите его номер - '
      view_train = Train.find(gets.chomp)
      return nil if view_train.nil?
      puts "Данные по поезду с выбранным номером: #{view_train}"
      puts '-*-' * 20
      puts 'Информация о вагонах в поезде (yield)'
      show_train_wagon_yield(view_train)
      puts '-*-' * 20 
      press_key
    end  
  end
end

=begin
  def show(list)
    list.each.with_index(1){ |item, index| puts "#{index}: #{item}" } 
  end

  def select_from_list(list)
    choise = gets.to_i
    return if choise <= 0
    list[choise - 1]
  end
=end

maim_menu = Main.new
maim_menu.start