=begin
Задание 5.
Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным. (
Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?)
Алгоритм опредления високосного года: www.adm.yar.ru
=end
year, month, day, sum_days = 0

puts "Ведите день месяца в формате ДД (1-31):"
loop do
  day = gets.chomp.to_f
  break if (1..31) === day  # проверяем на вхождение в массив
  puts "Данные не корректные, введите точный день месяца в границах от 1 до 31..."
end

puts "Введите месяц года в формате ММ (1-12):"
loop do
  month = gets.chomp.to_f
  break if (1..12) === month  # проверяем на вхождение в массив
  puts "Данные не корректные, введите точный месяц в границах от 1 до 12..."
end

puts "Введите год в формате ГГГГ"
loop do
  year = gets.chomp.to_f
  break if year > 0
  puts "Данные не корректные, введите точно год..."
end

month_arr = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
month_arr[1] = 29 if year % 4 == 0 && year % 100 !=0 || year % 400 == 0
# month_arr[1] = 29 if ((year % 4).zero? && year % 100 != 0 || (year % 400).zero?)

sum_days += month_arr.take(month - 1).sum   # month_arr[0...month-1].each{ |days| sum_days += days }
sum_days += day  # RubyMine глючит на методе += (undefined method `+' for nil:NilClass (NoMethodError))!!!

puts "#{day.to_i}.#{month.to_i}.#{year.to_i} is #{sum_days} day in year"