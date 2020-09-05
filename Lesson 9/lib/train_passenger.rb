class PassengerTrain < Train
  # attr_reader :type, :wagons
  attr_accessor_with_history :type, :wagons

  validate :number, :presence
  validate :number, :format, REGEXP
  validate :number, :type, String

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
