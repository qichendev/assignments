package org.qichen.c0944666;

import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class BlogTest {

    @Test
    void getPostsByAuthorAgeShouldReturnPostIdsWhenAgeMatches() {
        Person person1 = Person.builder().id("1").firstName("John").lastName("Doe").age(25).build();
        Person person2 = Person.builder().id("2").firstName("Jane").lastName("Smith").age(30).build();

        BlogPost post1 = BlogPost.builder().id("101").authorId("1").postContent("Post by John").build();
        BlogPost post2 = BlogPost.builder().id("102").authorId("2").postContent("Post by Jane").build();
        BlogPost post3 = BlogPost.builder().id("103").authorId("1").postContent("Another post by John").build();

        List<Person> contributors = Arrays.asList(person1, person2);
        List<BlogPost> posts = Arrays.asList(post1, post2, post3);

        Blog blog = new Blog(posts, contributors);

        List<String> result = blog.getPostsByAuthorAge(25);

        assertEquals(2, result.size());
        assertTrue(result.contains("101"));
        assertTrue(result.contains("103"));
    }

    @Test
    void getPostsByAuthorAgeShouldReturnEmptyListWhenNoMatch() {
        Person person1 = Person.builder().id("1").firstName("John").lastName("Doe").age(25).build();

        BlogPost post1 = BlogPost.builder().id("101").authorId("1").postContent("Post by John").build();

        List<Person> contributors = Collections.singletonList(person1);
        List<BlogPost> posts = Collections.singletonList(post1);

        Blog blog = new Blog(posts, contributors);

        List<String> result = blog.getPostsByAuthorAge(40);

        assertTrue(result.isEmpty());
    }

    @Test
    void getPostsByAuthorAgeShouldReturnEmptyListWhenNoContributors() {
        BlogPost post1 = BlogPost.builder().id("101").authorId("1").postContent("Post").build();

        Blog blog = new Blog(Collections.singletonList(post1), Collections.emptyList());

        List<String> result = blog.getPostsByAuthorAge(25);

        assertTrue(result.isEmpty());
    }

    @Test
    void getPostsByAuthorAgeShouldReturnEmptyListWhenNoPosts() {
        Person person1 = Person.builder().id("1").firstName("John").lastName("Doe").age(25).build();

        Blog blog = new Blog(Collections.emptyList(), Collections.singletonList(person1));

        List<String> result = blog.getPostsByAuthorAge(25);

        assertTrue(result.isEmpty());
    }

    @Test
    void getPostsByAuthorAgeShouldHandleNullAgeInPerson() {
        Person person1 = Person.builder().id("1").firstName("John").lastName("Doe").build(); // null age

        BlogPost post1 = BlogPost.builder().id("101").authorId("1").postContent("Post by John").build();

        Blog blog = new Blog(Collections.singletonList(post1), Collections.singletonList(person1));

        List<String> result = blog.getPostsByAuthorAge(25);

        assertTrue(result.isEmpty());
    }
}
