# frozen_string_literal: true

class CargoWagon < Wagon
  include InstanceCounter
  include Validation
  extend Accessors

  TYPE_WAGON_ERROR = '-> yеверный тип вагона'
  SIZE_ERROR_DATE  = '-> вместимость выражается в числах'
  SIZE_ERROR       = '-> неверно указана вместимость вагона'
  NAME_WAGON       = 'Грузовой вагон' # тип "#{self.class}"
  TYPE             = :cargo
  MIN_SIZE         = 60
  MAX_SIZE         = 120

  # attr_reader :type_wagon,  :number,  :volume,  :volume_size
  attr_accessor_with_history :type_wagon, :number, :volume, :volume_size

  alias size volume_size
  alias filled_size volume

  validate  :volume_size, :presence
  validate  :volume_size, :positive
  validate  :type_wagon,  :presence

  def initialize(size)
    @type_wagon   = TYPE
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
    NAME_WAGON + " номер #{number}, вместимостью #{volume_size} м³ " \
    "свободно: #{free_size} м³."
  end

  def name
    NAME_WAGON + " номер #{number}, вместимостью #{volume_size} м³ " \
    "свободно: #{free_size} м³."
  end

  protected

  attr_writer :volume

  def can_fill?
    free_size.positive?
  end

  def can_clear?
    volume >= 1
  end

  # def validate!
  #  raise TYPE_WAGON_ERROR unless type_wagon == :cargo
  #  raise SIZE_ERROR if volume_size > MAX_SIZE || volume_size < MIN_SIZE
  #  return if (60..120).cover?(@size)
  #  raise 'Объем может составлять от 50 до 150 м³.'
  # end
end
