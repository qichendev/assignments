import java.util.Objects;

// Dog class
public class Dog {
    // name and age fields
    private String name;
    private Integer age;

    // constructor
    public Dog(String name, Integer age) {
        this.name = name;
        this.age = age;
    }

    // getters and setters
    public String getName() {
        return name;
    }

    // setName method
    public void setName(String name) {
        this.name = name;
    }

    // getAge method
    public Integer getAge() {
        return age;
    }

    // setAge method
    public void setAge(Integer age) {
        this.age = age;
    }

    // equals and hashcode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Dog dog = (Dog) o;
        return Objects.equals(name, dog.name) && Objects.equals(age, dog.age);
    }

    // hashCode method
    @Override
    public int hashCode() {
        return Objects.hash(name, age);
    }
}