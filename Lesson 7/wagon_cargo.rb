class CargoWagon < Wagon
  
  include Validate

  TYPE_WAGON_ERROR = 'Неверный тип вагона'
  SIZE_ERROR_DATE  = 'Вместимость выражается в числах'
  SIZE_ERROR       = 'Должна быть больше нуля'
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
    MAX_SIZE > 120 || size < MIN_SIZE ? @volume_size = 60 : @volume_size  = size
    # @volume_size  = size
    validate!
    @volume       = 0
    @number       =rand(1..1000)
    super
  end

  def fill
    can_fill? ? self.volume += 1 : (raise 'Вагон заполнен')
  end

  def clear
    can_clear? ? self.volume -= 1 : (raise 'Вагон пуст')
  end

  def free_size # free_volume
    volume_size - volume
  end

  def to_s
    NAME_WAGON + " номер #{self.number}, вместимостью #{volume_size} куб.м"
  end

  def name 
    NAME_WAGON + " номер #{self.number}, вместимостью #{volume_size} куб.м"
  end

  protected

  attr_writer :volume

  def can_fill?
    volume_size - volume > 0
  end

  def can_clear?
    volume > 1
  end
  
  def validate!
    raise InvalidData, TYPE_WAGON_ERROR unless type_wagon == :cargo
    raise InvalidData, SIZE_ERROR_DATE unless Integer(volume_size)
    raise InvalidData, SIZE_ERROR if volume_size < 1
  end
end