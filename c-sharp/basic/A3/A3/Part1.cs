using System;
using System.Collections.Generic;
using System.Linq;

namespace A3
{
    // Track class
    public class Track
    {
        private string name;
        private string artist;
        private string albumName;
        private int durationSeconds;

        private void CheckStringSetter(string value, string fieldName)
        {
            if (string.IsNullOrEmpty(value))
            {
                throw new ArgumentException(fieldName + " cannot be null or empty");
            }
        }

        private void CheckIntSetter(int value, string fieldName)
        {
            if (value < 1)
            {
                throw new ArgumentException(fieldName + " cannot be less than 1");
            }
        }

        public string Name
        {
            get { return name; }
            set
            {
                CheckStringSetter(value, "Name");
                name = value;
            }
        }
        public string Artist
        {
            get { return artist; }
            set
            {
                CheckStringSetter(value, "Artist");
                artist = value;
            }
        }
        public string AlbumName
        {
            get { return albumName; }
            set
            {
                CheckStringSetter(value, "AlbumName");
                albumName = value;
            }
        }
        public int DurationSeconds
        {
            get { return durationSeconds; }
            set
            {
                CheckIntSetter(value, "DurationSeconds");
                durationSeconds = value;
            }
        }
        public Track(string name, string artist, string albumName, int durationSeconds)
        {
            Name = name;
            Artist = artist;
            AlbumName = albumName;
            DurationSeconds = durationSeconds;
        }

        public override bool Equals(object obj)
        {
            if (obj == null || GetType() != obj.GetType())
            {
                return false;
            }
            Track other = (Track)obj;
            return Name == other.Name && Artist == other.Artist && AlbumName == other.AlbumName;
        }

        public override int GetHashCode()
        {
            return (Name, Artist, AlbumName).GetHashCode();
        }
    }
    public class DNode
    {
        public Track Song { get; }
        public DNode Prev { get; internal set; }
        public DNode Next { get; internal set; }

        public DNode(Track t, DNode p, DNode n)
        {
            Song = t;
            Next = n;
            Prev = p;
        }
    }

    // DoublyLinkedList class
    public class DoublyLinkedList
    {
        private int size;
        internal DNode header, tail;
        public int Count => size;
        public bool IsEmpty => size == 0;

        public DoublyLinkedList()
        {
            size = 0;
            header = new DNode(null, null, null);
            tail = new DNode(null, header, null);
            header.Next = tail;
        }

        public DNode GetFirst()
        {
            if (IsEmpty) throw new InvalidOperationException("List is empty");
            return header.Next;
        }

        public DNode GetLast()
        {
            if (IsEmpty) throw new InvalidOperationException("List is empty");
            return tail.Prev;
        }

        public void AddLast(DNode v)
        {
            DNode u = tail.Prev;
            v.Prev = u;
            v.Next = tail;
            u.Next = v;
            tail.Prev = v;
            size++;
        }
        public int Size()
        {
            return size;
        }
        public void Remove(DNode v)
        {
            if (v == header || v == tail) throw new ArgumentException("Cannot remove header or tail");
            DNode prev = v.Prev;
            DNode next = v.Next;
            prev.Next = next;
            next.Prev = prev;
            size--;

            v.Next = v.Prev = null;
        }
    }

    // Playlist class
    public class Playlist
    {
        private string name;
        private DoublyLinkedList songs;
        private DNode curr;

        public Playlist(string name)
        {
            this.name = name;
            songs = new DoublyLinkedList();
            curr = songs.header;
        }

        public string Name => name;
        public int Count => songs.Count;

        public void Add(Track t)
        {
            songs.AddLast(new DNode(t, null, null));
            if (Count == 1)
            {
                curr = songs.GetFirst();
            }
        }

        public void Remove(Track t)
        {
            if (songs.IsEmpty) return;

            DNode node = songs.GetFirst();
            while (node != songs.tail)
            {
                if (node.Song.Equals(t))
                {
                    if (curr == node)
                    {

                        curr = (node.Prev != songs.header) ? node.Prev : node.Next;
                    }

                    songs.Remove(node);
                    if (songs.IsEmpty)
                    {
                        curr = songs.header;
                    }

                    return;
                }
                node = node.Next;
            }
        }

        public void Next()
        {
            if (curr.Next != songs.tail)
            {
                curr = curr.Next;
            }
            else if (curr == songs.header && !songs.IsEmpty)
            {
                curr = songs.GetFirst();
            }
        }

        public override string ToString()
        {
            if (curr == songs.header || curr == songs.tail || curr.Song == null)
            {
                return "No song is currently selected.";
            }
            Track track = curr.Song;
            return $"Currently playing: {track.Name} by {track.Artist}";
        }

        public void Shuffle()
        {
            if (Count < 2) return;

            List<DNode> nodes = new List<DNode>();
            DNode current = songs.GetFirst();
            while (current != songs.tail)
            {
                nodes.Add(current);
                current = current.Next;
            }

            Random random = new Random();
            for (int i = nodes.Count - 1; i > 0; i--)
            {
                int j = random.Next(0, i + 1);
                (nodes[i], nodes[j]) = (nodes[j], nodes[i]);
            }

            songs.header.Next = nodes[0];
            nodes[0].Prev = songs.header;

            for (int i = 0; i < nodes.Count - 1; i++)
            {
                nodes[i].Next = nodes[i + 1];
                nodes[i + 1].Prev = nodes[i];
            }

            nodes.Last().Next = songs.tail;
            songs.tail.Prev = nodes.Last();

            curr = songs.GetFirst();
        }
    }
}