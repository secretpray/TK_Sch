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
delimiter = "-*-" * 20 # для красоты

# Получаем данные от пользователя

puts delimiter

loop do
  puts "Введите название товара или stop для выхода."
  item_name = gets.force_encoding(Encoding::UTF_8).chomp
  break if item_name == 'stop'
  puts "Введите цену товара (за единицу или 100 грамм):"
  item_price = gets.to_f
  puts "Введите количество товара (шт или грамм):"
  item_quantity = gets.to_f
  shop_cart[item_name] = { item_price: item_price, item_quantity: item_quantity, item_amount: item_price * item_quantity }
  puts "Добавлен продукт: #{item_name.downcase} ценой #{item_price} в количестве #{item_quantity.to_i} "
end

# total_price = shop_cart.sum {|item_price:, item_quantity:, item_amount:| item_amount } # deprecated in Ruby 2.7

# покажем весь хеш
p shop_cart

p delimiter

# Покажем корзину с расшифровкой
shop_cart.each do |item_name, data|
  puts "- #{item_name}: #{data[:item_price].to_s} x #{data[:item_quantity]} = #{data[:item_amount]} грн."
  total_price += data[:item_amount]
end

puts delimiter

# Покажем общую сумму
puts "Общая сумма покупок: #{total_price}"

# To Do
# 1) Добавить красивое псевдо-меню для выбора опций
# 2) Проверить на корретность вводимых данных
# 3) Предусмотреть возможность обновления (добавления) товара с идентичным именем.