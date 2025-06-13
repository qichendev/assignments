using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace Question06
{
    public class Program
    {
        class WordWithVowels
        {
            public string Word;
            public int Vowels;
        }
        public static void Main(string[] args)
        {
            var reader = new StreamReader("words.txt");
            Queue<WordWithVowels> lines = new Queue<WordWithVowels>();
            string line;
            while ((line = reader.ReadLine()) != null)
            {
                lines.Enqueue(new WordWithVowels { Word = line, Vowels = 0 });
            }
            reader.Close();
            var vowels = new HashSet<char> {'a', 'e', 'i', 'o', 'u'};
            int maxVowels = 0;
            
            // Process each word in the queue
            foreach (var wordWithVowels in lines)
            {
                for (int j = 0; j < wordWithVowels.Word.Length; j++)
                {
                    if (vowels.Contains(char.ToLower(wordWithVowels.Word[j])))
                    {
                        wordWithVowels.Vowels++;
                    }
                }
                if (wordWithVowels.Vowels > maxVowels)
                {
                    maxVowels = wordWithVowels.Vowels;
                }
            }
            Console.WriteLine("The largest number of vowels in any one word is: " + maxVowels);
        }
    }
}
