class CargoWagon < Wagon
  
  attr_reader :type_wagon

  def initialize
    @type_wagon = :cargo
    super
  end
end