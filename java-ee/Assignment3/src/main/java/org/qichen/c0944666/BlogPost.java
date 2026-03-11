package org.qichen.c0944666;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
@EqualsAndHashCode
@JsonIgnoreProperties(ignoreUnknown = true)
@Builder
public class BlogPost {
    private String id;
    private String authorId;
    private String postContent;

    private BlogPost(String id, String authorId, String postContent) {
        if (id == null) {
            throw new IllegalArgumentException("id cannot be null");
        }
        if (authorId == null) {
            throw new IllegalArgumentException("authorId cannot be null");
        }
        this.id = id;
        this.authorId = authorId;
        this.postContent = postContent;
    }
}
