class CargoWagon < Wagon
  
   attr_reader :type

  def initialize(type)
    @type_wagon = :cargo
    super
  end

end