# frozen_string_literal: true

class PassengerWagon < Wagon
  include InstanceCounter, Validation
  extend Accessors

  TYPE_WAGON_ERROR = '-> неверный тип вагона'.freeze
  SIZE_ERROR_DATE  = '-> вместимость выражается в числах'.freeze
  SIZE_ERROR       = '-> неверно указана вместимость вагона'.freeze
  NAME_WAGON       = 'Пассажирский вагон'.freeze
  TYPE             = :passenger
  MIN_SIZE         = 18
  MAX_SIZE         = 64

  attr_reader :type_wagon,  :number,  :place_count, :places_filled

  alias size place_count
  alias filled_size places_filled

  validate  :size,        :presence
  validate  :type_wagon,  :presence

  def initialize(size)
    @type_wagon     = TYPE
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
    NAME_WAGON + " номер #{number}, всего мест: #{place_count}, " \
    "свободно мест: #{free_size}."
  end

  def name
    NAME_WAGON + " номер #{number}, всего мест: #{place_count}, " \
    "свободно мест: #{free_size}."
  end

  protected

  attr_writer :places_filled

  def can_fill?
    free_size.positive? # free_places > 0
  end

  def can_clear?
    places_filled >= 1
  end

  # def validate!
  #   raise TYPE_WAGON_ERROR unless type_wagon == :passenger
  #   raise SIZE_ERROR if place_count > MAX_SIZE || place_count < MIN_SIZE
  #   return if (18..64).cover?(@size)
  #   raise 'В вагоне может быть от 18 до 64 мест'
  # end
end
