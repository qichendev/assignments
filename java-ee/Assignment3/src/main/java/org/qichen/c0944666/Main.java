package org.qichen.c0944666;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.File;
import java.io.IOException;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();

            List<Person> persons = objectMapper.readValue(
                    new File("src/main/resources/person.json"),
                    new TypeReference<List<Person>>() {}
            );

            List<BlogPost> blogPosts = objectMapper.readValue(
                    new File("src/main/resources/blogPosts.json"),
                    new TypeReference<List<BlogPost>>() {}
            );

            Blog blog = new Blog(blogPosts, persons);
            System.out.println(blog.toString());

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
