package org.qichen.c0944666;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;

import java.util.List;
import java.util.stream.Collectors;

@Getter
@ToString
@EqualsAndHashCode
public class Blog {
    private List<BlogPost> posts;
    private List<Person> contributors;

    public Blog(List<BlogPost> posts, List<Person> contributors) {
        this.posts = posts;
        this.contributors = contributors;
    }

    public List<String> getPostsByAuthorAge(Integer age) {
        return posts.stream()
                .filter(post -> contributors.stream()
                        .filter(person -> person.getId().equals(post.getAuthorId()))
                        .anyMatch(person -> person.getAge() != null && person.getAge().equals(age)))
                .map(BlogPost::getId)
                .collect(Collectors.toList());
    }
}
