// PersonTest class
import org.junit.jupiter.api.Test;
import java.util.Optional;
import static org.junit.jupiter.api.Assertions.*;

class PersonTest {
    // testPersonConstructorWithoutDog method
    @Test
    void testPersonConstructorWithoutDog() {
        Person person = new Person("John", 30);
        assertEquals("John", person.getName());
        assertEquals(30, person.getAge());
        assertFalse(person.getDog().isPresent());
    }

    // testPersonConstructorWithDog method
    @Test
    void testPersonConstructorWithDog() {
        Dog dog = new Dog("Buddy", 5);
        Person person = new Person("John", 30, dog);
        assertEquals("John", person.getName());
        assertEquals(30, person.getAge());
        assertTrue(person.getDog().isPresent());
        assertEquals(dog, person.getDog().get());
    }

    // testHasOldDogTrue method
    @Test
    void testHasOldDogTrue() {
        Dog oldDog = new Dog("Oldie", 10);
        Person person = new Person("John", 30, oldDog);
        assertTrue(person.hasOldDog());
    }

    // testHasOldDogFalseYoung method
    @Test
    void testHasOldDogFalseYoung() {
        Dog youngDog = new Dog("Puppy", 5);
        Person person = new Person("John", 30, youngDog);
        assertFalse(person.hasOldDog());
    }

    // testHasOldDogFalseNoDog method
    @Test
    void testHasOldDogFalseNoDog() {
        Person person = new Person("John", 30);
        assertFalse(person.hasOldDog());
    }

    // testChangeDogsNameSuccess method
    @Test
    void testChangeDogsNameSuccess() {
        Dog dog = new Dog("Buddy", 5);
        Person person = new Person("John", 30, dog);
        person.changeDogsName("Max");
        assertEquals("Max", dog.getName());
    }

    // testChangeDogsNameThrowsException method
    @Test
    void testChangeDogsNameThrowsException() {
        Person person = new Person("John", 30);
        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            person.changeDogsName("Max");
        });
        assertEquals("John does not own a dog!", exception.getMessage());
    }

    // testPersonEquals method
    @Test
    void testPersonEquals() {
        Dog dog1 = new Dog("Buddy", 5);
        Dog dog2 = new Dog("Buddy", 5);
        Person person1 = new Person("John", 30, dog1);
        Person person2 = new Person("John", 30, dog2);
        assertEquals(person1, person2);
    }
}
