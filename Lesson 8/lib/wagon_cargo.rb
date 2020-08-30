class CargoWagon < Wagon
  include Validate

  TYPE_WAGON_ERROR = '-> yеверный тип вагона'
  SIZE_ERROR_DATE  = '-> вместимость выражается в числах'
  SIZE_ERROR       = '-> неверно указана вместимость вагона'
  NAME_WAGON       = 'Грузовой вагон'
  MIN_SIZE         = 60
  MAX_SIZE         = 120

  attr_reader :type_wagon,
              :number,
              :volume,
              :volume_size

  alias size volume_size
  alias filled_size volume

  def initialize(size)
    @type_wagon   = :cargo
    # size > MAX_SIZE || size < MIN_SIZE ? @volume_size = 72 : @volume_size  = size
    @volume_size  = size
    @volume       = 0
    validate!
    @number = rand(1..1000)
    super
  end

  def fill
    can_fill? ? self.volume += 1 : (raise 'Вагон заполнен')
  end

  def clear
    can_clear? ? self.volume -= 1 : (raise 'Вагон пуст')
  end

  def free_size
    volume_size - volume
  end

  def to_s
    NAME_WAGON + " номер #{number}, вместимостью #{volume_size} куб.м"
  end

  def name
    NAME_WAGON + " номер #{number}, вместимостью #{volume_size} куб.м"
  end

  protected

  attr_writer :volume

  def can_fill?
    free_size.positive?
  end

  def can_clear?
    volume >= 1
  end

  def validate!
    raise TYPE_WAGON_ERROR unless type_wagon == :cargo
    raise SIZE_ERROR_DATE unless Integer(volume_size)
    raise SIZE_ERROR if volume_size > MAX_SIZE || volume_size < MIN_SIZE
  end
end
