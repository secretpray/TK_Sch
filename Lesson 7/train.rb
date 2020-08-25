# В классе Train создать метод класса find, который принимает номер поезда (указанный при его создании) 
# и возвращает объект поезда по номеру или nil, если поезд с таким номером не найден.

class Train

  include Manufacture
  include InstanceCounter
  include Validate


  TRAIN_STOPPED       = 'Поезд остановился'
  COMPANY_NAME        = 'Ford Inc.'
  NUMBER_FORMAT_ERROR = 'Неверный формат номера (3 знака (опционально дефис) 2 знака)'
  NUMBER_WAGONS_ERROR = 'Некорректное количество вагонов'
  NUMBER_FORMAT       = /^[a-zа-яё\d]{3}[-]*[a-zа-яё\d]{2}$/i
  #/^([a-zа-я0-9]{3})([-— − –])?([a-zа-я0-9]{2})$/i  or /^[а-яa-z0-9]{3}-{0,1}[а-яa-z0-9]{2}$/i or /^\w{3}-?\w{2}$/i or /\A[a-z\d]{3}-?[a-z\d]{2}\z/i or /^([a-z]|\d){3}[-]*([a-z]|\d){2}$/i

  attr_reader   :number, 
                :speed,
                :route

  attr_accessor :wagons

  @@train_all= {}

  def initialize(number, wagons) 
    @number             = number
    @wagons             = wagons  # @wagons = []
    validate!
    @speed              = 0
    @company_name = COMPANY_NAME
    @@train_all[number] = self
    register_instance
  end

  def to_s
    "поезд номер #{@number} (вагонов: #{@wagons.size})"
  end


=begin
    1. Class method
    class << self 
      def self.find(number)
        @@train_all[number]
      end
    
    2. Class method
    def Train.find(number)
      @@train_all[number]
    end 
    
    3. Class method 
    class Train; end
    def Train.find(number)
      @@train_all[number
    end
=end

  # 4. Class method (standard)
  def self.find(number)
    @@train_all[number]
  end
  
  def speed_up(value = 20)
    @speed += value
    puts "Скорость увеличена на #{value} км/ч"
  end

  def speed_down(value = 20)
    return if @speed - value < 0  
    @speed -= value # unless stop?
    puts "Скорость снижена на #{value} км/ч"
  end

  def brake
    @speed = 0
    puts TRAIN_STOPPED
  end
  
  def attach_wagon(type_wagon)
    if type_wagon == :cargo 
      @wagons << CargoWagon.new 
      # puts "Прицеплен #{type_wagon} вагон. В составе сейчас #{@wagons.size} вагонов."  # #{@wagons.last.class} проверить?
    else 
      @wagons << PassengerWagon.new
      # puts "Прицеплен #{type_wagon} вагон. В составе сейчас #{@wagons.size} вагонов."  # #{@wagons.last.class} проверить?
    end
  end

  def detach_wagon
    @wagons.pop if stop? && @wagons.size != 0
    puts "Отцеплен вагон. В составе осталось #{@wagons.size} вагонов."
  end

  def assign_a_route(route)
    current_station.depart(self) if @route
    @route = route
    @current_location_index = 0
    current_station.handle(self)
  end

  def go_to_next_station
    current_station.depart(self)
    @current_location_index += 1
    current_station.handle(self)
  end

  def go_to_previous_station
    current_station.depart(self)
    @current_location_index -= 1
    current_station.handle(self)
  end
  

  def current_station
    @route.stations[@current_location_index] if @route
  end

    def on_first_station?
    @current_location_index == 0    
  end

  def on_last_station?
    @current_location_index == @route.stations.size - 1
  end

  def stop? 
    @speed.zero?
  end

  def current_route?
    @current_route.nil?
  end

  protected

  # Чтобы запретить вмешиваться в проверки   
  
  def validate!
    raise InvalidData, NUMBER_FORMAT_ERROR if number !~ NUMBER_FORMAT
    raise InvalidData, NUMBER_WAGONS_ERROR if @wagons.size  < 1 || @wagons.size  > 150 
  end

end