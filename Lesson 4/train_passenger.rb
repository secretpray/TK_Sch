class PassengerTrain < Train
  
  attr_reader :type, :wagons

  def initialize(number, wagons)
    @type = :passenger
    super
  end

end