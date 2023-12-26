require 'pry'
require 'pry-byebug'

def double_num(num)
  num + 2
end

# Re-written code so that `step` works. 
# def double_evens(arr)
#   arr.map do |num|
#     is_even = num.even?
#     binding.pry
#     new_num = is_even ? double_num(num) : num 
#   end
# end

# def double_evens(arr)
#   arr.map do |num|
#     binding.pry
#     new_num = num.even? ? double_num(num) : num 
#   end
# end

# p double_evens([1, 2, 3, 4, 5]) == [1, 4, 3, 8, 5]




# require 'pry'
# require 'pry-byebug'

# =begin 
# Write a method that takes as an argument an array of integers and returns 
# a new array with the integers transformed. IF the integer is divisible
# by 3 it should be replaced with 'Fizz', if divisible by 5 it should be 
# replaces with 'Buzz', if divisible by both 3 and 5 it should be replace with 
# 'FizzBuzz', if divisible by neither 3 or 5 the number should remain as it is. 

# =end

# def fizzbuzz(arr)
#   arr.map do |num|
#     # binding.pry
#     if num % 5 == 0 && num % 3 == 0
#       'FizzBuzz'
#     elsif num % 5 == 0 
#       'Buzz'
#     elsif num % 3 == 0 
#       'Fizz'
#     else 
#       num
#     end
#   end
# end

# p fizzbuzz([1, 3, 5, 6, 7, 8, 10, 3, 15, 9]) == [1, 'Fizz', 'Buzz', 'Fizz', 7, 8, 'Buzz', 'Fizz', 'FizzBuzz', 'Fizz']




=begin 
Write a method that given an array of integers, returns a new array containing 
only odd numbers that are less than or equal to 15 or multiples of 3 
=end

# require 'pry'

# def select_nums(arr)
#   new_arr = []
#   arr.each do |num|
#     # binding.pry
#     new_arr << num if num.odd? && (num <= 15 || num % 3 == 0) 
#   end
#   new_arr
# end

# p select_nums([1, 2, 5, 6, 9, 12, 15, 17, 19, 21]) == [1, 5, 9, 15, 21]
# p select_nums([6, 12, 18]) == []
# p select_nums([3, 5, 7, 11, 15, 21]) == [3, 5, 7, 11, 15, 21]





# require 'pry'

# a = 0
# b = 0 

# loop do 
# 	a += 1
# 	binding.pry 
# 	b += 1
# 	break if b >= 3
# end 





# require 'pry'

# def double_num(num)
#   num * 2
# end

# arr = [1, 2, 3].map do |num|
#   double_num(num)
#   binding.pry
# end

# p arr




=begin
Given this data structure write some code to return an array containing 
the colors of the fruits, and the sizes of the vegetables. 
The sizes should be uppercase and the colors should be capitalized.

hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

The return value should look like this:
[["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]


P:
given a hash of fruits/veg their colors and sizes return an array contianing 
the colors of the fruit capitalized and the sizes uppercased 


=end

hsh.map do |k, v|
  

end 




hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}
size_color(hsh)