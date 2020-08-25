class CargoWagon < Wagon
  
  include Validate

  TYPE_WAGON_ERROR = 'Неверный тип вагона'

  attr_reader :type_wagon

  def initialize
    @type_wagon = :cargo
    validate!
    super
  end

  protected
  
  def validate!
    raise InvalidData, TYPE_WAGON_ERROR unless type_wagon == :cargo
  end
end