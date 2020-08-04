#  3) Заполнить массив числами фибоначчи до 100

# 1 вариант
puts (1..10).inject([0, 1]) { |fibonacci| fibonacci << fibonacci.last(2).inject(:+) }

# 2 вариант
# puts 10.times.each_with_object([0,1]) { |num, fibonacci| fibonacci << fibonacci[-2] + fibonacci[-1] }

# 3 вариант
# fibonacci_arr = [0, 1]                        # инициализацмя чисел фиббоначи

# while fibonacci_arr[-1] < 88                  # избавляемся от лишнего сложения для проверки условия задания))
#  fibonacci_arr.push(fibonacci_arr[-1] + fibonacci_arr[-2])
# end

# puts fibonacci_arr

# 3.1 (под)вариант
# fibonacci_arr = [0, 1]

# while fibonacci_number < 100                # полная, более очевидная версия предыдущего варианта
#   fibonacci_arr << fibonacci_arr[-1] + fibonacci_arr[-2]
#   fibonacci_number = fibonacci_arr[-1] + fibonacci_arr[-2]
# end

# puts fibonacci_arr

# 4 вариант (с использованием until)
# fibonacci_arr = [0, 1]
# fibonacci_ = 1

# until fibonacci_number > 100 do
#   fibonacci_arr << fibonacci_number
#   fibonacci_number = fibonacci_arr.last(2).reduce(:+)
# end

# puts fibonacci_arr

