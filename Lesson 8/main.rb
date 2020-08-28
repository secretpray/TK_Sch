require_relative "instance_counter"
require_relative "manufacture"
require_relative 'validate'
require_relative "interface"
require_relative "station"
require_relative "route"
require_relative "train"
require_relative "train_passenger"
require_relative "train_cargo"
require_relative "wagon"
require_relative "wagon_passenger"
require_relative "wagon_cargo"
# require_relative "test"
require 'io/console' # (для использования STDIN.getch вместо gets)


class Main
  
  UNKNOWN_COMMAND = 'Неизвестная команда!'

  attr_reader :stations,
              :trains,
              :routes,
              :interface

  def initialize
    @interface = Interface.new(self)
    @trains   = []
    @routes   = []
    @stations = []
  end

  def start
    system "printf '\e[1;40;96m\033[u'" 
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
    system "printf '\e[1;40;96m\033[u'"
  end

  def color_reset
    system 'printf "\033[0m\033[2J\e[f"' 
  end

  def press_key
    print "\nДля продолжения - нажмите пробел или Enter ... \033[1;5m _ \033[0;25m"
      loop do
        break if [' ', "\r"].include?(STDIN.getch)
      end
    # gets
    # STDIN.getch
    #sleep(1) 
  end

  def show_stations_list
    @stations.each.with_index(1) { |station, index| puts "#{index}. #{station}" } 
  end

  def show_stations_list_route
    @stations.each { |station| puts "#{station}" }
  end

  def show_station_info_yield
    show_stations_list
    puts 'Выберите станцию:'
    station = @stations[gets.chomp.to_i - 1]
    if station.trains.empty?
      puts "На станции #{station} нет поездов"
    else
      station.each_train do |train|
      puts "Количество поездов на станции #{station}: #{station.trains.size}."
      puts "Номер поезда: #{train.number}, тип поезда: #{train.type}"
      puts "Количество вагонов: #{train.wagons.size}"
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
    @trains.each.with_index(1) { |train, index| puts "#{index}. Поезд номер: #{train.number}, тип #{train.type}, в составе которого #{train.wagons.size} вагонов(а)" }
  end

  def show_routes_list
    @routes.each.with_index(1) { |route, index| puts "#{index}. #{route}" }  
  end

  def show_train_wagon_yield(train)
    train.each_wagons do |wagon| 
      puts "Номер вагона: #{wagon.number}, тип вагона: #{wagon.type_wagon}, кол-во свободных мест: #{wagon.free_size}, количество занятых мест:#{wagon.filled_size}"
      end
  end

  def show_station_info
    show_stations_list
    puts 'Выберите станцию:'
    station = @stations[gets.chomp.to_i - 1]
    if station.trains.empty?
      puts "На станции #{station} нет поездов"
    else
      puts "Сейчас на станции #{station} следующие поезда (#{station.trains.size}):\n#{station.current_trains.join("\n")}"
    end
  end

  def create_train
    system 'clear'
    puts 'Создаем поезд...'
    print "Введите номер поезда (формат -> xxx-xx): "
    number = gets.chomp
    # rescue RuntimeError => e
    #   puts "Ошибка: #{e.message}. Попробуйте еще раз."
    #   retry
    # end
    puts "Введите тип поезда:\n 1. Грузовой,\n 2. Пассажирский"
    type = gets.chomp.to_i
    raise 'Введен неверный тип вагона' unless type == 1 || type == 2
    #  rescue StandardError => e 
    #    puts "Ошибка: #{e.message}. Попробуйте еще раз."
    #    press_key
    #    retry
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
      raise "Введен неверный тип поезда."
    end
    if type == 1
      @trains << CargoTrain.new(number, wagons)
    elsif type == 2
      @trains << PassengerTrain.new(number, wagons)
    else 
      raise UNKNOWN_COMMAND
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

  def edit_station
    system 'clear'
    puts 'Управление станциями на маршруте...'
    puts  '-*-' * 15
    show_routes_list
    puts  '-*-' * 15
    puts 'Выберите маршрут для его корректировки...'
    route = @routes[gets.chomp.to_i - 1]
    puts "Выбран маршрут: #{route}"

    puts "Введите:\n 1 => для добавления промежуточной станции\n 2 => для удаления промежуточной станции\n 0 => для выхода из меню"
    selects = gets.chomp.to_i
    return if selects == 0
    if selects == 1
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
          puts 'Ошибка, нет станций, которые можно было бы добавить в маршрут.'
        end
    elsif selects == 2
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
        puts 'Ошибка, в маршруте нет промежуточных станций.'
      end
    else
      puts UNKNOWN_COMMAND
    end
  end

  def edit_train
    system 'clear'
    puts  '-*-' * 15
    # show(trains)
    show_trains_list_number
    puts  '-*-' * 15
    puts 'Выберите поезд для управления его составом...'
    train = @trains[gets.chomp.to_i - 1]
    puts "Выбран - #{train}"
    puts "1 -> чтобы измененить состав\n2 -> чтобы занять или освободить место в вагоне\3 - чтобы выйти в меню"
    operation = gets.chomp.to_i
      if operation == 1
        puts "Введите:\n 1 => для добавления вагона в состав\n 2 => для удаления вагона из состава\n 0 => для выхода из меню"
        sel = gets.chomp.to_i
        return if sel == 0
        if sel == 1
          puts "Введеите:\n 1 - для добавления товарного (cargo)\n 2 - для добавления пассажирского (passenger) вагонов"
          wagon_type = gets.chomp.to_i
          if wagon_type == 1
            puts 'Введите грузоподьемность вагона в тоннах (от 60 до 120)'
            volume_size = gets.chomp.to_i
            volume_size = 60 if volume_size > 120 || volume_size < 60
            train.attach_wagon(CargoWagon.new(volume_size))
          elsif wagon_type == 2
            puts 'Введите количество мест в вагоне (от 18 до 64)'
            place_count = gets.chomp.to_i
            place_count = 54 if place_count > 64 || place_count < 18
            train.attach_wagon(PassengerWagon.new(place_count))
          else
            puts "Вагон неверного типа не может быть добавлен в состав."
          end  
        elsif sel == 2
          train.detach_wagon
        else
          puts UNKNOWN_COMMAND
        end
      elsif operation == 2
        show_train_wagon_yield(train)
        puts 'Укажите номер вагона'
        number_select = gets.chomp.to_i
        wagon_select = 0
        train.wagons.each { |wagon| wagon_select = wagon if wagon.number == number_select }
        puts "Выбран вагон #{wagon_select}: (свободно: #{wagon_select.free_size}, занято: #{wagon_select.filled_size})"
        puts "1. Заполнить вагон\n2. Освободить вагон\n"
        wg = gets.chomp.to_i
        if wg == 1
          wagon_select.fill
          puts "Номер вагона: #{wagon_select.number}, свободно: #{wagon_select.free_size}, занято: #{wagon_select.filled_size}"
        elsif wg == 2
          wagon_select.clear
          puts "Номер вагона: #{wagon_select.number}, свободно: #{wagon_select.free_size}, занято: #{wagon_select.filled_size}"
        else
          puts UNKNOWN_COMMAND
        end
        press_key
      else
        puts UNKNOWN_COMMAND
      end 
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