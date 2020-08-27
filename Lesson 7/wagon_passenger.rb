class PassengerWagon < Wagon
  
  include Validate

  TYPE_WAGON_ERROR = 'Неверный тип вагона'
  NAME_WAGON       = 'Пассажирский вагон'
  SIZE_ERROR_DATE  = 'Вместимость выражается в числах'
  SIZE_ERROR       = 'Должна быть больше нуля'

  attr_reader :type_wagon, 
              :number,
              :place_count, 
              :places_filled

  alias size place_count
  alias filled_size places_filled

  def initialize(size)
    @type_wagon     = :passenger
    @place_count    = size
    @places_filled  = 0
    validate!
    @number = rand(1..40)
    super
  end

   def fill
    can_fill? ? self.places_filled += 1 : (raise 'Вагон заполнен')
  end

  def clear
    can_clear? ? self.places_filled -= 1 : (raise 'Вагон пуст')
  end

  def free_size # free_places
    place_count - filled_size
  end

   def to_s
    NAME_WAGON + " номер #{self.number}, вместимостью #{place_count} пассажиров"
  end

  def name 
    NAME_WAGON + " номер #{self.number}, вместимостью #{place_count} пассажиров"
  end

  protected

  attr_writer :places_filled

  def can_fill?
    free_places > 0
  end

  def can_clear?
    places_filled > 1
  end

  def validate!
    raise InvalidData, TYPE_WAGON_ERROR unless type_wagon == :passenger
    raise InvalidData, SIZE_ERROR_DATE unless Integer(place_count)
    raise InvalidData, SIZE_ERROR if place_count < 1
  end
end