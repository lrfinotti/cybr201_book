---
jupytext:
  encoding: '# -*- coding: utf-8 -*-'
  formats: ipynb,sage:percent,md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.17.1
kernelspec:
  display_name: SageMath 10.5
  language: sage
  name: sage-10.5
---

# What is Cryptography?

+++

From [Wikepdia](https://en.wikipedia.org/):

> [Cryptography](https://en.wikipedia.org/wiki/Cryptography) is the practice and study of techniques for secure communication in the presence of adversarial behavior.   More generally, cryptography is about constructing and analyzing protocols that prevent third parties or the public from reading private messages. Modern cryptography exists at the intersection of the disciplines of mathematics, computer science, information security, electrical engineering, digital signal processing, physics, and others.  Core concepts related to information security (data confidentiality, data integrity, authentication, and non-repudiation) are also central to cryptography.  Practical applications of cryptography include electronic commerce, chip-based payment cards, digital currencies, computer passwords, and military communications

+++

The word "cryptography" comes from the Greek root words *kryptos*, meaning hidden, and *graphikos*, meaning writing. The modern scientific study of cryptography is sometimes referred to as cryptology.

+++

The common scenario is that Alice and Bob want to exchange a secrete message that if even if intercepted by their "enemy", Eve, she will not be able to learn its contents.

+++

## The Caesar (or Substitution) Cipher

+++

The importance of keeping messages secret is clear and has been applied since ancient times.  One very basic *cipher* (i.e., a secret method of writing or recording data) is the so called [Caesar Cipher](https://en.wikipedia.org/wiki/Caesar_cipher), since there is some evidence the Caesar employed this method in ancient Rome.

The idea is very basic: we simply scramble the letters!

For instance one might replace every occurrence of A with D, every occurrence of B with, H, every occurrence of C with U, and so on.

To distinguish the encoded text from the real one, we will use *lowercase* letters for the unencrypted text and *uppercase* letters for the encrypted text.  So, our "scrambling" might be given by the table below:

```{table} Example of Caesar Cipher
:name: tb-cc
:align: center
:width: 70%

| **Original** | **Encrypted** |   | **Original** | **Encrypted** |
|-------------:|:--------------|---|-------------:|:--------------|
|            a | D             |   |            n | R             |
|            b | H             |   |            o | Z             |
|            c | U             |   |            p | N             |
|            d | E             |   |            q | O             |
|            e | F             |   |            r | X             |
|            f | C             |   |            s | L             |
|            g | S             |   |            t | Y             |
|            h | A             |   |            u | W             |
|            i | B             |   |            v | V             |
|            j | M             |   |            w | T             |
|            k | J             |   |            x | K             |
|            l | G             |   |            y | I             |
|            m | P             |   |            z | Q             |
```

+++

Suppose then that we want to encrypt the text:

> Luis is a great teacher!

(Although, this is no secret...) 😀

Here is our steps:

  * Remove all non-letter characters (such as spaces and punctuation).
  * Make the text lowercase.
  * Replace each letter by the corresponding one.

In this case, we would get

```
L u i s   i s   a   g r e a t   t e a c h e r !
G W B L   B L   D   S X F D Y   Y F D U A F X
```

So, the encrypted message is `GWBLBLDSXFDYYFDUAFX`.


```{note}

In practice, there might be some extra difficulties.  For instance, my name is actually Luís (with an accent), not Luis.  So, in these situations we might need to replace accented characters by the corresponding plain ones.
```

+++

Conversely suppose you've got the encrypted message `HFLWXFYZEXBRJIZWXZVDGYBRF`.  To decipher it, you need to use the substitution from the table above backwards:

```
H F L W X F Y Z E X B R J I Z W X Z V D G Y B R F
b e s u r e t o d r i n k y o u r o v a l t i n e
```

The secret message is then [Be sure to drink your Ovaltine](https://www.youtube.com/watch?v=6_XSShVAnkY).

+++

###  Security Considerations

+++

How hard is it to break the Caesar's cipher, meaning, how hard would it be to decode an ecnrypted message without the *key* (the letter conversion table)?

A mindless brute force attempt would be hard!

```{code-cell} ipython3
print(f"There are {factorial(26):,} possible permutations of the alphabet!")
```

That's a lot!

+++

But, there is a clear weakness to this method: it is susceptible to a *statistical analysis* attack.  One can search for common words as common occurrences.  Here are the [100 most common words in English](https://en.wikipedia.org/wiki/Most_common_words_in_English):

```{table} 100 Most Common Words in English
:align: center
:widths: auto
:width: 100 %
:name: tb-common_words

| Rank | Word |   | Rank | Word  |   | Rank | Word   |   | Rank | Word    |
|-----:|:-----|---|-----:|:------|---|-----:|:-------|---|-----:|:--------|
|    1 | the  |   |   26 | they  |   |   51 | when   |   |   76 | come    |
|    2 | be   |   |   27 | we    |   |   52 | make   |   |   77 | its     |
|    3 | to   |   |   28 | say   |   |   53 | can    |   |   78 | over    |
|    4 | of   |   |   29 | her   |   |   54 | like   |   |   79 | think   |
|    5 | and  |   |   30 | she   |   |   55 | time   |   |   80 | also    |
|    6 | a    |   |   31 | or    |   |   56 | no     |   |   81 | back    |
|    7 | in   |   |   32 | an    |   |   57 | just   |   |   82 | after   |
|    8 | that |   |   33 | will  |   |   58 | him    |   |   83 | use     |
|    9 | have |   |   34 | my    |   |   59 | know   |   |   84 | two     |
|   10 | I    |   |   35 | one   |   |   60 | take   |   |   85 | how     |
|   11 | it   |   |   36 | all   |   |   61 | people |   |   86 | our     |
|   12 | for  |   |   37 | would |   |   62 | into   |   |   87 | work    |
|   13 | not  |   |   38 | there |   |   63 | year   |   |   88 | first   |
|   14 | on   |   |   39 | their |   |   64 | your   |   |   89 | well    |
|   15 | with |   |   40 | what  |   |   65 | good   |   |   90 | way     |
|   16 | he   |   |   41 | so    |   |   66 | some   |   |   91 | even    |
|   17 | as   |   |   42 | up    |   |   67 | could  |   |   92 | new     |
|   18 | you  |   |   43 | out   |   |   68 | them   |   |   93 | want    |
|   19 | do   |   |   44 | if    |   |   69 | see    |   |   94 | because |
|   20 | at   |   |   45 | about |   |   70 | other  |   |   95 | any     |
|   21 | this |   |   46 | who   |   |   71 | than   |   |   96 | these   |
|   22 | but  |   |   47 | get   |   |   72 | then   |   |   97 | give    |
|   23 | his  |   |   48 | which |   |   73 | now    |   |   98 | day     |
|   24 | by   |   |   49 | go    |   |   74 | look   |   |   99 | most    |
|   25 | from |   |   50 | me    |   |   75 | only   |   |  100 | us      |
```

+++

Therefore, in a *reasonably long* text, if XKU is the most frequent sequence of three letters, there is a good chance that X is t, K is h, and U is e.  We will try to apply this idea shortly, but first, we need routines for encoding and decoding text.

+++

One can also look for the most common individual letters.  Here is a table with the average [frequency of letters in English text](https://en.wikipedia.org/wiki/Letter_frequency):

```{table} Frequency of Letters in English (Alphabetical)
:align: center
:widths: auto
:width: 100 %
:name: tb-freq_letters_a

| Letter | Frequency |   | Letter | Frequency |
|-------:|:----------|---|-------:|:----------|
|      A | 8.2%      |   |      N | 6.7%      |
|      B | 1.5%      |   |      O | 7.5%      |
|      C | 2.8%      |   |      P | 1.9%      |
|      D | 4.3%      |   |      Q | 0.095%    |
|      E | 12.7%     |   |      R | 6.0%      |
|      F | 2.2%      |   |      S | 6.3%      |
|      G | 2.0%      |   |      T | 9.1%      |
|      H | 6.1%      |   |      U | 2.8%      |
|      I | 7.0%      |   |      V | 0.98%     |
|      J | 0.15%     |   |      W | 2.4%      |
|      K | 0.77%     |   |      X | 0.15%     |
|      L | 4.0%      |   |      Y | 2.0%      |
|      M | 2.4%      |   |      Z | 0.074%    |
```

+++

Here is the same table, but sorted by frequency:

```{table} Frequency of Letters (by Frequency)
:align: center
:widths: auto
:width: 100 %
:name: label

| Letter | Frequency |   | Letter | Frequency |
|-------:|:----------|---|-------:|:----------|
|      E | 12.7%     |   |      M | 2.4%      |
|      T | 9.1%      |   |      W | 2.4%      |
|      A | 8.2%      |   |      F | 2.2%      |
|      O | 7.5%      |   |      G | 2.0%      |
|      I | 7.0%      |   |      Y | 2.0%      |
|      N | 6.7%      |   |      P | 1.9%      |
|      S | 6.3%      |   |      B | 1.5%      |
|      H | 6.1%      |   |      V | 0.98%     |
|      R | 6.0%      |   |      K | 0.77%     |
|      D | 4.3%      |   |      J | 0.15%     |
|      L | 4.0%      |   |      X | 0.15%     |
|      C | 2.8%      |   |      Q | 0.095%    |
|      U | 2.8%      |   |      Z | 0.074%    |
```

+++

And here are the frequencies of the [most frequent *bigrams*](https://en.wikipedia.org/wiki/Bigram) (combinations of two letters) in English text, which allows us t see which letters we expect to appear together.

```{table} Most Frequent Bigrams
:align: center
:widths: auto
:width: 100 %
:name: tb-bigrams

| Bigram | Frequency |   | Bigram | Frequency |   | Bigram | Frequency |
|-------:|:----------|---|-------:|:----------|---|-------:|:----------|
|     TH | 3.56%     |   |     OF | 1.17%     |   |     IO | 0.83%     |
|     HE | 3.07%     |   |     ED | 1.17%     |   |     LE | 0.83%     |
|     IN | 2.43%     |   |     IS | 1.13%     |   |     VE | 0.83%     |
|     ER | 2.05%     |   |     IT | 1.12%     |   |     CO | 0.79%     |
|     AN | 1.99%     |   |     AL | 1.09%     |   |     ME | 0.79%     |
|     RE | 1.85%     |   |     AR | 1.07%     |   |     DE | 0.76%     |
|     ON | 1.76%     |   |     ST | 1.05%     |   |     HI | 0.76%     |
|     AT | 1.49%     |   |     TO | 1.05%     |   |     RI | 0.73%     |
|     EN | 1.45%     |   |     NT | 1.04%     |   |     RO | 0.73%     |
|     ND | 1.35%     |   |     NG | 0.95%     |   |     IC | 0.70%     |
|     TI | 1.34%     |   |     SE | 0.93%     |   |     NE | 0.69%     |
|     ES | 1.34%     |   |     HA | 0.93%     |   |     EA | 0.69%     |
|     OR | 1.28%     |   |     AS | 0.87%     |   |     RA | 0.69%     |
|     TE | 1.20%     |   |     OU | 0.87%     |   |     CE | 0.65%     |
```

+++

### Encoding and Decoding Functions

+++

We need to functions to deal with characters:

* `ord`: takes a character (as a string) and returns the [ASCII](https://en.wikipedia.org/wiki/ASCII) value of a character;
* `chr`: takes a numerical value (integer between 0 and 127) and return the character corresponding to that value in ASCII.

+++

Here is the ASCII table of character/values:

```{table} ASCII Table
:align: center
:widths: auto
:width: 100 %
:name: tb-ascii

| Decimal Value | Character                    |   | Decimal Value | Character |   | Decimal Value | Character |   | Decimal Value | Character |
|--------------:|:-----------------------------|---|--------------:|:----------|---|--------------:|:----------|---|--------------:|:----------|
|             0 | NUL (null)                   |   |            32 | SPACE     |   |            64 | @         |   |            96 | `         |
|             1 | SOH (start of heading)       |   |            33 | !         |   |            65 | A         |   |            97 | a         |
|             2 | STX (start of text)          |   |            34 | "         |   |            66 | B         |   |            98 | b         |
|             3 | ETX (end of text)            |   |            35 | #         |   |            67 | C         |   |            99 | c         |
|             4 | EOT (end of transmission)    |   |            36 | $         |   |            68 | D         |   |           100 | d         |
|             5 | ENQ (enquiry)                |   |            37 | %         |   |            69 | E         |   |           101 | e         |
|             6 | ACK (acknowledge)            |   |            38 | &         |   |            70 | F         |   |           102 | f         |
|             7 | BEL (bell)                   |   |            39 | '         |   |            71 | G         |   |           103 | g         |
|             8 | BS  (backspace)              |   |            40 | (         |   |            72 | H         |   |           104 | h         |
|             9 | TAB (horizontal tab)         |   |            41 | )         |   |            73 | I         |   |           105 | i         |
|            10 | LF  (NL line feed, new line) |   |            42 | *         |   |            74 | J         |   |           106 | j         |
|            11 | VT  (vertical tab)           |   |            43 | +         |   |            75 | K         |   |           107 | k         |
|            12 | FF  (NP form feed, new page) |   |            44 | ,         |   |            76 | L         |   |           108 | l         |
|            13 | CR  (carriage return)        |   |            45 | -         |   |            77 | M         |   |           109 | m         |
|            14 | SO  (shift out)              |   |            46 | .         |   |            78 | N         |   |           110 | n         |
|            15 | SI  (shift in)               |   |            47 | /         |   |            79 | O         |   |           111 | o         |
|            16 | DLE (data link escape)       |   |            48 | 0         |   |            80 | P         |   |           112 | p         |
|            17 | DC1 (device control 1)       |   |            49 | 1         |   |            81 | Q         |   |           113 | q         |
|            18 | DC2 (device control 2)       |   |            50 | 2         |   |            82 | R         |   |           114 | r         |
|            19 | DC3 (device control 3)       |   |            51 | 3         |   |            83 | S         |   |           115 | s         |
|            20 | DC4 (device control 4)       |   |            52 | 4         |   |            84 | T         |   |           116 | t         |
|            21 | NAK (negative acknowledge)   |   |            53 | 5         |   |            85 | U         |   |           117 | u         |
|            22 | SYN (synchronous idle)       |   |            54 | 6         |   |            86 | V         |   |           118 | v         |
|            23 | ETB (end of trans. block)    |   |            55 | 7         |   |            87 | W         |   |           119 | w         |
|            24 | CAN (cancel)                 |   |            56 | 8         |   |            88 | X         |   |           120 | x         |
|            25 | EM  (end of medium)          |   |            57 | 9         |   |            89 | Y         |   |           121 | y         |
|            26 | SUB (substitute)             |   |            58 | :         |   |            90 | Z         |   |           122 | z         |
|            27 | ESC (escape)                 |   |            59 | ;         |   |            91 | [         |   |           123 | {         |
|            28 | FS  (file separator)         |   |            60 | <         |   |            92 | \         |   |           124 |           |
|            29 | GS  (group separator)        |   |            61 | =         |   |            93 | ]         |   |           125 | }         |
|            30 | RS  (record separator)       |   |            62 | >         |   |            94 | ^         |   |           126 | ~         |
|            31 | US  (unit separator)         |   |            63 | ?         |   |            95 | _         |   |           127 | DEL       |
```

+++

So:

```{code-cell} ipython3
ord('A')
```

```{code-cell} ipython3
chr(65)
```

So, let's create a list containing the alphabet and a particular permutation of the letters to be used for encryption:

```{code-cell} ipython3
alphabet = [chr(x) for x in range(97, 97 + 26)]  # ["a", "b", "c", ....]

# produce a *random* scrambling with
# [x.upper() for x in sample(alphabet, 26)]

# one particular fixed permutation of the alphabet
scrambled = ['D', 'H', 'U', 'E', 'F', 'C', 'S', 'A', 'B', 'M', 'J', 'G', 'P', 'R', 'Z', 'N', 'O', 'X', 'L', 'Y', 'W', 'V', 'T', 'K', 'I', 'Q']

# dictionary for encryption: key real, value encrypted
encrypt_dict = {x: X for x, X in zip(alphabet, scrambled)}

# dictionary for decryption: key encrypted, value real
decrypt_dict = {X: x for x, X in zip(alphabet, scrambled)}
```

Here is a function to encrypt the text:

```{code-cell} ipython3
def encrypt(text: str, encrypt_dict: dict) -> str:
    """
    Given some text and substitution dictionary, encrypts the text using
    the Caesar cipher.

    INPUT:
      * text: the text to be encoded (str).
      * encrypt_dict: a dictionary with the sutbstition.  The keys are lower
                      case letters, the values upper case letters.

    OUTPUT: the encoded text (str).
    """
    fixed_text = text.lower()  # make all lower case
    fixed_text = "".join(filter(str.isalpha, fixed_text))  # remove non-letter characters
    return "".join([encrypt_dict[letter] for letter in fixed_text])
```

Let's test it in the same example as above, the (not really) secret phrase

> Luis is a great teacher!

```{code-cell} ipython3
text = "Luis is a great teacher!"
enc_t = encrypt(text, encrypt_dict)

enc_t
```

You can compare to the above to see that we obtained the expected result.

Now, let's write the function to decrypt encrypted text:

```{code-cell} ipython3
def decrypt(enc_text: str, decrypt_dict: dict) -> str:
    """
    Given some Caesar cipher encrypted text and substitution dictionary,
    decrypts the text.

    INPUT:
      * enc_text: the encrypted text, all caps (str).
      * decrypt_dict: a dictionary with the reverse sutbstition.  The keys are lower
                      case letters, the values upper case letters.

    OUTPUT: the decoded text (str).
    """
    return "".join([decrypt_dict[letter] for letter in enc_text])
```

Let's try with our example:

```{code-cell} ipython3
decrypt("GWBLBLDSXFDYYFDUAFX", decrypt_dict)
```

And with the previous example:

```{code-cell} ipython3
decrypt("HFLWXFYZEXBRJIZWXZVDGYBRF", decrypt_dict)
```

### Statistical Analysis

+++

Let's create objects with the most common words, letters, and bigrams.

```{code-cell} ipython3
common_words = [
    "the",
    "be",
    "to",
    "of",
    "and",
    "a",
    "in",
    "that",
    "have",
    "I",
    "it",
    "for",
    "not",
    "on",
    "with",
    "he",
    "as",
    "you",
    "do",
    "at",
    "this",
    "but",
    "his",
    "by",
    "from",
    "they",
    "we",
    "say",
    "her",
    "she",
    "or",
    "an",
    "will",
    "my",
    "one",
    "all",
    "would",
    "there",
    "their",
    "what",
    "so",
    "up",
    "out",
    "if",
    "about",
    "who",
    "get",
    "which",
    "go",
    "me",
    "when",
    "make",
    "can",
    "like",
    "time",
    "no",
    "just",
    "him",
    "know",
    "take",
    "people",
    "into",
    "year",
    "your",
    "good",
    "some",
    "could",
    "them",
    "see",
    "other",
    "than",
    "then",
    "now",
    "look",
    "only",
    "come",
    "its",
    "over",
    "think",
    "also",
    "back",
    "after",
    "use",
    "two",
    "how",
    "our",
    "work",
    "first",
    "well",
    "way",
    "even",
    "new",
    "want",
    "because",
    "any",
    "these",
    "give",
    "day",
    "most",
    "us",
]

letter_freq = {
    "E": 0.127,
    "T": 0.091,
    "A": 0.082,
    "O": 0.075,
    "I": 0.07,
    "N": 0.067,
    "S": 0.063,
    "H": 0.061,
    "R": 0.06,
    "D": 0.043,
    "L": 0.04,
    "C": 0.028,
    "U": 0.028,
    "M": 0.024,
    "W": 0.024,
    "F": 0.022,
    "G": 0.02,
    "Y": 0.02,
    "P": 0.019,
    "B": 0.015,
    "V": 0.0098,
    "K": 0.0077,
    "J": 0.0015,
    "X": 0.0015,
    "Q": 0.00095,
    "Z": 0.00074,
}

bigram_freq = {
    "TH": 0.0356,
    "HE": 0.0307,
    "IN": 0.0243,
    "ER": 0.0205,
    "AN": 0.0199,
    "RE": 0.0185,
    "ON": 0.0176,
    "AT": 0.0149,
    "EN": 0.0145,
    "ND": 0.0135,
    "TI": 0.0134,
    "ES": 0.0134,
    "OR": 0.0128,
    "TE": 0.0120,
    "OF": 0.0117,
    "ED": 0.0117,
    "IS": 0.0113,
    "IT": 0.0112,
    "AL": 0.0109,
    "AR": 0.0107,
    "ST": 0.0105,
    "TO": 0.0105,
    "NT": 0.0104,
    "NG": 0.0095,
    "SE": 0.0093,
    "HA": 0.0093,
    "AS": 0.0087,
    "OU": 0.0087,
    "IO": 0.0083,
    "LE": 0.0083,
    "VE": 0.0083,
    "CO": 0.0079,
    "ME": 0.0079,
    "DE": 0.0076,
    "HI": 0.0076,
    "RI": 0.0073,
    "RO": 0.0073,
    "IC": 0.0070,
    "NE": 0.0069,
    "EA": 0.0069,
    "RA": 0.0069,
    "CE": 0.0065,
}
```

Now, let's take a larger text for encryption, the first chapter (only six paragraphs) from [A Tale of Two Cities](https://www.gutenberg.org/files/98/98-h/98-h.htm):

```{code-cell} ipython3
tale_text = """It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way—in short, the period was so far like the present period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of comparison only.

There were a king with a large jaw and a queen with a plain face, on the throne of England; there were a king with a large jaw and a queen with a fair face, on the throne of France. In both countries it was clearer than crystal to the lords of the State preserves of loaves and fishes, that things in general were settled for ever.

It was the year of Our Lord one thousand seven hundred and seventy-five. Spiritual revelations were conceded to England at that favoured period, as at this. Mrs. Southcott had recently attained her five-and-twentieth blessed birthday, of whom a prophetic private in the Life Guards had heralded the sublime appearance by announcing that arrangements were made for the swallowing up of London and Westminster. Even the Cock-lane ghost had been laid only a round dozen of years, after rapping out its messages, as the spirits of this very year last past (supernaturally deficient in originality) rapped out theirs. Mere messages in the earthly order of events had lately come to the English Crown and People, from a congress of British subjects in America: which, strange to relate, have proved more important to the human race than any communications yet received through any of the chickens of the Cock-lane brood.

France, less favoured on the whole as to matters spiritual than her sister of the shield and trident, rolled with exceeding smoothness down hill, making paper money and spending it. Under the guidance of her Christian pastors, she entertained herself, besides, with such humane achievements as sentencing a youth to have his hands cut off, his tongue torn out with pincers, and his body burned alive, because he had not kneeled down in the rain to do honour to a dirty procession of monks which passed within his view, at a distance of some fifty or sixty yards. It is likely enough that, rooted in the woods of France and Norway, there were growing trees, when that sufferer was put to death, already marked by the Woodman, Fate, to come down and be sawn into boards, to make a certain movable framework with a sack and a knife in it, terrible in history. It is likely enough that in the rough outhouses of some tillers of the heavy lands adjacent to Paris, there were sheltered from the weather that very day, rude carts, bespattered with rustic mire, snuffed about by pigs, and roosted in by poultry, which the Farmer, Death, had already set apart to be his tumbrils of the Revolution. But that Woodman and that Farmer, though they work unceasingly, work silently, and no one heard them as they went about with muffled tread: the rather, forasmuch as to entertain any suspicion that they were awake, was to be atheistical and traitorous.

In England, there was scarcely an amount of order and protection to justify much national boasting. Daring burglaries by armed men, and highway robberies, took place in the capital itself every night; families were publicly cautioned not to go out of town without removing their furniture to upholsterers’ warehouses for security; the highwayman in the dark was a City tradesman in the light, and, being recognised and challenged by his fellow-tradesman whom he stopped in his character of “the Captain,” gallantly shot him through the head and rode away; the mail was waylaid by seven robbers, and the guard shot three dead, and then got shot dead himself by the other four, “in consequence of the failure of his ammunition:” after which the mail was robbed in peace; that magnificent potentate, the Lord Mayor of London, was made to stand and deliver on Turnham Green, by one highwayman, who despoiled the illustrious creature in sight of all his retinue; prisoners in London gaols fought battles with their turnkeys, and the majesty of the law fired blunderbusses in among them, loaded with rounds of shot and ball; thieves snipped off diamond crosses from the necks of noble lords at Court drawing-rooms; musketeers went into St. Giles’s, to search for contraband goods, and the mob fired on the musketeers, and the musketeers fired on the mob, and nobody thought any of these occurrences much out of the common way. In the midst of them, the hangman, ever busy and ever worse than useless, was in constant requisition; now, stringing up long rows of miscellaneous criminals; now, hanging a housebreaker on Saturday who had been taken on Tuesday; now, burning people in the hand at Newgate by the dozen, and now burning pamphlets at the door of Westminster Hall; to-day, taking the life of an atrocious murderer, and to-morrow of a wretched pilferer who had robbed a farmer’s boy of sixpence.

All these things, and a thousand like them, came to pass in and close upon the dear old year one thousand seven hundred and seventy-five. Environed by them, while the Woodman and the Farmer worked unheeded, those two of the large jaws, and those other two of the plain and the fair faces, trod with stir enough, and carried their divine rights with a high hand. Thus did the year one thousand seven hundred and seventy-five conduct their Greatnesses, and myriads of small creatures—the creatures of this chronicle among the rest—along the roads that lay before them."""
```

```{code-cell} ipython3
print(f"The text has {len(tale_text.split())} words.")
```

Now, let's encrypt it:

```{code-cell} ipython3
tale_text_enc = encrypt(tale_text, encrypt_dict)
tale_text_enc
```

```{code-cell} ipython3
print(f"The text has {len(tale_text_enc)} characters (not counting spaces and punctuation).")
```

Let's now create a function that gives us the most common occurrence of consecutive letters:

```{code-cell} ipython3
from collections import Counter


def analyze_text(text: str, length: int):
    """
    Given a text and some length, returns a counter with the most frequent occurences
    of substrings in text of the given length.

    INPUT:
    text: a string containing some text;
    length: length of substring to check for frequency.

    OUTPUT:
    A counter with the most frequent substring of the text with the given length.
    """
    res = []
    for i in range(len(text) - length):
        res.append(text[i : i + length])
    return Counter(res)
```

```{code-cell} ipython3
def analyze_letter(text):
    counter = dict(analyze_text(text, 1))
    letters = list(counter.keys())
    letters.sort(reverse=True, key=lambda letter: counter[letter])
    counter_sorted = {letter: counter[letter] for letter in letters}
    total = len(text)
    for letter, guess in zip(counter_sorted.keys(), letter_freq.keys()):
        print(f"{letter}: {counter_sorted[letter]:>6}  --  {guess.lower()}: {round(letter_freq[guess] * total):>6}")
```

```{code-cell} ipython3
analyze_letter(tale_text_enc)
```

This gives us some guesses on what to try.  For instance, it seems that "F" is "e", "Y" is "t", and "D" is "a".  But let's try to get more certainty but also checking bigrams:

```{code-cell} ipython3
def analyze_bigram(text, num=20):
    counter = dict(analyze_text(text, 2).most_common(num))
    bigrams = list(counter.keys())
    bigrams.sort(reverse=True, key=lambda bigram: counter[bigram])
    counter_sorted = {bigram: counter[bigram] for bigram in bigrams}

    f_bigrams = list(bigram_freq.keys())[:num]
    total = len(text)
    for bigram, guess in zip(bigrams, f_bigrams):
        print(f"{bigram}: {counter_sorted[bigram]:>7}  --  {guess.lower()}: {round(bigram_freq[guess] * total):>7}")
```

```{code-cell} ipython3
analyze_bigram(tale_text_enc)
```

This reinforces our guesses for "F" and "Y", but casts doubts on "D".  On the other hand, it hints "A" is "h".  Let's try these three values:

```{code-cell} ipython3
test_dec_dict = {chr(x): chr(x) for x in range(65, 91)}
test_dec_dict["Y"] = "t"
test_dec_dict["A"] = "h"
test_dec_dict["F"] = "e"

part_dec = decrypt(tale_text_enc, test_dec_dict)
```

Let's now analyze three letter words:

```{code-cell} ipython3
analyze_text(part_dec, 3).most_common(20)
```

```{code-cell} ipython3
[word for word in common_words if len(word) == 3]
```

So, maybe "DRE" is "and", which would confirm the initial guess that "D" was "a".  Let's check if the frequencies of "R" and "E" are close to those of "n" and "d", respectively:

```{code-cell} ipython3
analyze_letter(part_dec)
```

It seems close enough!  Let's give it a try:

```{code-cell} ipython3
test_dec_dict["D"] = "a"
test_dec_dict["R"] = "n"
test_dec_dict["E"] = "d"

part_dec = decrypt(tale_text_enc, test_dec_dict)
```

We should now start to see some common words showing up, like "that":

```{code-cell} ipython3
analyze_text(part_dec, 4)["that"]
```

It appears 13 times!

+++

Let's look at bigrams again:

```{code-cell} ipython3
analyze_bigram(part_dec)
```

This seems to indicate that "X" is "r" (from "er" and "re") and "B" is "i" (from "in" and "it").  Let's look at letter frequency as well:

```{code-cell} ipython3
analyze_letter(part_dec)
```

This does not give us too much confidence as "X" is more frequent than "r" and "B" less frequent than "i".  But let's try it:

```{code-cell} ipython3
test_dec_dict["X"] = "r"
test_dec_dict["B"] = "i"

part_dec = decrypt(tale_text_enc, test_dec_dict)
```

We can now look for other common words appearing:

```{code-cell} ipython3
[word for word in common_words if len(word) == 4]
```

We might be able to find "v" from "have".  Let's write a function to help:

```{code-cell} ipython3
def find_possible_word(text: str, word: str, dec_dict: dict[str, str]):
    """
    Given a text, a word, and a decrypting dictionary, returns a counter
    for words in the text that could be the given word.  The returned words
    must match the already decrypted letters and not have decrypted letters
    for letters still unknown.

    INPUT:
    text: the encrypted text;
    word: the word (str) we are trying to find;
    dec_dict: the (incomplete) decryption dictionary.

    OUTPUT:
    A counter with possible matches, i.e., words that could be word after
    decryption.
    """
    def use_word(new_word):
        for i, letter in enumerate(word):
            if letter in dec_dict.values() and new_word[i] != letter:
                return False
            if letter not in dec_dict.values() and new_word[i].islower():
                return False
        return True

    length = len(word)
    count_words = analyze_text(text, length)
    return {key: value for key, value in sorted(count_words.items(), key=lambda item: -item[1]) if use_word(key)}
```

```{code-cell} ipython3
find_possible_word(part_dec, "have", test_dec_dict)
```

It seems that "V" might "v"!  Let's check the overall frequencies:

```{code-cell} ipython3
analyze_letter(part_dec)
```

Seems like a good match!

```{code-cell} ipython3
test_dec_dict["V"] = "v"

part_dec = decrypt(tale_text_enc, test_dec_dict)
```

Let's try to find "w" from "with":

```{code-cell} ipython3
find_possible_word(part_dec, "with", test_dec_dict)
```

Again, checking with the frequencies, "T" as "w" is a good match!

```{code-cell} ipython3
test_dec_dict["T"] = "w"

part_dec = decrypt(tale_text_enc, test_dec_dict)
```

Maybe we can get "s" from "this":

```{code-cell} ipython3
find_possible_word(part_dec, "this", test_dec_dict)
```

It seems that "L" could be "s".  Let's check against letters and bigrams:

```{code-cell} ipython3
analyze_letter(part_dec)
```

```{code-cell} ipython3
analyze_bigram(part_dec)
```

The frequency as a letter looks good, but and "es" appears among bigrams, although st" does not.

Also note that from frequency and from "on" being a frequent bigram, there is a good change that "Z" is "o".

Moreover, if "Z" is "o", then from the bigrams, "ZC" is probably "of", since the most common bigrams starting with "o" are "on" and "of".

But let's try them.

```{code-cell} ipython3
test_dec_dict["L"] = "s"
test_dec_dict["Z"] = "o"
test_dec_dict["C"] = "f"

part_dec = decrypt(tale_text_enc, test_dec_dict)
```

Let's look at longer words:

```{code-cell} ipython3
sorted(common_words, key=len, reverse=True)[:20]
```

Let's see if we can find "because":

```{code-cell} ipython3
find_possible_word(part_dec, "because", test_dec_dict)
```

That is not too much to go by...  So, let's investigate some more.  Let's try "but":

```{code-cell} ipython3
find_possible_word(part_dec, "but", test_dec_dict)
```

And "be":

```{code-cell} ipython3
find_possible_word(part_dec, "be", test_dec_dict)
```

Ah-ha!  If indeed "H" is "b" and "W" is "u" we see "but" once and "be" 19 times.  It seems to work then:

```{code-cell} ipython3
test_dec_dict["H"] = "b"
test_dec_dict["U"] = "c"
test_dec_dict["W"] = "u"
part_dec = decrypt(tale_text_enc, test_dec_dict)
```

```{code-cell} ipython3
part_dec
```

Now, from the beginning

> itwasthebestoftiPesitwastheworstoftiPesitwastheaSeofwisdoPitwastheaSeoffooGishness

We can make some guesses: "P" is "m", "S" is "g", "G" is "l":

```{code-cell} ipython3
test_dec_dict["P"] = "m"
test_dec_dict["S"] = "g"
test_dec_dict["G"] = "l"
part_dec = decrypt(tale_text_enc, test_dec_dict)

part_dec
```

We can now see that "N" is "p", "I" is "y", "J" is "k":

```{code-cell} ipython3
test_dec_dict["N"] = "p"
test_dec_dict["I"] = "y"
test_dec_dict["J"] = "k"
part_dec = decrypt(tale_text_enc, test_dec_dict)

part_dec
```

```{code-cell} ipython3
test_dec_dict["O"] = "q"
test_dec_dict["K"] = "x"
test_dec_dict["M"] = "j"
part_dec = decrypt(tale_text_enc, test_dec_dict)

part_dec
```

Are we done? Let's see if some letter is not translated:

```{code-cell} ipython3
[key for key, value in test_dec_dict.items() if value.isupper()]
```

So, it should be the value missing:

```{code-cell} ipython3
sorted(value for value in test_dec_dict.values() if value.islower())
```

```{code-cell} ipython3
test_dec_dict["Q"] = "z"

part_dec = decrypt(tale_text_enc, test_dec_dict)

part_dec
```

I think we are done now:

```{code-cell} ipython3
part_dec.islower()
```

Let's double check we got it right:

```{code-cell} ipython3
test_dec_dict == decrypt_dict
```

We've done it!

+++

### Strengthening the Caesar Cipher

+++

So, as we can see, it is not that hard to break the Caesar Cipher.  But, if the text is short, and avoid articles ("the" and "a") and prepositions ("of", "from", "to", etc.) when not making the text unintelligible, it could still be rather safe, as the statistical analysis would not gives us much and brute force attach is not viable.

Another idea is to insert a reasonable amount of random letters around the actual text.  One would likely still be able to discern the actual message.

On the other hand, if the subject of the text is known, like in messages transmitted, say, during war, one can look for expected words, like "attack", "defend", "evade", etc.  So, it is still not advisable to use it.

An alternative would be to permute all the *bigrams*, like

```{table} Example of Bigram Permutation
:align: center
:widths: auto
:width: 100 %

| Original | Encrypted |
|----------|-----------|
| aa       | HJ        |
| ab       | YT        |
| ac       | GG        |
| ...      | ...       |
```



There $\dbinom{26}{2} = 325$ pairs of two letters, giving $325!$ (a number with $677$ *digits*) possible permutations!

```{code-cell} ipython3
factorial(325)
```

(As a comparison, the [estimated number of atoms in the observable universe](https://www.livescience.com/how-many-atoms-in-universe.html) has about $82$ digits.)

+++

Not only this makes brute force attacks "even more unfeasible", it makes statistical analysis a lot harder as well.  Even studying most frequent bigrams would be difficult, as common pairs can be broken between two sets of bigrams.

The encryption and decryption process is slower and take a lot more memory (as the dictionaries will have $325$ entries instead of $26$), but it is still quite usable.

Note that if the number of letters in the original message is odd, one can attach a random letter at the end to make it even, it would likely not affect the understanding when decrypted.

+++

### Caesar Cipher for Numbers

+++

Another possible relatively safe application of the Caesar Cipher would for large numbers, on which we can permute the digits.  This might not work as well, when we have some expectation for some digits (such as in credit cards) and there are only $10! = 3{,}628{,}800$ possible permutations.  But, if the number is "random enough" (unlike credit cards), there is no statistical analysis attack.  (And one cannot continue to guess after deciphering a digit or pair of digits.)  But one should certainly permute at least two digits, giving $\dbinom{10}{2}! = 45!$ (a very large number) possible permutations.  Or, one can write the digits in base $16$ (i.e. [hexadecimal numbers](https://en.wikipedia.org/wiki/Hexadecimal)) to get $16! = 20{,}922{,}789{,}888{,}000$ possible permutations of single digits.

As we will see, text can be made into a single (very large) number, and so one could actually use this idea for encrypting text.

+++

### Symmetric Key

+++

But even if there are ways to make Caesar Ciphers more secure, it has a crucial flaw: it is a [symmetric-key cipher](https://en.wikipedia.org/wiki/Symmetric-key_algorithm), meaning anyone who knows how to encrypt a message, also knows how to decrypt any message using this cipher.

Therefore, if Bob wants to send Alice a secrete message, they first have to agree on the Caesar Cipher they will use.  For instance, Bob can send Alice the key (the permutation being used) or a [decoder ring](https://en.wikipedia.org/wiki/Secret_decoder_ring) before sending her his secret message.  But, if Eve can intercept the decoder ring before Alice gets it, she then can make a copy, send the ring to Alice, and be able to then decipher any message using the cipher.

In the same way, imagine that every time you needed to make a payment online, the vendor needed to send you the encryption key for you to send your credit card number.  Can you be sure the key was not intercepted by some malicious party that then could decode your credit card number transmitted to the vendor?

Therefore, there is a clear need for a [public-key cryptosystem](https://en.wikipedia.org/wiki/Public-key_cryptography), in which the encryption method is known by *all*, but knowing how to encrypt does not automatically imply that you can also decrypt.

The
