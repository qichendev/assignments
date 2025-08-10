// adapter pattern test
public class MediaAdapterTest {
    public static void main(String[] args) {
        MediaPlayer mediaPlayer = new MediaAdapter("mp3");
        mediaPlayer.play("mp3", "song.mp3");
        mediaPlayer.play("mp4", "movie.mp4");
    }
}