using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace A3
{
    public class Part2DNode
    {
        public char Bucket { get; internal set; }
        public Part2DNode Prev { get; internal set; }
        public Part2DNode Next { get; internal set; }

        public Part2DNode(char t, Part2DNode p, Part2DNode n)
        {
            Bucket = t;
            Next = n;
            Prev = p;
        }
    }

    // Part2DoublyLinkedList class
    public class Part2DoublyLinkedList
    {
        private int size;
        internal Part2DNode header, tail;
        public int Count => size;
        public bool IsEmpty => size == 0;

        public Part2DoublyLinkedList()
        {
            size = 0;
            header = new Part2DNode('\0', null, null);
            tail = new Part2DNode('\0', header, null);
            header.Next = tail;
        }

        public Part2DNode GetFirst()
        {
            if (IsEmpty) throw new InvalidOperationException("List is empty");
            return header.Next;
        }

        public Part2DNode GetLast()
        {
            if (IsEmpty) throw new InvalidOperationException("List is empty");
            return tail.Prev;
        }

        public void AddLast(Part2DNode v)
        {
            Part2DNode u = tail.Prev;
            v.Prev = u;
            v.Next = tail;
            u.Next = v;
            tail.Prev = v;
            size++;
        }

        // remove node from list
        public void Remove(Part2DNode v)
        {
            if (v == header || v == tail) throw new ArgumentException("Cannot remove header or tail");
            Part2DNode prev = v.Prev;
            Part2DNode next = v.Next;
            prev.Next = next;
            next.Prev = prev;
            size--;

            v.Next = v.Prev = null;
        }
    }

    // Stack class
    public class Stack
    {
        private Part2DoublyLinkedList list;
        public Stack()
        {
            list = new Part2DoublyLinkedList();
        }

        public int Size()
        {
            return list.Count;
        }

        public void Push(char bracket)
        {
            if (bracket == '\0') throw new ArgumentException("Bracket cannot be null character");
            Part2DNode newNode = new Part2DNode(bracket, null, null);
            list.AddLast(newNode);
        }

        public char Pop()
        {
            if (list.IsEmpty) throw new InvalidOperationException("Stack is empty");
            Part2DNode lastNode = list.GetLast();
            char bucket = lastNode.Bucket;
            list.Remove(lastNode);
            return bucket;
        }

        public char Top()
        {
            if (list.IsEmpty) throw new InvalidOperationException("Stack is empty");
            return list.GetLast().Bucket;
        }
    }

    // BracketMatcher class
    public class BracketMatcher
    {
        private bool IsMatchingPair(char opening, char closing)
        {
            return (opening == '(' && closing == ')') ||
                   (opening == '{' && closing == '}') ||
                   (opening == '[' && closing == ']');
        }

        public bool IsValid(string input)
        {
            if (string.IsNullOrEmpty(input)) return true;
            Stack stack = new Stack();
            foreach (char c in input)
            {
                if (c == '(' || c == '{' || c == '[')
                {
                    stack.Push(c);
                }
                else if (c == ')' || c == '}' || c == ']')
                {
                    if (stack.Size() == 0) return false;
                    char top = stack.Top();
                    if (!IsMatchingPair(top, c)) return false;
                    stack.Pop();
                }
            }
            return stack.Size() == 0;
        }
    }
}