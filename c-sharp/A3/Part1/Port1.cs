using System;
using System.CodeDom;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Runtime.Remoting.Services;
using System.Text;
using System.Threading.Tasks;

namespace Part01
{
    internal class Program
    {
        public class Track
        {
            private void CheckStringSetter(string value, string fieldName)
            {
                if (value == null || value == "")
                {
                    throw new ArgumentException(fieldName + " cannot be null or empty");
                }
            }
            public string Name { get; set {
                CheckStringSetter(value, "Name");
                field = value;
            } }
            public string Artist { get; set {
                CheckStringSetter(value, "Artist");
                field = value;
            } }
            public string AlbumName { get; set {
                CheckStringSetter(value, "AlbumName");
                field = value;
            } }
            public int DurationSeconds { get; set {
                CheckIntSetter(value, "DurationSeconds");
                if (value < 1)
                {
                    throw new ArgumentException("DurationSeconds cannot be negative");
                }
                field = value;
            } }
            public Track(string name, string artist, string albumName, int durationSeconds)
            {
                Name = name;
                Artist = artist;
                AlbumName = albumName;
                DurationSeconds = durationSeconds;
            }
        }

        //DNode represents a node for DoublyLinkedList 
        //it has been completed for you and you do not need to touch it
        public class DNode
        {
            protected Track song; //each node holds a song
            protected DNode next, prev; //pointers to next and prev nodes

            //Constructor that creates a node
            public DNode(Track t, DNode p, DNode n)
            {
                song = t;
                next = n;
                prev = p;
            }

            public Track GetTrack() {  return song; }
            public DNode GetPrev() { return prev; }
            public DNode GetNext() { return next; }
            public void SetTrack(Track t) { song = t; }
            public void SetPrev(DNode p) { prev = p; }
            public void SetNext(DNode n) { next = n; }

        }

        public class DoublyLinkedList
        {
            protected int size;
            protected DNode header, tail;

            public DoublyLinkedList()
            {
                size = 0; //initial size of list 
                header = new DNode(null, null, null); //header points to null
                tail = new DNode(null, header, null); //tail's prev node is header (null)
                header.SetNext(tail); //header's next points to to tail
            }

            public int Size() { 
                return size;
            } //return size of list
            public bool IsEmpty() { 
                return size == 0;
            } //return true if list is empty, false otherwise

            public DNode GetFirst() { 
                if (IsEmpty())
                {
                    throw new InvalidOperationException("List is empty");
                }
                return header;
            } //return first node, or throws InvlaidOperationException if list is empty
            public DNode GetLast() { 
                if (IsEmpty())
                {
                    throw new InvalidOperationException("List is empty");
                }
                return tail;
            } //return last node, or throws InvlaidOperationException if list

            /* Return the node before node v. Throw ArgumentException if current node is header. */
            public DNode GetPrev(DNode v) { 
                if (v == header)
                {
                    throw new ArgumentException("Current node is header");
                }
                return v.GetPrev();
            }
            /* Return the node before node v. Throw ArgumentException if current node is tail. */
            public DNode GetNext(DNode v) { 
                if (v == tail)
                {
                    throw new ArgumentException("Current node is tail");
                }
                return v.GetNext();
            }
            /*Insert the node z before node v. Throw ArgumentException if current node is header. */
            public void AddBefore(DNode v, DNode z) {
                if (v == header)
                {
                    throw new ArgumentException("Current node is header");
                }
                z.SetNext(v);
                z.SetPrev(v.GetPrev());
                v.GetPrev().SetNext(z);
            }
            /*Insert the node z after node v. Throw ArgumentException if current node is tail. */
            public void AddAfter(DNode v, DNode z) {
                if (v == tail)
                {
                    throw new ArgumentException("Current node is tail");
                }
                z.SetNext(v.GetNext());
                z.SetPrev(v);
                v.GetNext().SetPrev(z);
            }
            /* Add node v at start of list */
            public void AddFirst(DNode v) {
                AddBefore(header, v);
                size++;
                header = v;
            }
            /* Add node v at end of list */
            public void AddLast(DNode v) {
                AddAfter(tail, v);
                size++;
                tail = v;
            }
            /* Removes node v from list */
            public void Remove(DNode v) {
                if (v == header || v == tail)
                {
                    throw new ArgumentException("Current node is header or tail");
                }
                v.GetPrev().SetNext(v.GetNext());
            }
            /* returns true if node has a previous node, false otherwise */
            public bool HasPrev(DNode v) {
                return v != header;
            }
            /* returns true if node has next node, false otherwise */
            public bool HasNext(DNode v) {
                return v != tail;
            }
        }

        public class Playlist
        {
            private string name;
            private int count;
            private DoublyLinkedList songs;
            private DNode curr; //current playlist position
            public Playlist(string name)
            {
                //TODO: set album name and initial number of songs to 0
                //initialize songs to empty playlist of songs
                //set curr position to head
                this.name = name;
                count = 0;
                songs = new DoublyLinkedList();
                curr = songs.GetFirst();
            }

            public string GetName() { 
                return name;
            } //return playlist name
            public int GetCount() { 
                return count;
            } //return number of songs in album
            public void SetName(string name) { 
                this.name = name;
            } //set name of playlist
            public void Add(Track t) { 
                songs.AddFirst(t);
                count++;
                curr = songs.GetFirst();
            } //add song to start or end of playlist (you decide). Increase size by 1
            public void Remove(Track t) { 
                songs.Remove(t);
                count--;
            } //remove Track t from the playlist. Decrease size by 1
            public void Next() { 
                if (songs.HasNext(curr))
                {
                    curr = songs.GetNext(curr);
                }
            } //move forward one node/track
            public string ToString() { 
                return curr.GetTrack().ToString();
            } //display the name and the artist of the curr Track
            public void Shuffle() {
                Random random = new Random();
                int randomIndex = random.Next(0, count);
                curr = songs.GetFirst();
                for (int i = 0; i < randomIndex; i++)
                {
                    curr = songs.GetNext(curr);
                }
                //This method is OPTIONAL.                    
            }
        }

        static void Main(string[] args)
        {
            Playlist playlist = new Playlist("My Playlist");
            Track track1 = new Track("Song 1", "Artist 1", "Album 1", 180);
            Track track2 = new Track("Song 2", "Artist 2", "Album 2", 240);
            Track track3 = new Track("Song 3", "Artist 3", "Album 3", 300);
            playlist.Add(track1);
            playlist.Add(track2);
            playlist.Add(track3);
            Console.WriteLine(playlist.ToString());
            
        }
    }
}
