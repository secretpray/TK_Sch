class CargoTrain < Train
  
   attr_reader :type

  def initialize(number, carriage)
    @type = :cargo
    super
  end

end