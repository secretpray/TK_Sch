class CargoTrain < Train
  
  attr_reader :type, :wagons

  def initialize(number, wagons)
    @type = :cargo
    super
  end

end