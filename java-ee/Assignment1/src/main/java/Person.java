import java.util.Objects;
import java.util.Optional;

// Person class
public class Person {
    // name, age, and dog fields
    private String name;
    private Integer age;
    private Optional<Dog> dog;

    // constructor
    public Person(String name, Integer age) {
        this(name, age, null);
    }

    // constructor
    public Person(String name, Integer age, Dog dog) {
        this.name = name;
        this.age = age;
        this.dog = Optional.ofNullable(dog);
    }

    // getters and setters
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public Optional<Dog> getDog() {
        return dog;
    }

    public void setDog(Optional<Dog> dog) {
        this.dog = dog;
    }

    // hasOldDog method
    public boolean hasOldDog() {
        return dog.filter(d -> d.getAge() >= 10).isPresent();
    }

    // changeDogsName method
    public void changeDogsName(String newName) {
        dog.ifPresentOrElse(
                d -> d.setName(newName),
                () -> { throw new RuntimeException(this.name + " does not own a dog!"); }
        );
    }

    // equals and hashcode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Person person = (Person) o;
        return Objects.equals(name, person.name) &&
                Objects.equals(age, person.age) &&
                Objects.equals(dog, person.dog);
    }

    // hashCode method
    @Override
    public int hashCode() {
        return Objects.hash(name, age, dog);
    }
}
