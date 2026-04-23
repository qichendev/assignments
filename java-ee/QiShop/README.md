# QiShop

Student ID: c0944666

QiShop is a shopping themed Spring MVC application for creating and browsing product listings.

## Assignment Instructions

Instructions
Student ID: c0944666

This project is intentionally made vague to allow for creative implementations.
It's only requirements are to make sure your project has the following features/implementations

- Student ID c0944666 ends with 6, so the project must be shopping themed.

- Must be a spring MVC application

- A page with a form where users have to input information
- must have atleast 3 fields for the user to fill out [3]

- form must be validated on the server side (for every field) [4]
- contents from the form should be persisted if it passes validation (saved into a database) [4]
- A page that users can go to that lists the items created from the form in requirement 1 using Templates/Thymeleaf [6]
- must take an optional get params to filter the list by attributes (users can input variable amounts, between 0 filters and atleast up to 2 filters)  [8]
- There must be an API that returns the number of page hits since the server was online
- This api should be called asynchronously every 3 seconds and the results displayed on every page [7]
- There must be at-least 1 dependency injected into two different locations in the project [4]
- use of lombok in data classes [3]
- Aesthetically pleasing website (e.x using css or frameworks) (10 points)

Additionally

- Classes should have unit tests [14]

- Include a README (textfile) in the base of your project, with this files contents in it, and added notes of which classes/files contain each requirement, you will lose 10 marks for not completing the README

Bonus

implement 2 spring or java library not covered in class [bonus of up to 5 marks each]

Must include a write up of the library of why you chose to learn it and what it does in the README

## Requirement Mapping

- Shopping theme: `templates/products.html`, `templates/product-form.html`, `model/Product.java`.
- Spring MVC application: `QiShopApplication.java`, `controller/ProductController.java`, Thymeleaf views.
- Form page with at least 3 fields: `templates/product-form.html` has name, category, price, stock quantity, and description.
- Server-side validation for every field: validation annotations in `model/Product.java`; enforced in `ProductController#createProduct`.
- Persist valid form contents: `ProductService#save` uses `ProductRepository`, backed by H2 through Spring Data JPA.
- List created items with Thymeleaf: `templates/products.html`.
- Optional GET filters: `/products` accepts `search`, `category`, and `maxPrice` in `ProductController#listProducts`.
- Page hit API: `HitCounterController` exposes `/api/hits`.
- Asynchronous hit counter update every 3 seconds: `static/js/hits.js`, included by both Thymeleaf pages.
- Dependency injection into two locations: `HitCounterService` is injected into `HitCounterController` and `PageHitInterceptor`; `ProductService` is injected into `ProductController` and `SampleDataLoader`.
- Lombok in data classes: `Product.java` uses `@Data`, `@Builder`, `@NoArgsConstructor`, and `@AllArgsConstructor`.
- Aesthetically pleasing website: `static/css/styles.css`.
- Unit tests: `HitCounterServiceTest`, `ProductServiceTest`, and `ProductControllerTest`.

## Bonus Libraries

Spring Data JPA was chosen because it removes a lot of repetitive database code while still keeping the application structured. It provides `JpaRepository` for common persistence operations and `JpaSpecificationExecutor` for flexible filtering by search text, category, and price.

H2 Database was chosen because it is lightweight and easy to run for assignments. It provides an in-memory SQL database, so the project can save products during runtime without requiring an external database server.

## Run

```bash
mvn spring-boot:run
```

Open `http://localhost:8080/products`.

## Test

```bash
mvn test
```
