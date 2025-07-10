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
            private string name;
            private string artistName;
            private string albumName;
            private int duration; //duration in seconds

            public Track(string name, string artistName, string albumName, int duration)
            {
                //TODO: Implement the Track constructor
            }

            /* setters below throw exceptions for invalid input. See document */
            public void SetName(string name) { throw new NullArgumentException()}
            public void SetArtistName(string artistName) { }
            public void SetAlbumName (string albumName) { }
            public void SetDuration (int duration) { }

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

            public int Size() { } //return size of list
            public bool IsEmpty() { } //return true if list is empty, false otherwise

            public DNode GetFirst() { } //return first node, or throws InvlaidOperationException if list is empty
            public DNode GetLast() { } //return last node, or throws InvlaidOperationException if list

            /* Return the node before node v. Throw ArgumentException if current node is header. */
            public DNode GetPrev(DNode v) { }
            /* Return the node before node v. Throw ArgumentException if current node is tail. */
            public DNode GetNext(DNode v) { }
            /*Insert the node z before node v. Throw ArgumentException if current node is header. */
            public void AddBefore(DNode v, DNode z) { }
            /*Insert the node z after node v. Throw ArgumentException if current node is tail. */
            public void AddAfter(DNode v, DNode z) { }
            /* Add node v at start of list */
            public void AddFirst(DNode v) { }
            /* Add node v at end of list */
            public void AddLast(DNode v) { }
            /* Removes node v from list */
            public void Remove(DNode v) { }
            /* returns true if node has a previous node, false otherwise */
            public bool HasPrev(DNode v) {}
            /* returns true if node has next node, false otherwise */
            public bool HasNext(DNode v) {}
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
            }

            public string GetName() { } //return playlist name
            public int GetCount() { } //return number of songs in album
            public void SetName(string name) { } //set name of playlist
            public void Add(Track t) { } //add song to start or end of playlist (you decide). Increase size by 1
            public void Remove(Track t) { } //remove Track t from the playlist. Decrease size by 1
            public void Next() { } //move forward one node/track
            public void Previous() { } //move forward one node/track
            public string ToString() { } //display the name and the artist of the curr Track
            public void Shuffle() {
                //This method is OPTIONAL.                    
            }
        }

        static void Main(string[] args)
        {
        }
    }
}
