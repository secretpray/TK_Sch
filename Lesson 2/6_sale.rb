=begin
Задание 6. Сумма покупок.
Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара (может быть нецелым числом).
Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве названия товара.
На основе введенных данных требуетеся: Заполнить и вывести на экран хеш, ключами которого являются названия товаров,
а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара.
Также вывести итоговую сумму за каждый товар.
Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".
=end

shop_cart = {}
total_price = 0
delimiter = "-*-" * 15 # для красоты

# Получаем данные от пользователя

puts delimiter

loop do
  puts "Введите название товара или stop (стоп) для выхода."
  item_name = gets.force_encoding(Encoding::UTF_8).chomp
  break if item_name == 'stop' || item_name == 'стоп'
  puts "Введите цену товара (за единицу или 100 грамм):"
  item_price = gets.to_f
  puts "Введите количество товара (шт или грамм):"
  item_quantity = gets.to_f
  shop_cart[item_name] = { item_price: item_price, item_quantity: item_quantity, item_amount: item_price * item_quantity }
  puts "Добавлен продукт: #{item_name.downcase} ценой #{item_price} грн в количестве #{item_quantity.to_i}"
  total_price += item_price * item_quantity
end

# Если вне цикла надо подсчитать общую стоимость покупок:
# total_price = shop_cart.sum {|item_price:, item_quantity:, item_amount:| item_amount } # deprecated in Ruby 2.7
# shop_cart.each { |item, data| total_price += data[:item_amount] } # рабочее решение (.each_pair) !

# Покажем хеш
p shop_cart

p delimiter

# Покажем корзину с расшифровкой
shop_cart.each do |item_name, data|
   puts "- #{item_name.downcase}: #{data[:item_price].to_s} x #{data[:item_quantity]} = #{data[:item_amount]} грн."
#   total_price += data[:item_amount] # в данному случае лишняя операция
 end

puts delimiter

# Покажем общую сумму
puts "Общая сумма покупок: #{total_price}"

# To Do
# 1) Добавить красивое псевдо-меню для выбора опций (Добавить, Обновить, Удалить, Выход)
# 2) Проверить на корретность вводимых данных (Строки вместо цифр в цене и количестве товара)
# 3) Предусмотреть возможность обновления и удаления товара с идентичным именем.
# 4) С дробными цифрами (грамм) надо рахобраться
# 5) Как пересчитать граммы - килограммы