# Задание 2. Заполнить массив числами от 10 до 100 с шагом 5

# вариант 1
numbers_array = (10..100).step(5).to_a

# вариант 2
# numbers_array = (10..100).select {|num| num % 5 == 0 } #  и без ".to_a" будет массив

# вариант 3
# numbers_array = [] # либо как экземпляр класса: numbers_array = Array.new
# 10.step(100, 5) { |num| numbers_array.push num } # ругают за <<

# вариант 4
# numbers_array = []
# 10.upto(100) { |num| numbers_array.push num if num % 5 == 0 } # ругают за <<

p numbers_array