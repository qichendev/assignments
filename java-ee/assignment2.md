Assignment 2 [20 points]

-1 point if you don’t use streams for each of these methods (Applies for all assignment questions)

[2] Create a method that takes in a list of Integers and returns largest number in the list

[1] Create a unit test to test this method

[2] Create a method that takes in a list of integers, and a Integer value n and returns a list containing elements from the original list that are greater than the value n
[1] Create a unit test to test this method

[5] Create a method that takes in a list of Integers, and returns a list of strings where the string is

“fizz” - if the number is divisible by 2

“buzz” - if the number is divisible by 5

“fizzbuzz” - if the number is divisible by both 2 and 5

number casted to a string - if not divisible by 2 or 5

example input

[1,2,3,4,5,6,7,8,9,10]

example return

[“1”, “fizz”, “3”, “fizz”, “buzz”, “fizz”, “7”, “fizz”, “9”, “fizz buzz”]

[1] Create a unit test to test this method

[2] Create a method that takes in a Map<String, Integer> and a Integer n, and returns true/false if the map contains a value that is less than n (hint you may want to use .values() on the map)

[1] Create a unit test to test this method

[4] Create a method that takes in a list of integers and an Integer n, and return a list consisting of the largest n elements in the given list

(hint, may need to use Sort(Comparator c) and Limit)

[1] Create a unit test to test this method

given inputs
list -> [1,2,3,4,5,6,7,8,9,10] 
n -> 3

should output
[10, 8, 9] (any order)