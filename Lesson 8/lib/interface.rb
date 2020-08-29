class Interface

  EXIT        = "Для выхода из программы нажмите Enter или 0 ... \033[5m _ \033[25m"   
  RETURN      = "Для возврата в предыдущее меню нажмите Enter или 0 ... \033[5m _ \033[25m"   
  attr_reader :main

  def initialize(main)
    @main = main
  end

  def help_main
    system 'clear'
    puts '*****' * 14
    puts '*            Главное меню "Управления железной дорогой.            *'
    puts '*****' * 14
    puts
    puts 'Выберите действие. Некоторые функции доступны после создания обьектов!'
    puts 'Введите 1 => для создания поезда, станции, маршрута;'
    puts 'Введите 2 => для изменение маршрута, состава поездов и их перемещения;' unless main.trains.empty? && main.routes.empty?
    puts 'Введите 3 => для получения информации о поездах, маршрутах и станциях;'
    puts
    print EXIT
    gets.chomp.to_i
  end

  def help_create
    system 'printf "\033[1;44;93m\033[2J\e[f"'  # system 'printf "\033[1;44;96m\033[2J\e[f"'    
    system 'clear'
    puts 'Выберите действие. Некоторые функции доступны после создания обьектов!'
    puts 'Введите 1 => для создания поезда;'
    puts 'Введите 2 => для создания станции;'
    puts 'Введите 3 => для создания маршрута;' unless main.stations.size < 2
    puts
    print RETURN 
    gets.chomp.to_i
  end

  def help_edit
    system 'printf "\033[1;44;96m\033[2J\e[f"'
    system 'clear'
    puts 'Выберите действие. Некоторые функции доступны после создания обьектов!'
    puts 'Введите 1 => для управления станциями;' unless main.stations.size < 2
    puts 'Введите 2 => для управления составом;'  unless main.trains.empty?
    puts 'Введите 3 => для назначения маршрута поезду;' unless main.trains.empty? || main.routes.empty?
    puts 'Введите 4 => для перемещения поезда по маршруту' unless main.trains.empty? || main.routes.empty?
    puts
    print RETURN
    gets.chomp.to_i
  end

  def help_info
    system 'printf "\033[1;100;92m\033[2J\e[f"'  # system 'printf "\033[1;44;96m\033[2J\e[f"'
    system 'clear'
    puts 'Выберите действие. Некоторые функции доступны после создания обьектов!'
    puts 'Введите 1 => для вывода информации о поездах, станциях и маршрутах;'
    puts 'Введите 2 => для вывода информации о поездах на станции;' unless main.stations.size < 2
    puts 'Введите 3 => для проверки наличия поезда по его номеру' unless main.trains.size == 0
    puts
    print RETURN
    gets.chomp.to_i
  end
end