# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validation
  extend Accessors

  class << self
    attr_accessor :all
  end

  # attr_reader   :name
  # attr_accessor :trains
  attr_accessor_with_history :trains, :name

  ALL_INFO              = 'Общая информация по количеству поездов по типам на станции...'
  NIL_NAME_ERROR        = '-> название станции не может быть пустым или меньше 2 символов'
  NAME_TOO_LENGTH_ERROR = '-> слишком длинное название, не больше 30 символов'
  NAME_NOT_OBJECT       = '-> имя станции не является обьектом класса String'
  REGEXP                = /^[a-zа-я\d ]{2,32}$/i.freeze # русский-латынь? от 2 до 32 букв

  validate :name, :presence
  validate :name, :format, REGEXP
  validate :name, :type, String

  @@list_all_station = []
  # @list_all_station = []

  def initialize(name)
    @name = name
    @trains = []
    register_instance
    validate!
    @@list_all_station << self
    # self.class.all << self
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
      puts 'Нет станции для удаления!' # raise
    else
      trains.delete(train)
    end
  end

  def each_train
    # trains.each { |train| yield(train) }
    current_trains.each { |train| yield(train) }
  end

  def list_all_trains
    puts "#{trains.length} поезда(ов) на станции."
    trains.each { |train| puts "Поезд номер: #{train[0]}, тип: #{train[1]}, вагонов: #{train[2]}" }
  end

  def current_trains(type = :all)
    return trains if type == :all

    trains.select { |train| train.type == type }
  end

  def total_trains(type = :all)
    current_trains(type).size
  end

  def list_trains_by_type(type = nil)
    return list_trains unless type

    list_trains.each { |train| puts "Поезд типа #{train[1]} имеет номер #{train[0]}" if train[1] == type.to_sym }
    puts ALL_INFO
    c = 0
    p = 0
    list_trains.each { |train| train[1] == type.to_sym ? c += 1 : p += 1 }
    puts "На станции пассажирских поездов: #{p}, грузовых поездов: #{c} "
  end
end
