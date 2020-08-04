#  3) Заполнить массив числами фибоначчи до 100

# 1 вариант
puts (1..10).inject([0, 1]) { |fibonacci| fibonacci << fibonacci.last(2).inject(:+) }  #  "<<" - "fibonacci.push"


# 2 вариант
# puts 10.times.each_with_object([0,1]) { |num, fibonacci| fibonacci << fibonacci[-2] + fibonacci[-1] }


# 3 вариант
# fibonacci_arr = [0, 1]

# fibonacci_number_1 = 1
# fibonacci_number_2 = 2

# while fibonacci_number_1 < 100
#  fibonacci_arr.push fibonacci_number_1
#  fibonacci_number_1, fibonacci_number_2 = fibonacci_number_2, fibonacci_number_1 + fibonacci_number_2
# end


# 4 вариант
# fibonacci_arr = [0, 1]                        # инициализацмя чисел фиббоначи

# while fibonacci_arr[-1] < 88                  # избавляемся от лишнего сложения для проверки условия задания))
#  fibonacci_arr.push(fibonacci_arr[-1] + fibonacci_arr[-2])
# end


# 4.1 (под)вариант
# fibonacci_arr = [0, 1]

# while fibonacci_number < 100                # полная, более очевидная версия предыдущего варианта
#   fibonacci_arr.push fibonacci_arr[-1] + fibonacci_arr[-2]
#   fibonacci_number = fibonacci_arr[-1] + fibonacci_arr[-2]
# end


# 5 вариант (с использованием until)
# fibonacci_arr = [0, 1]
# fibonacci_number = 1

# until fibonacci_number > 100 do
#   fibonacci_arr.push fibonacci_number
#   fibonacci_number = fibonacci_arr.last(2).reduce(:+)
# end


# 6 вариант (с использованием loop)
# fibonacci_arr = [0, 1]
# i = 2

# loop do
#  array = fibonacci_arr[i-1] + fibonacci_arr[i - 2]
#  break if array >= 100
#  fibonacci_arr.push array
#  i += 1
# end

# puts fibonacci_arr # для вариантов 2-6