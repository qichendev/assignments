import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class DogTest {
    // testDogConstructorAndGetters method
    @Test
    void testDogConstructorAndGetters() {
        Dog dog = new Dog("Buddy", 5);
        assertEquals("Buddy", dog.getName());
        assertEquals(5, dog.getAge());
    }

    // testDogSetters method
    @Test
    void testDogSetters() {
        Dog dog = new Dog("Buddy", 5);
        dog.setName("Max");
        dog.setAge(7);
        assertEquals("Max", dog.getName());
        assertEquals(7, dog.getAge());
    }

    // testDogEquals method
    @Test
    void testDogEquals() {
        Dog dog1 = new Dog("Buddy", 5);
        Dog dog2 = new Dog("Buddy", 5);
        Dog dog3 = new Dog("Max", 5);
        assertEquals(dog1, dog2);
        assertNotEquals(dog1, dog3);
    }
}
