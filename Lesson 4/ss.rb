require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'train_passenger'
require_relative 'train_cargo'
require_relative 'wagon'
require_relative 'wagon_passenger'
require_relative 'wagon_cargo'
require_relative 'menu'

st1 = Station.new('Moscow')
st2 = Station.new('Dnepr')
st3 = Station.new('Lvov')
st4 = Station.new('Kazan')
st5 = Station.new('Vladimir')
st6 = Station.new('Kiev')
st7 = Station.new('Minsk')

rt1 = Route.new(st1, st2)
rt1.add_station(st3)
rt1.add_station(st4)
rt1.add_station(st5)
puts rt1.name