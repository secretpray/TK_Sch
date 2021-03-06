require_relative 'validation_error'
require_relative 'validation'
require_relative 'accessors'
require_relative 'instance_counter'
require_relative 'manufacture'
require_relative 'interface'
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'train_passenger'
require_relative 'train_cargo'
require_relative 'wagon'
require_relative 'wagon_passenger'
require_relative 'wagon_cargo'
require_relative 'string'
require 'io/console' # (для использования STDIN.getch вместо gets)

cargo_pass1 = []
cargo_pass2 = []
cargo_pass3 = []

rand(7..30).times { cargo_pass1 << CargoWagon.new(rand(60...120)) }
rand(7..30).times { cargo_pass2 << CargoWagon.new(rand(60...120)) }
rand(7..30).times { cargo_pass3 << CargoWagon.new(rand(60...120)) }

cargo1 = CargoTrain.new((rand(100...999).to_s + '-' + rand(10...99).to_s), cargo_pass1)

wagon_pass1 = []
wagon_pass2 = []
wagon_pass3 = []

rand(5..24).times { wagon_pass1 << PassengerWagon.new(rand(18...64)) }
rand(5..24).times { wagon_pass2 << PassengerWagon.new(rand(18...64)) }
rand(5..24).times { wagon_pass3 << PassengerWagon.new(rand(18...64)) }

passenger1 = PassengerTrain.new((rand(100...999).to_s + '-' + rand(10...99).to_s), wagon_pass1)
passenger2 = PassengerTrain.new((rand(100...999).to_s + '-' + rand(10...99).to_s), wagon_pass2)

station1 = Station.new('Киев')
station2 = Station.new('Минск')
station3 = Station.new('Москва')

puts "Исходное имя станции: #{station1}"
station1.name = 'Львов'
station1.name = 'Днепр'

puts 'История изменения имени этой станции:'
puts station1.name_history
puts

station1.trains = [passenger1]
puts station1.trains

station1.handle(passenger2)
station1.trains = [passenger2]

puts "История нахождения поездов на станции: #{station1}"
puts station1.trains_history
puts

route1 = Route.new(station1, station2)
route2 = Route.new(station2, station3)

cargo1.assign_a_route(route2)
passenger1.assign_a_route(route1)

wagonpass1 = PassengerWagon.new(27)
puts "Вагон: #{wagonpass1}\n"
wagonpass1.fill
puts 'Вагон заполнен на 1'
# puts "Сейчас вагон: #{wagonpass1}\n"
add_size = rand(3..19).times { wagonpass1.fill }
puts "Вагон заполнен на #{add_size}"
# puts "Сейчас вагон: #{wagonpass1}\n"

wagonpass2 = PassengerWagon.new(25)
puts wagonpass2.place_count
wagonpass2.place_count = 0
puts wagonpass2.place_count

begin
  wagonpass2.clear
rescue RuntimeError => e
  puts "Возникла ошибка валидации: #{e}"
end
