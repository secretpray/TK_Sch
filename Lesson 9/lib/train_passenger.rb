class PassengerTrain < Train
  attr_reader :type, :wagons

  def initialize(number, wagons)
    @type = :passenger
    super
  end

  def to_s
    'Пассажирский ' + super
  end

  def attach_wagon(wagon)
    @wagons << wagon if wagon.is_a? PassengerWagon
  end
end
