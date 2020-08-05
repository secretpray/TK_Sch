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
loop do
  puts "Введите название товара или stop для выхода."
  item_name = gets.force_encoding(Encoding::UTF_8).chomp
  break if item_name == 'stop'
  puts "Введите цену товара (за единицу или 100 грамм):"
  item_price = gets.to_f
  puts "Введите количество товара (шт или грамм):"
  item_quantity = gets.to_f
  shop_cart[item_name] = { item_price: item_price, item_quantity: item_quantity, item_amount: item_price * item_quantity }
end

total_price = shop_cart.sum{ |item_price:, item_quantity:, item_amount:| item_amount }

=begin
shop_cart.each do |item_name, item_sub|
  sum = item_sub[:item_price] * item_sub[:item_quantity]
  puts "товар: #{item_name}, куплен по цене - #{sum} грн."
  total_price += sum
end
=end

puts "Общая сумма покупок: #{total_price}"
