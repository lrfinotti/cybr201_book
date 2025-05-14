---
jupytext:
  formats: ipynb,md:myst,sage:percent
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.16.7
kernelspec:
  display_name: SageMath 10.5
  language: sage
  name: sage-10.5
---

---
math:
  '\F': '\mathbb{F}'
  '\Fpt': '\F_p^{\times}'
---

# The Diffie-Hellman Key Exchange and the ElGamal Cryptosystem

+++

## Cryptosystems

A [Cryptosystem](https://en.wikipedia.org/wiki/Cryptosystem) is a set of algorithms used in the transmission of private messages.

As we've mentioned before, the usual scenario is when Bob wants to send Alice some secret message so that even if their enemy Eve intercepts the message, she will not be able to read its content.

This means that Bob needs a way to *encode* the message and Alice needs a way to decode the message, and the decoding process must difficult enough that, without some secret knowledge, Eve should not be able to discover the decoding method.

Formally, we write that if $m$ is the plain/unencrypted message, then Bob uses some *encoding key*, say $e$, to create a function $E_e$, called the *encryption function*, which depends on the key $e$, so that $E_e(m)$ produces the encrypted message.

Alice then uses a *decoding key* $d$ (which will depend on the encoding key $e$) to produce a *decryption function* $D_d$ that can recover an encrypted message, i.e., such that $D_d(E_d(m)) = m$.

In our example of the Caesar Cipher, the encryption key $e$ was the table that would permute the letters of the alphabet, and the encryption function would use the table $e$ to replace the letters.  The decoding key $d$ was the inverse table of $e$, and the decoding function would use this reversed table to replace the letters based on this new table $d$.

+++

## Symmetric versus Asymmetric Cryptosystems

In our Caesar Cipher example, as mentioned before, knowledge of the encryption table/key $e$ would automatically tell Eve what the decryption key $d$ should be.  This is an example of what we call a *symmetric cryptosystem*: the same key allows for both encrypting and decrypting messages.

But again, this raises the problem of how will Alice and Bob exchange the encryption/decryption key.  A better method would be to have an *asymmetric cryptosystem*, i.e., one in which Alice can provide *publicly* an encoding key to Bob (or anyone else who might want to send her a message), but keep secret her decoding key, with the obvious assumption that is hard to obtain the decoding key from the publicly available decoding key.  In this situation the encoding key is called the *public-key* and the decoding key is called the *private key*.  For this reason, these asymmetric cryptosystems are also called *public-key cryptosystems*.

Of course, the real question is how can we create such a system.  Most of the naive methods one can come up with will be symmetric.  But before we do that, let's see if we can find a safe way to exchange a key in a symmetric cryptosystem.

+++

(DH_key_exchange)=
## The Diffie-Hellman Key Exchange

If you have a symmetric cryptosystem, you are faced with the problem of sharing the encryption/decryption key.  [Whitfield Diffie](https://en.wikipedia.org/wiki/Whitfield_Diffie) and [Martin Hellman](https://en.wikipedia.org/wiki/Martin_Hellman) proposed in 1976 a clever method to do so, based on the discrete log problem (DLP).  Here is how it goes:

**The Diffie-Hellman Key Exchange:**

1) A trusted party publishes:
    - a large prime $p$ and
    - an element $g$ of $\Fpt$ of large *prime* order $q$.  (The order $q$ is also public.)
2) Alice chooses a *secret* integer $a$, and Bob chooses a *secret* integer $b$.
3) Alice computes $A = g^a$ and *publicly* sends the result $A$ to Bob.  (So, $A$ is known, but not the exponent $a$ to produce it.)  Similarly, Bob computes $B = g^b$ and *publicly* sends the result $B$ to Alice.
4) Alice computes $B^a$ and Bob computes $A^b$.  These values are equal and that is their **shared key**.

Note that $A^b = (g^a)^b = g^{ab}$ and $B^a = (g^b)^a = g^{ba} = g^{ab}$, and that's why they now posses a common secret key.

Eve, Alice and Bob's enemy, will know $p$, $g$, $q$, $A$, and $B$, since these are all public, but will not know $a$ and $b$.  Only Alice knows $a$ and only Bob knows $b$.  Now Alice and Bob can, somehow, use their shared key to produce they key for a symmetric cryptosystem.


:::{note}

The numbers involved are very large in general, so one would have to compute very large powers of $g$.  So, you can see how the [Fast Powering Algorithm](./05-Powers.md#fast_powering).
:::

+++

### Finding $q$ and $g$

How would one find the $g$, with large order $q$ in $\Fpt$?  Let's first think about its order, which we called $q$.  We want it to be as large as possible.  As we've seen in [Proposition %s](./05-Powers.md#pr-power_one) in the previous section, we know that $|g| = q \mid \varphi(p)=p-1$.  Since $p$ is odd, being a prime different from $2$, the largest that $q$ could be is if $p-1 = 2q$.  So, to find the *pair* $p$ and $q$, we look for a $p$ of the desired size, and check if $(p-1)/2$ is also prime.  If so, $q = (p-1)/2$ works.

We can do that relatively easy with Sage for primes of reasonable size:

```{code-cell} ipython3
%%time

# let's find a 64-bit prime
lower_bound = 2^63
upper_bound = 2^64 - 1

while True:
    p = next_prime(randint(lower_bound, upper_bound))
    q = (p - 1) // 2
    if is_prime(q):
        break

print(f"We can take {p = } and {q = }.")
```

Now, how do we find $g$, and element of $\Fpt$ of order $q$?

If we take a random element of $a$ of $\Fpt$, we know that $|a| \mid p-1 = 2q$.  Since $q$ is prime, the only possible orders for $a$ are $1$ (and only the element $1$ of $\Fpt$ has order $1$), $2$ (and one can show that the only $-1 = p - 1$ has order $2$ in $\Fpt$), $q$, or $2q$.

Now, we can compute $a^2$.  If we get $1$, then $a$ is either $1$ or $p-1$, and we try a different random $a$.  But if $a^2 \neq 1$, then, either $|a| = q$ or $|a|=2q$.

If $|a|=q$, then, by [Proposition %s](./05-Powers.md#pr-order_power), we have that
$$
|a^2| = \frac{q}{\gcd(q, 2)} = \frac{q}{1} = q,
$$
since $q$ is odd.

If $|a|=2q$, then, by the same result, we have that
$$
|a^2| = \frac{2q}{\gcd(2q, 2)} = \frac{2q}{2} = q.
$$
Hence, in either case $a^2$ gives us an element of order $q$.

So, we have, when $p = 2q$, to find an element of order $q$ we simply take an random element $a$ between $2$ and $p-2$, and square it, i.e., we take $g = a^2$.

+++

More generally, when we do not necessarily have that $q = (p-1)/2$, but simply a prime number dividing $p-1$, we have:

:::{prf:proposition} Finding $g$
:label: find_g
:numbered: true

Given primes $p$ and $q$, with $q$ dividing $p-1$, and a random element $a \in \Fpt$, then the probability that $c^{\frac{p-1}{q}}$ has order $q$ is $(q-1)/q$.
:::

:::{admonition} Homework
:class: note

In your homework you will implement this general method of finding $g$ of order $q$ and check the statement about the probability above.
:::

+++

### Example

As a quick example.  First, last use a prime $p$ between $100{,}000$ and $200{,}000$, such that $(p-1)/2$ is also prime.  (This size is too small for it to safe, but will illustrate the process.)

```{code-cell} ipython3
while True:
    p = next_prime(randint(10^5, 2*10^5))
    q = (p-1) // 2
    if is_prime(q):
        break

print(f"We have {p = }, and {q = }.")
```

We also need some element $g$ in $\Fpt$ of order $q$.

```{code-cell} ipython3
g = Mod(randint(2, p-2), p)^2
g
```

Let's check its order:

```{code-cell} ipython3
g.multiplicative_order() == q
```

Now Alice takes a random $a$ between $2$ and $q - 1$:

```{code-cell} ipython3
a = randint(2, q - 1)
a
```

And Bob takes and random $b$ in the same range:

```{code-cell} ipython3
b = randint(2, q - 1)
b
```

Alice computes $A = g^a$:

```{code-cell} ipython3
A = g^a
A
```

And Bob computes $B = g^b$:

```{code-cell} ipython3
B = g^b
B
```

+++ {"user_expressions": [{"expression": "A", "result": {"status": "ok", "data": {"text/plain": "12600"}, "metadata": {}}}, {"expression": "B", "result": {"status": "ok", "data": {"text/plain": "167370"}, "metadata": {}}}]}

So, now Alice sends Bob $A$, i.e., {eval}`A`, and Bob sends Alice $B$, i.e., {eval}`B`, while keeping $a$ and $b$ for themselves.

Then, Alice computes $B^a$, with $B$ from Bob and her private key $a$:

```{code-cell} ipython3
B^a
```

And Bob computes $A^b$, with $A$ from Alice and his private key $b$:

```{code-cell} ipython3
A^b
```

As you can see, it is the same number, the same as $g^{ab}$:

```{code-cell} ipython3
g^(a * b)
```

### Finding the Shared Key

How could Eve find the shared key $g^{ab}$ without knowing $a$ and $b$?  In other words, how can she solve the *Diffie-Hellman Problem*:

:::{prf:definition} Diffie-Hellman Problem
:label: def-DH
:numbered: true

We call the *Diffie-Hellman Problem* the problem of being able to break the Diffie-Hellman key exchange, namely: given a prime $p$, $g \in \Fpt$, and $A=g^a$ and $B=g^b$ (without knowing $a$ and $b$ themselves), find $g^{ab}$.
:::


If she can solve the *discrete log problem*, then she can solve the Diffie-Hellman problem: Eve computes $\log_g(A)$, which is just $a$, and then, as Alice does, gets the shared key as $B^a$.  It is not known if the converse is true, namely, if one can solve the Diffie-Hellman problem, then somehow one can solve the discrete log problem.

+++

### Security Considerations

Is the Diffie-Hellman Key Exchange secure in general?  If $p$ (from $\Fpt$) and $q = |g|$ are large enough, and $a$ and $b$ are *randomly generated* number between $2$ and $q-1$ (and therefore likely quite large as well), it is *believed* to be secure, because the discrete log and Diffie-Hellman problems are *believed* to be difficult to solve.

:::{note}

In general we want $p$ to have at least $2048$ bits, i.e., we want $p \geq 2^{2047}$ (noting that $2^{2047}$ has $617$ *digits*), and if possible have the prime $q$ to be simply $(p-1)/2$, the largest possible order of an element in $\Fpt$.  This would mean that $q$ would be a $2047$-bit prime.
:::

Choosing $a$ and $b$ randomly is also strongly encouraged, as to avoid numbers that are easier to guess, like birth dates, phone numbers, addresses, etc.

But why is the discrete log and Diffie-Hellman problems *believed* to be safe?  Mostly because those are mathematical problems that mathematicians, including some of the most capable individuals one can expect to find, have been trying to solve for a relatively long time.  Moreover, as researchers, mathematicians would most likely publish any solution they find, instead of secretly keeping the solution to themselves.

But note that we have no guarantee that some very clever individual will come up with an ingenious solution *tomorrow*.  Or that this individual, or nation, will not be tempted to keep the solution secret for personal, financial, or military gains.  **But basing security of cryptosystems in long standing mathematical problems is the best idea we have so far.**

+++

Also note that if the order of the element $g$ were not prime, then we can compute $|A| = |g^a|$ and if $|A| \neq |g|$, which is possible when $|g|$ is not prime, then by [](./05-Powers.md#pr-order_power) we know that
$$
|A| = \frac{|g|}{\gcd(|g|, a)} \qquad \Longrightarrow \qquad \gcd(|g|, a) = \frac{|g|}{|A|},
$$
and hence, since $|g|$ is known, we can find $\gcd(|g|, a)$, a divisor of $a$, giving us some information about Alice's private key $a$.  In particular, one can try to guess it by trying multiples of this found GCD.

+++

### Public Setup

A great advantage of a public setup step, as step 1 of the Diffie-Hellman Key Exchange is that we can copy the setup (i.e., the $p$, $g$, and $q$) from some organization using the depend on its security, like the National Security Agency or some large online retailer, like Amazon, as they have certainly devoted considerable resources to make sure that their setup is secure.

+++

(sec-elgamal)=
## The ElGamal Public-Key Cryptosystem

+++

The Diffie-Hellman key exchange allows us to have a shared key with each one can set up some *public-key* cryptosystem (based on this key).  But how can one actually do it?  [Taher ElGamal](https://en.wikipedia.org/wiki/Taher_Elgamal) in 1985 introduce the [ElGamal Cryptosystem](https://en.wikipedia.org/wiki/ElGamal_encryption) based on Diffie-Hellman.

:::{note}

The ElGamal cryptosystem was not the first public-key cryptosystem.  The [RSA Cryptosystem](https://en.wikipedia.org/wiki/RSA_cryptosystem) was introduce in 1977, one year after the introduction of the Diffie-Hellman key exchange, but, unlike ElGamal, it does not use it.  We will introduce the RSA cryptosystem in the next chapter.
:::

We will now describe the cryptosystem, but observe that, for now, we shall assume that the message to be exchanged between Bob and Alice is a *number*, but we shall soon discuss how we can apply this method can be used for text as well.

+++

### Steps for ElGamal Encryption

1) **Set up:** Choose and publish large prime $p$ and element $g \in \F_p$ of large prime order.
2) **Key Creation:** Alice chooses a *private* key $a \in \{1, 2, 3, \ldots, p-2\}$ and publishes $A = g^a$ (in $\F_p$).
3) **Encryption:** To encrypt the message $m$ (a numbers between $1$ and $p-1$), Bob chooses a *random* *ephemeral* key (i.e., a random key to be discarded after a single use) $k$, computes $c_1 = g^k$, and $c_2=mA^k$ (both in $\F_p$), and sends the pair $(c_1, c_2)$ to Alice.  (This pair is the encrypted message.)
4) **Decryption:** To decrypt $(c_1, c_2)$ sent by Bob, Alice, using her private key $a$, computes $(c_1^a)^{-1} \cdot c_2$ (in $\F_p$).  This last expression is equal to the message $m$.


Let's check that this process works.  We have
\begin{align*}
  (c_1^a)^{-1} \cdot c_2 &= {\left({\left(g^k\right)}^a\right)}^{-1} \cdot m A^k && \text{(since $c_1 = g^k$, and $c_2=mA^k$)}\\
  &= {\left(g^{ak}\right)}^{-1} \cdot m A^k\\
  &= {\left({\left(g^a\right)}^k\right)}^{-1} \cdot m A^k \\
  &= {\left(A^k\right)}^{-1} \cdot m A^k && \text{(since $g^a = A$)}\\
  &= m \cdot (A^k)^{-1} A^k \\
  &= m.
\end{align*}

+++

:::{note}

Note that inside this process we have an Diffie-Hellman key exchange: Alice has $A = g^a$ and Bob has $g^k$, with the shared key being $A^k = g^{ak}$, which Alice uses for decryption when she computes $c_1^a$.
:::

+++

### Example

+++

#### Set Up

We can use the same $p$ and $g$ we've used for Diffie-Hellman above (or one can repeat the same steps, of copy the set up from a trusted source):

```{code-cell} ipython3
print(f"We will use {p = } and {g = }.")
```

#### Private/Public Keys

Alice can just choose her private key $a$ as a random number:

```{code-cell} ipython3
a = randint(2, p - 2)
print(f"Alice will use {a = }.")
```

Finally, Alice publishes $A=g^a$:

```{code-cell} ipython3
A = g^a
```

#### Encryption

Now, suppose that Bob wants to send Alice the last four digits of his Social Security Number, say $m = 1234$.

:::{note}

Note that the size of $p$, in principle, restricts the size of numbers that Bob can send Alice, as it needs to be between $0$ and $p-1$.  But we will see how to deal with this restriction later.
:::

```{code-cell} ipython3
m = Mod(1234, p)
```

Now, Bob chooses his random ephemeral key $k$ (to be used only once):

```{code-cell} ipython3
k = randint(2, p - 1)
```

Then, computes $c_1$ and $c_2$ and gets the encrypted message $(c_1, c_2)$:

```{code-cell} ipython3
c1 = g^k
c2 = m * A^k
encrypted_message = (c1, c2)

encrypted_message
```

Bob then sends $(c_1, c_2)$ to Alice.

+++

#### Decryption

Alice receives $(c_1, c_2)$ and decrypts with the formula $(c_1^a)^{-1} \cdot c_2$ as above.  We should get the original message $m = 1234$ as the result:

```{code-cell} ipython3
c1, c2 = encrypted_message  # Alice reads c1 and c2 from encrypted message received
(c1^a)^(-1) * c2
```

:::{admonition} Homework
:class: note
As usual, you will implement these steps more generally in your homework.
:::


### Security Considerations

Again, as for the Diffie-Hellman key exchange, we need the order of $g$ to be prime, and again, the best possible scenario is when $|g| = (p-1)/2$ and prime.

Also note that in the encryption process, Bob should use an ephemeral private key $k$, meaning that he should randomly generate a new key for each message.  This increases security as if somehow Eve know that some message $m$ was encrypted and $(c_1, c_2)$ was the encrypted message, then she can decrypt any other encrypted message.  Say that Bob encrypts another message $m'$ using $k$ again, and resulting on the encrypted message $(c_1', c_2')$, then Eve can find the new secret message $m'$ by computing $m \cdot c_2'/c_2$, since:
\begin{align*}
  m \cdot \frac{c_2'}{c_2}
  &= m \cdot \frac{m' \cdot A^k}{m \cdot A^k}  && \text{(since using $k$ again)} \\
  &= m \cdot \frac{m'}{m} \\
  &= m'.
\end{align*}

+++

## Encrypting Text and Large Numbers

+++

(sec:converting_text)=
## Converting Text

The ElGamal cryptosystem, as well as others we will learn, encode *numbers*.  But in practice, we often need to encode *text*.  Therefore, we need a way to convert text to numbers and vice-versa.  One way is to again use the corresponding [ASCII](https://en.wikipedia.org/wiki/ASCII) value of a character.

:::{table} ASCII Table
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
:::


Remember that Python/Sage has functions for conversions:

* `ord`: takes a character (as a string) and returns the ASCII value of a character;
* `chr`: takes a numerical value (integer between 0 and 127) and return the character corresponding to that value in ASCII.

### Example

As an example, say you want to convert the text `cat` to a number to encode.  Each character in a number between $0$ and $127$, as we can see from the table.  We have:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
ord('c'), ord('a'), ord('t')
```

We now need to put these individual numbers together into a single number *in a unique and reversible way*.  One idea is to use the numbers obtained to build a number in base $128$:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
m = 99 + 97 * 128 + 116 * 128^2
m
```

We can then use ElGamal (or another cryptosystem) to encode this number!

Now when Alice decodes the encoded number, she will get this $m$ back and needs to recover the text from it.  For that, she looks at its digits in base $128$, and use these digits to get the characters back:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
v = 1913059.digits(base=128)
v
```

Then, she converts the "digits" (numbers between $0$ and $127$) back to characters using `chr`:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
chr(99) + chr(97) + chr(116)
```

### Smaller Base

This works fine, but for longer text the corresponding number might get very large.  One can make them considerably smaller by working in base $26$, since we have only $26$ letters.  (We could work in base $27$, if we wanted to keep spaces as well, but let's keep it simple here).  So, we can convert any text we need to encode to lower case (with the string method `.lower()`), remove all characters but lower case letters, and then subtract $97$ (the ASCII value of `a`) from the ASCII value of each character left.  Then, we put them together in base $26$.  For example, for the word `cat` again:

```{code-cell} ipython3
ord('c') - 97, ord('a') - 97, ord('t') - 97
```

We put it in base $26$:

```{code-cell} ipython3
m = 2 + 0 * 26 + 19 * 26^2
m
```

Again, we can encrypt this number and Alice can decode in a similar way, but remembering to add $97$ to the digits in base $26$ to get the characters back:

```{code-cell} ipython3
v = 12846.digits(base=26)
v
```

Then, she converts the "digits" (numbers between $0$ and $127$) back to characters using `chr`:

```{code-cell} ipython3
chr(2 + 97) + chr(0 + 97) + chr(19 + 97)
```

### Functions

Now, let's write these conversions as functions.  We will have a parameter `small` that allow us to choose base $26$ (with `small=True`) or base $128$ (with `small=False`).

Now, let's make these into functions:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
def string2number(string, small=True):
    """
    Converts a string to its numerical representation in either base 26 (lowercase letters only) or
    in base 128 (using full ASCII characters).

    INPUT:
      * string: string to be converted to a number;
      * small: if True, use base 26, if False, use base 128.

    OUTPUT:
    An intger obtained by using the numerical values of the characters as digits in the corresponding
    base.
    """
    # find appropriate base
    # difference is the value to be subtracted of the ASCII value
    if small:
        base = 26
        difference = 97
        # lower case only in base 26
        string = string.lower()
    else:
        base = 128
        difference = 0

    res = 0  # final result
    factor = 1  # power of the base
    for char in string:  # we can loop over a string!
        digit = ord(char) - difference  # digit
        # skip the rest if base 26 and character is invalid
        if small and (digit < 0 or digit > 25):
            continue
        res += digit * factor
        factor *= base
    return res
```

Now decoding:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
def number2string(number, small=True):
    """
    Converts a number to its string representation in either base 26 (lowercase letters only) or
    in base 128 (using full ASCII characters).

    INPUT:
      * number: integer to be converted to a string;
      * small: if True, use base 26, if False, use base 128.

    OUTPUT:
    A string obtained by using the digits in the corresponding base as the numerical values for the characters.
    """
    res = ""
    if small:
        base = 26
        difference = 97
    else:
        base = 128
        difference = 0

    return "".join(chr(x + difference) for x in number.digits(base))
```

So, if we want to convert "Luis is the best professor ever!", we do:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
string2number("Luis is the best professor ever!")
```

To recover the original:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
number2string(4069000240540552872126375355100619523)
```

Or, using full ASCII:

```{code-cell} ipython3
string2number("Luis is the best professor ever!", small=False)
```

```{code-cell} ipython3
number2string(7139509106217299707736390611080077508851787183905427399303772142284, small=False)
```

## Encrypting Large Numbers

In the ElGamal cryptosystem, and others we will soon learn, the numbers to be encrypted are in $\Z/m\Z$ for some modulus $m$.  A problem arises when we try to convert a number larger than this $m$, as we cannot distinguish in $\Z/m\Z$ a number $n$ from $n + km$ for any integer $k$.

For instance, let's say that we want to encrypt `Luis is the best professor ever!` using $p = 24{,}778{,}948{,}499$ (for $\F_p$).  Then, as we can see from the values above, even using base $26$, the numerical values for this message are too large!  (This prime is way too small to be safe for encryption, but it illustrates the point.)

So if were working modulo this $p$, the numerical value would be changed when reducing modulo $p$:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
p = 24778948499
n = string2number("Luis is the best professor ever!")
print(f"The original number is {n}, but modulo p it is {n % p}.")
```

In $\F_p$ the original number would be lost, and we would only have its reduction.  But decoding this reduction gives us gibberish:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
number2string(n % p)
```

How do we fix this issue when the number we are trying to encrypt is larger than the modulus?  We break the number in smaller parts and encrypt each part!

We do that by writing the number in the base $m$, where $m$ is the modulus!

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
v = n.digits(base=p)
v
```

We must encrypt each one of those digits separately, using ElGamal (or whichever) cryptosystem.  Bob then sends a *tuple* of messages, the digits of the original encrypted, and then Alice decrypts each one individually and put them back together using base $m$.

```{code-cell} ipython3
base = p
res = sum(digit * base^i for i, digit in enumerate(v))
res, number2string(res)
```

Or, computing consecutive powers more efficiently:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
base = p
res = 0
factor = 1
for digit in v:
    res += digit * factor
    factor *= base
res, number2string(res)
```

(In this case the last method is not strictly necessary, as the numbers are small, but it is good to get used thinking on the best general way to perform a computation.)
