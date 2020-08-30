class PassengerWagon < Wagon
  include Validate

  TYPE_WAGON_ERROR = '-> неверный тип вагона'
  SIZE_ERROR_DATE  = '-> вместимость выражается в числах'
  SIZE_ERROR       = '-> неверно указана вместимость вагона'
  NAME_WAGON       = 'Пассажирский вагон'
  MIN_SIZE         = 18
  MAX_SIZE         = 64

  attr_reader :type_wagon,
              :number,
              :place_count,
              :places_filled

  alias size place_count
  alias filled_size places_filled

  def initialize(size)
    @type_wagon     = :passenger
    # size > MAX_SIZE || size < MIN_SIZE ? @place_count = 54 : @place_count  = size
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

  def free_size
    place_count - places_filled
  end

  def to_s
    NAME_WAGON + " номер #{number}, вместимостью #{place_count} пассажиров"
  end

  def name
    NAME_WAGON + " номер #{number}, вместимостью #{place_count} пассажиров"
  end

  protected

  attr_writer :places_filled

  def can_fill?
    free_size.positive?  # free_places > 0
  end

  def can_clear?
    places_filled >= 1
  end

  def validate!
    raise TYPE_WAGON_ERROR unless type_wagon == :passenger
    raise SIZE_ERROR_DATE unless Integer(place_count)
    raise SIZE_ERROR if place_count > MAX_SIZE || place_count < MIN_SIZE
  end
end
