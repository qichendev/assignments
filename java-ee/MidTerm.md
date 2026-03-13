Preliminary Classes

Write the following classes with the specified attributes, using Lombok for getters and constructors. Ensure all class members are private.

Class Pet

    String name
    Integer age
    String type

Class Person

    String name
    Integer age
    List<Pet> pets

Class Business

    String name
    String address
    Person owner
    String postalCode
    List<Person> customers

Questions
Q1 [4 Points]

Write a function that takes in a List<Business> and returns a List<Person> of all customers who have at least one pet of the same age as themselves and at least one other pet with a different age. Ensure to use Java Streams in your solution.

    -2 points if not solved with streams

Q2 [3 Points]

Write a function that takes in a List<Business> and returns a List<Person> of all owners who are customers of their own business (where business.customers contains business.owner). Ensure to use Java Streams in your solution.

    -2 points if not solved with streams

Q3 [3 Points]

Write a function that takes in a List<Business> and a String c that contains a single letter and returns a distinct List<Pet> that includes all pets from the customers of the businesses where the business name starts with specified letter in String c (passed as a parameter).

    -2 points if not solved with streams

Q4 [5 Points]

Write a function that takes in a List<Business> and returns a Map<Person, List<Business>> where the key is a customer and the value is a list of businesses where they are a customer. (You may assume each customer can be associated with multiple businesses.)

    -3 point if not solved with streams

Q5 [4 Points]

Write a recursive function power(int base, int exponent) that returns base raised to the power of exponent (e.g., power(3, 4) = 81). You may only use multiplication, no built-in math functions or operators for exponentiation.

    -2 points if not solved with recursion

Q6 [12 Points]

Write a set of unit tests to verify the functions for Q1 -> Q5. Include edge cases and different possible inputs. each test must contain valid assertions 