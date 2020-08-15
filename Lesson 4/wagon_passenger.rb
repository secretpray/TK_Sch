class PassengerWagon < Wagon
  
   attr_reader :type

  def initialize(type)
    @type_wagon = :passenger
    super
  end

end