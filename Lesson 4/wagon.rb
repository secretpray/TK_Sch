class Wagon
  
  attr_reader :type_wagon

  def initialize
  
  end

  def cargo?
    self.class == CargoWagon 
  end

  def passanger?
    self.class == PassengerWagon 
  end
end


=begin
class CargoW
  attr_accessor :type
  def initialize
    @type = :cargo
  end
end

@wagons = []
puts 'Введите количество вагонов'
count_wagon = gets.chomp.to_i
count_wagon.times { @wagons << CargoW.new }

puts wagons

@wagons
 => [#<CargoW:0x00007fa72ba62e38 @type=:cargo>, #<CargoW:0x00007fa72ba62e10 @type=:cargo>, #<CargoW:0x00007fa72ba62de8 @type=:cargo>] 
@wagons.each { |i| puts i.type}
=> cargo
=> cargo
=> cargo

=end