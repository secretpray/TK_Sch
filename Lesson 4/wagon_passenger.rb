class PassengerWagon < Wagon
  
attr_reader :type_wagon

  def initialize
    # @type = :passenger
    @type_wagon = :passenger
    super
  end
end