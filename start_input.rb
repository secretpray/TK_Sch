puts "\nHello, system: " + `ruby -v`

puts 'Input you name:'
name = gets.chomp

puts 'В каком году ты родился?'
year = gets.chomp

if name.size != 0
  puts "#{name}, привет!"
else
  puts 'Привет, незнакомец!'
end

if year.size != 0
  puts "Тебе примерно #{2020 - year.to_i} лет (год)" if year.to_i < 2020 && (2020 - year.to_i) < 150
  puts 'З возрастом шутки плохи.' if year.to_i > 2020 || (2020 - year.to_i) > 150
else
  puts 'Даже предстваить себе не могу сколько тебе лет.'
end