# encoding: cp866

def mean(*numbers)
  summ = numbers.inject {|sum, i| sum + i}
  summ / numbers.size
end

puts 'mean 22, 33, 44, 55'

puts 'def mean(*numbers)'
puts	'sum = numbers.inject {|sum, i| sum + i}'
puts	'sum / numbers.size'
puts 'end'


puts 'Result: ' "#{mean 22, 33, 44, 55}"