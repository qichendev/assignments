package org.qichen.c0944666;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class BlogPostTest {

    @Test
    void buildingBlogPostWithNullIdShouldThrowException() {
        assertThrows(IllegalArgumentException.class, () ->
            BlogPost.builder()
                .id(null)
                .authorId("1")
                .postContent("Some content")
                .build()
        );
    }

    @Test
    void buildingBlogPostWithNullAuthorIdShouldThrowException() {
        assertThrows(IllegalArgumentException.class, () ->
            BlogPost.builder()
                .id("1")
                .authorId(null)
                .postContent("Some content")
                .build()
        );
    }

    @Test
    void blogPostShouldBeBuiltWithValidArguments() {
        BlogPost blogPost = BlogPost.builder()
                .id("101")
                .authorId("1")
                .postContent("Hello World")
                .build();

        assertEquals("101", blogPost.getId());
        assertEquals("1", blogPost.getAuthorId());
        assertEquals("Hello World", blogPost.getPostContent());
    }

    @Test
    void blogPostShouldBeBuiltWithNullPostContent() {
        BlogPost blogPost = BlogPost.builder()
                .id("101")
                .authorId("1")
                .build();

        assertEquals("101", blogPost.getId());
        assertEquals("1", blogPost.getAuthorId());
        assertNull(blogPost.getPostContent());
    }
}
