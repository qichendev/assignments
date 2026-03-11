[3] Create a Class Person that...

- has the following variables 

  String id

  String firstName

  String lastName

  Integer age

  String gender

- has getter(s)/toString/equals

- contains a private builder as taught in class

- has a builder that calls the private constructor (Use @Builder)

- uses @Jacksonized on the builder for deserialization

- constructor should have the following validation (throw an error if conditions aren’t met)

  id cannot be null

  first and last name cannot be null or blank (empty string)

  age must be >= 0

[2] Create a Class BlogPosts that...

- has the following variables

  String id

  String authorId //This is equal to personId

  String postContent

- has getter(s)/toString/equals

- contains a private builder as taught in class

- has a builder that calls the private constructor (Use @Builder)

- uses @Jacksonized on the builder for deserialization

- constructor should have the following validation (throw an error if conditions aren’t met)

  id cannot be null

  authorId cannot be null

[1] Create a class Blog that...

- has the following variables

  List<BlogPost> posts

  List<Person> contributors

- has getter(s)/toString/equals

[5] add a method to the class Blog named getPostsByAuthorAge that..

- takes in Integer age

- returns all the BlogPost id's that have an author whose age is equal to input "age"

(must use streams)

  

[3] create a class with a main method that when ran reads the person.json and blogPosts.json into Lists of Person, and List of BlogPosts, then creates an instance of Blog, then outputs blog.toString() to the console (system.out.println)

[6] Write the following Unit Tests

  Person

    - building a person with null id should throw exception

    - building a person with null or blank names should throw exception

    - building a person with a negative age should throw an exception

    - person should be able to be build with valid arguments, and values tests using the getters 

  BlogPost

    - building a BlogPost with null id should throw exception

    - building a BlogPost with null authorId should throw exception

    - BlogPost should be able to be build with valid arguments, and values tests using the getters 

  Blog

    - Write unit tests for getPostsByAuthorAge 