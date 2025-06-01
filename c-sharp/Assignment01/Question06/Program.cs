using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Question06
{
    public class Program
    {
        class WordWithVowels
        {
            public string word;
            public int vowels;
        }
        public static void Main(string[] args)
        {
            TextReader reader = new StreamReader("words.txt");
            Queue<WordWithVowels> lines = new Queue<WordWithVowels>();
            string line;
            while ((line = reader.ReadLine()) != null)
            {
                lines.Enqueue(new WordWithVowels { word = line, vowels = 0 });
            }
            reader.Close();
            var vowels = new HashSet<char> {'a', 'e', 'i', 'o', 'u'};
            int maxVowels = 0;
            for (int i = 0; i < lines.Count; i++)
            {
                for (int j = 0; j < lines[i].Length; j++)
                {
                    if (vowels.Contains(lines[i].word[j].ToLower()))
                    {
                        lines[i].vowels++;
                    }
                }
                if (lines[i].vowels > maxVowels)
                {
                    maxVowels = lines[i].vowels;
                }
            }
            Console.WriteLine("The largest number of vowels in any one word is: " + maxVowels);
        }
    }
}
