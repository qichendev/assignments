// adapter pattern
public class MediaAdapter implements MediaPlayer {
    private LegacyMediaPlayer legacyMediaPlayer;

    public MediaAdapter(String fileName) {
        legacyMediaPlayer = new LegacyMediaPlayer();
    }

    @Override
    public void play(String audioType, String fileName) {
        switch (audioType) {
            case "mp3":
                legacyMediaPlayer.playMedia(fileName);
                break;
            default:
                System.out.println("Invalid media. " + audioType + " format not supported");
        }
    }
}