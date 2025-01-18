# Question 1

Write a program that computes the value of a bag of coins. Assume coins are the currently circulated set of Canadian coins: nickels, dimes, quarters, loonies, toonies. The program takes the number of each type of coin as input.
  
The output should be similar to:
  
- Nickles Total: $0.85
- Dimes Total: $0.90
- Quarters Total: $7.25
- Loonies Total: $12
- Toonies Total: $36
- All Coins Total: $57.00
  
## Answer
```python
def hello_world():
  print("Hello, World!")
```

```pseudo
This script will retrieve a list of subdirectories from the target 
directory and list the number of items in each subdirectory.

SET target = target directory
SET dir_list as empty list

FOR each item in target
 SET full_path = target + item
 IF full_path is directory
  SET size = number of children in full_path
  IF size = 0	
   APPEND full_list with "<item> contains no items."
  ELSE IF size = 1
   APPEND full_list with "<item>: <size> item."
  ELSE
   APPEND full_list with "<item>: <size> items."
  ENDIF
 ENDIF
ENDFOR

SORT full_list
PRINT full_list with line breaks
```

```text
Algorithm Example
1. Start
2. Input x
3. If x > 0 then
   a. Print "Positive"
4. Else
   a. Print "Negative or Zero"
5. End

```text
ALGORITHM Search
1. START
2. INPUT array, key
3. FOR each element in array DO
   a. IF element == key THEN
      i. OUTPUT "Key found"
      ii. EXIT
4. END FOR
5. OUTPUT "Key not found"
6. END
