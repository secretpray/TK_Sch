require_relative 'lib/instance_counter'
require_relative 'lib/manufacture'
require_relative 'lib/validate'
require_relative 'lib/interface'
require_relative 'lib/station'
require_relative 'lib/route'
require_relative 'lib/train'
require_relative 'lib/train_passenger'
require_relative 'lib/train_cargo'
require_relative 'lib/wagon'
require_relative 'lib/wagon_passenger'
require_relative 'lib/wagon_cargo'
require_relative 'lib/string'
# require_relative 'lib/test'
require 'io/console' # (для использования STDIN.getch вместо gets)

class Main
  UNKNOWN_COMMAND       = 'Неизвестная команда!'.freeze
  PRESS_KEY_BLINK       = "\nДля продолжения нажмите пробел или Enter.. \033[1;5m_\033[0;25m".freeze
  RESET_COLOR           = system 'printf "\033[0m\033[2J\e[f"'.freeze
  CYAN_ON_BLACK_COLOR   = system 'printf "\033[1;40;96m\033[2J\e[f"'.freeze

  attr_reader :stations, :trains, :routes, :interface

  def initialize
    @interface  = Interface.new(self)
    @trains     = []
    @routes     = []
    @stations   = []
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
        all_info
      when 2
        train_on_station
      when 3
        exist_train_number
      else
        puts UNKNOWN_COMMAND
      end
    end
  end

  def color_main_menu
    CYAN_ON_BLACK_COLOR
  end

  def color_reset
    # RESET_COLOR
    puts 'Всего хорошего!'.default_color
    system 'clear'
  end

  def press_but
    printf PRESS_KEY_BLINK
    loop do
      break if [' ', "\r"].include?(STDIN.getch)
    end
  end

  def select_station
    show_stations_list
    puts 'Выберите станцию:'
    @stations[gets.chomp.to_i - 1]
  end

  def select_route
    puts 'Выберите маршрут для его корректировки...'
    @routes[gets.chomp.to_i - 1]
  end

  def select_train
    puts 'Выберите поезд для управления его составом...'
    @trains[gets.chomp.to_i - 1]
  end

  def show_stations_list
    @stations.each.with_index(1) { |station, index| puts "#{index}. #{station}" }
  end

  def show_stations_list_route
    @stations.each { |station| puts station.to_s }
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
      puts "Поезд номер: #{train.number}, тип #{train.type}"
      puts "В составе #{train.wagons.size} вагонов(а). Вместимость вагонов - #{train.wagons.last.size}."
    end
  end

  def show_trains_list_number
    @trains.each.with_index(1) do |train, index|
      puts "#{index}. Поезд номер: #{train.number}, тип #{train.type}, #{train.wagons.size} вагонов(а)"
    end
  end

  def show_routes_list
    @routes.each.with_index(1) { |route, index| puts "#{index}. #{route}" }
  end

  def show_train_wagon_yield(train)
    train.each_wagons do |wagon|
      puts "Номер вагона: #{wagon.number}, тип вагона: #{wagon.type_wagon};"
      puts "свободно: #{wagon.free_size}, занято: #{wagon.filled_size}"
    end
  end

  def show_station_info
    station = select_station
    if station.trains.empty?
      puts "На станции #{station} нет поездов"
    else
      puts "На станции #{station} следующие поезда (#{station.trains.size}):\n#{station.current_trains.join("\n")}"
    end
  end

  def create_train
    system 'clear'
    puts "Введите тип поезда:\n 1. Грузовой,\n 2. Пассажирский"
    type = gets.chomp.to_i
    # raise ArgumentError, 'Введен неверный тип вагона' unless type == 1 || type == 2
    raise ArgumentError, 'Введен неверный тип вагона' unless [1, 2].include?(type)

    puts 'Введите количество вагонов:'
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
      raise ArgumentError, 'Введен неверный тип поезда.'
    end
    begin
      print 'Введите номер поезда (формат -> xxx-xx): '
      number = gets.chomp
      if type == 1
        @trains << CargoTrain.new(number, wagons)
      elsif type == 2
        @trains << PassengerTrain.new(number, wagons)
      else
        raise ArgumentError, UNKNOWN_COMMAND
      end
    rescue RuntimeError => e
      puts "Ошибка: #{e.message}. Попробуйте еще раз.".red
      # retry
      press_but
    end
    puts 'Создан(ы):'
    show_trains_list
    press_but
    puts "Производитель созданных вагонов: #{wagons.last.company_name}, поезда: #{@trains.last.company_name}"
  rescue StandardError => e
    puts "Возникла ошибка #{e.message}. Поезд не создан.".red
    press_but
  end

  def create_station
    system 'clear'
    puts 'Создаем станцию...'
    print 'Введите название для новой станции: '
    st_input = gets.chomp
    @stations.each { |station| raise 'такая станция сущствует' if station.name == st_input } unless @stations.empty?
    @stations << Station.new(st_input)
    puts "\nСтанция #{@stations.last} создана."
    puts "\nСписок всех станций:"
    show_stations_list
    puts "Общее количество созданных станций - #{Station.all.size}"
    press_but
  rescue StandardError => e
    puts "Возникла ошибка: #{e.message}! Станция не создана.".red
    press_but
  end

  def create_route
    system 'clear'
    puts 'Создаем маршрут...'
    show_stations_list
    puts 'Ввберите номер начальной станции...'
    dep_station = @stations[gets.chomp.to_i - 1]
    puts 'Выберите номер конечной станции...'
    dest_station = @stations[gets.chomp.to_i - 1]
    raise 'номер не из списка' if [dep_station, dest_station].include?(nil)

    input_rt = "#{dep_station} - #{dest_station}"
    @routes.each { |route| raise 'такой маршрут сущствует' if route.to_s == input_rt } unless @stations.empty?
    @routes << Route.new(dep_station, dest_station)
    puts "Маршрут #{@routes.last} создан."
    # show(routes)
    puts 'Создан(ы):'
    show_routes_list
    press_but
  rescue StandardError => e
    puts "Возникла ошибка: #{e.message}! Маршрут не создан.".red
    press_but
  end

  def add_station_to_route(route)
    puts "Добавление новой, промежуточной станции в маршрут #{route}."
    stations_to_add = @stations - route.stations
    raise ArgumentError, 'нет станций, для добавления в маршрут' unless stations_to_add.any?

    stations_to_add.each.with_index(1) { |station, index| puts "#{index}. #{station}" }
    puts 'Введите номер новой промежуточной станции ...'
    intermediate_station = stations_to_add[gets.chomp.to_i - 1]
    raise ArgumentError, 'номер не из списка' if intermediate_station.nil?

    route.add_intermediate_station(intermediate_station)
    puts "Станция '#{intermediate_station}' добавлена в текущий маршрут" # or #{stations[-2]}
    puts "Сейчас выбранный маршрут содержит #{route.stations.size} cтанции(й): #{route.stations.join(' - ')}"
    press_but
  rescue StandardError => e
    puts "Возникла ошибка: #{e.message}!".red
    press_but
  end

  def del_station_to_route(route)
    puts 'Удаление промежуточной станции'
    stations_to_remove = route.stations[1...-1]
    raise ArgumentError, 'в маршруте нет промежуточных станций' unless stations_to_remove.any?

    stations_to_remove.each.with_index(1) { |station, index| puts "#{index}. #{station}" }
    remove_station = stations_to_remove[gets.chomp.to_i - 1]
    raise ArgumentError, 'номер не из списка' if remove_station.nil?

    route.remove_intermediate_station(remove_station)
    puts "Станция #{remove_station} удалена из маршрута."
    puts "Сейчас выбранный маршрут содержит #{route.stations.size} cтанции(й): #{route.stations.join(' - ')}"
    press_but
  rescue StandardError => e
    puts "Возникла ошибка: #{e.message}!".red
    press_but
  end

  def edit_station
    system 'clear'
    puts 'Управление станциями на маршруте...'
    puts '-*-' * 15
    show_routes_list
    puts '-*-' * 15
    route = select_route
    raise 'номер не из списка' if route.nil?

    puts "Выбран маршрут: #{route}"
    puts "Введите:\n 1 => для добавления станции\n 2 => для удаления станции\n 0 => для выхода из меню"
    selects = gets.chomp.to_i
    return if selects.zero?

    if selects == 1
      add_station_to_route(route)
    elsif selects == 2
      del_station_to_route(route)
    else
      raise UNKNOWN_COMMAND
    end
  rescue StandardError => e
    puts "Возникла ошибка: #{e.message}!".red
    press_but
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
      raise ArgumentError, 'Вагон неверного типа не может быть добавлен в состав.'
    end
  rescue StandardError => e
    puts "Возникла ошибка #{e.message}.".red
    press_but
  end

  def change_wagon_size(train)
    show_train_wagon_yield(train)
    puts 'Укажите номер вагона'
    number_select = gets.chomp.to_i
    raise ArgumentError, 'Вагон не выбран.' if number_select.zero?

    wagon_select = 0
    train.wagons.each { |wagon| wagon_select = wagon if wagon.number == number_select }
    raise 'неверный номер вагона' if wagon_select.is_a?(Integer)

    puts "Выбран вагон #{wagon_select}: (свободно: #{wagon_select.free_size}, занято: #{wagon_select.filled_size})"
    puts "1. Заполнить вагон\n2. Освободить вагон\n"
    wg = gets.chomp.to_i
    case wg
    when 1
      wagon_select.fill
      puts "Номер вагона #{wagon_select.number}, free #{wagon_select.free_size}, filled #{wagon_select.filled_size}"
    when 2
      wagon_select.clear
      puts "Номер вагона #{wagon_select.number}, free #{wagon_select.free_size}, filled #{wagon_select.filled_size}"
    else
      raise ArgumentError, UNKNOWN_COMMAND
    end
  rescue StandardError => e
    puts "Возникла ошибка: #{e.message}!".red
    press_but
  end

  def edit_train
    system 'clear'
    puts '-*-' * 15
    # show(trains)
    show_trains_list_number
    puts '-*-' * 15
    train = select_train
    raise ArgumentError, UNKNOWN_COMMAND unless train

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
      end
    elsif operation == 2
      change_wagon_size(train)
    else
      raise ArgumentError, UNKNOWN_COMMAND
    end
  rescue StandardError => e
    puts "Возникла ошибка: #{e.message}!".red
    press_but
  end

  def assign_route
    system 'clear'
    puts 'Назначаем маршрут поезду...'
    raise StandardError, 'сначала необходимо создать поезд/маршрут' if @trains.empty? || @routes.empty?

    puts '-*-' * 15
    show_trains_list_number
    puts '-*-' * 15
    puts 'Выберите поезд для назначения маршрута...'
    train = @trains[gets.chomp.to_i - 1]
    raise 'номер не из списка' if train.nil?

    puts "Выбран - #{train}"
    puts
    show_routes_list
    puts 'Введите номер маршрута для его назначения.'
    route = @routes[gets.chomp.to_i - 1]
    raise 'номер не из списка' if route.nil?

    train.assign_a_route(route)
    puts 'Маршрут успешно назначен'
    press_but
  rescue StandardError => e
    puts "Возникла ошибка: #{e.message}!".red
    press_but
  end

  def move_train
    system 'clear'
    puts 'Перемещение поезда по маршруту...'
    puts 'Доступны следующие поезда:'
    show_trains_list_number
    puts 'Введите номер поезда для отправления: '
    train = @trains[gets.chomp.to_i - 1]
    raise 'номер не из списка или поезд не создан' unless train

    raise 'поезду не присвоен маршрут' unless train.current_station

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
        raise 'поезд на последней станции маршрута' if train.on_last_station?

        train.go_to_next_station
        puts "Поезд прибыл на станцию #{train.current_station}"
        STDIN.getch
      when 2
        raise 'поезд на первой станции маршрута' if train.on_first_station?

        train.go_to_previous_station
        puts "Поезд прибыл на станцию #{train.current_station}"
        STDIN.getch
      else
        raise UNKNOWN_COMMAND
      end
    end
  rescue StandardError => e
    puts "Возникла ошибка: #{e.message}!".red
    press_but
  end

  def all_info
    system 'clear'
    puts 'Информация о поездах'
    show_trains_list
    puts '-*-' * 20
    puts 'Информация о станциях'
    show_stations_list
    puts '-*-' * 20
    puts 'Информация о маршрутах'
    show_routes_list
    puts '-*-' * 20
    puts 'Общая ннформация о всех созданных обьектах (при их наличии):'
    puts "Всего создано поездов: #{PassengerTrain.instances + CargoTrain.instances}" unless @trains.empty?
    puts "Из них пассажирских - #{PassengerTrain.instances}, грузовых - #{CargoTrain.instances}" unless @trains.empty?
    puts "Всего создано станций: #{Station.instances}"  unless @stations.empty?
    puts "Всего создано маршрутов: #{Route.instances}"  unless @routes.empty?
    press_but
  end

  def train_on_station
    system 'clear'
    puts 'Информация о поездах на станциях (стандарт)'
    show_station_info
    puts '-*-' * 20
    puts 'Информация о поездах на станции (yield)'
    show_station_info_yield
    puts '-*-' * 20
    press_but
  end

  def exist_train_number
    if @trains.empty?
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
      press_but
    end
  end
end

# def show(list)
#   list.each.with_index(1){ |item, index| puts "#{index}: #{item}" }
#  end

# def select_from_list(list)
#   choise = gets.to_i
#   return if choise <= 0
#   list[choise - 1]
#   end
# end

maim_menu = Main.new
maim_menu.start
