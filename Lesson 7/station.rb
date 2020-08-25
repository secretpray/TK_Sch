class Station
  

  include InstanceCounter
  include Validate

  ALL_INFO              = 'Общая информация по количеству поездов по типам на станции...'
  NIL_NAME_ERROR        = 'Название станции не может быть пустым или меньше 2 символов'
  NAME_TOO_LENGTH_ERROR = 'Слишком длинное название, не больше 30 символов'
  NAME_NOT_OBJECT       = 'Имя станции не является обьектом класса String'  # /[a-z]/i  - только латинница


  attr_reader   :trains,
                :name

  @@list_all_station = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    register_instance
    @@list_all_station << self
  end

  def self.all
    @@list_all_station
  end
  
  def to_s
    @name
  end
  
  def handle(train)
    if @trains.include?(train)
      puts "Поезд номер #{train.name} уже находится на станции #{name}." # raise
    else 
      @trains.push(train)
    end
  end

  def depart(train)
    if trains.delete(train).nil?
      puts "Нет станции для удаления!"   # raise
    else
      trains.delete(train)
    end
  end
 
   def each_train
    trains.each { |train| yield(train) }
  end

  def list_all_trains
    puts "#{trains.length} поезда(ов) на станции."
    trains.each { |train| puts "Поезд номер: #{train[0]}, тип: #{train[1]}, вагонов: #{train[2]}"  }
  end

  def current_trains(type=:all)
    return trains if type == :all
    trains.select { |train| train.type == type }
  end

  def total_trains(type=:all)
    current_trains(type).size
  end

  def list_trains_by_type(type = nil)
    return list_trains unless type
    list_trains.each { |train| puts "Поезд типа #{train[1]} имеет номер #{train[0]}" if train[1] == type.to_sym} 
    puts ALL_INFO
    c = 0
    p = 0
    list_trains.each { |train| train[1] == type.to_sym ? c += 1 : p += 1 }
    puts "На станции пассажирских поездов: #{p}, грузовых поездов: #{c} "
  end

  protected

  attr_writer :trains

  def validate!
    raise InvalidData, NIL_NAME_ERROR if name.empty? || name.nil?
    raise InvalidData, NIL_NAME_ERROR if name.length < 2
    raise InvalidData, NAME_TOO_LENGTH_ERROR if name.length > 30
    raise InvalidData, NAME_NOT_OBJECT unless @name.is_a? String
  end
end