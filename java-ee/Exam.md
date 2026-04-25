Create a spring application that...

[3] Q1 (constructors and setters/getters/equals should be created with lombok)

Create a Class User with the following attributes and validation annotations
String name // 2<=name<=40 (length)
Integer age // min(18)
Occupation occupation

Create a Class Occupation with the following attributes
String title
Integer salary // min(1)

[10] Q2

Create a class UserCache that..
- stores a List of Users

- has a method to fetch all users with atleast n salary and under y age (using streams)

- has a method that fetches the Occupation with the largest salary (using streams)
- has a method to fetch all users
- has a method to add a user

[6] Q3

Create a Controller MainController that
- has a UserCache class injected into it
- has a mapping for "/users" that returns a 'users' template and attaches all users to the model

Create a Controller UserRestController that
- has a UserCache class injected into it
- has a mapping for "/mostpaid" that returns the Occupation with the highest salary

[10] Q4

in [MainController] Create a path get "/create" that returns a template with a form to create a User
-Create a template using thymeleaf that is an html5 form to create a User (and their occupation) and submits a post to "/create"
- form should display validation errors if any
in [MainController] Create a path post "/create" that saves a User (to UserCache) if it passes validation or returns back the original form if there are errors

[5] Q5

Create a template users.html that
- displays all users and their age and salaries in an HTML table using thymeleaf

=== Create a new class named ExamQuestions that has the following static method ===

[4] Q6

create a recursive function that takes in a string, count total number of consonants in it. A consonant is an English alphabet character that is not vowel (a, e, i, o and u). Examples of consonant are b, c, d, f, and g. 

Example

Input : food
Output : 2

Note - [-3] points for using a loop on this question

[8] Write a unit test for Q3&4 (unit test must validate the /users method that it attaches the correct objects to the model and returns the correct template, should use mocks)
[4] Write a unit test for Q6 (recursive question)

[6] Write a unit test for Q2