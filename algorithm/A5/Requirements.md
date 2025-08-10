Objective:
Implement and apply key structural design patterns (Adapter, Composite, and Proxy) to solve practical problems.

Instructions:
Complete all tasks in Java.
Submit your code with appropriate comments for clarity.
Task Breakdown:
1. Implement the Adapter Pattern (8 points)
Create a program that adapts a legacy media player to work with a modern audio player interface.
Requirements:
Define a MediaPlayer interface with a method play(String audioType, String fileName).
Create a class LegacyMediaPlayer with a method playMedia(String fileName) for playing .mp3 files only.
Implement an adapter class MediaAdapter that allows MediaPlayer to use LegacyMediaPlayer.
Scoring:
(3 points) Correctly implements the MediaPlayer interface and the LegacyMediaPlayer class.
(3 points) Implements the MediaAdapter class to bridge the two.
(2 points) Demonstrates the Adapter Pattern in a java application (class with a main method) playing different audio file types.
2. Implement the Proxy Pattern (7 points)
Create a program that uses a proxy to control access to a file.
Requirements:
Define an interface File with a method display().
Create a class RealFile that implements File and simulates loading and displaying a file. (using system.out.printlns)
Implement a proxy class FileProxy that:
implements File 
Controls access to a RealFile. //where 50% of the time it throws a runtime exception saying you dont have access
Scoring:
(4 points) Correctly implements the RealFile and FileProxy classes.
(3 points) Demonstrates access control in the proxy.