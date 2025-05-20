---
jupytext:
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

# Quadratic Sieve and Index Calculus

+++

In this chapter we introduce two of the more effective (and mathematically sophisticated) tools for attacks at the ElGamal and RSA Cryptosystems.


## The Quadratic Sieve

We will focus again on the problem of factorization, more specifically, factoring $N = p q$, where $p$ and $q$ are large, distinct primes.  With the [difference of squares Factorization method](#sec-diff-squares), the hard part was the *Relation Building*, i.e., finding $a_1, a_2, \ldots , a_r > \sqrt{N}$, for $r$ sufficiently large, such the $c_i$'s, defined as the reduction modulo $N$ of $a_i^2$, are all $B$-smooth for some relatively small $B$.

In this section we introduce the [*Quadratic Sieve*](https://en.wikipedia.org/wiki/Quadratic_sieve), which is an efficient algorithm for relation building.  When used with the difference of squares factorization method, it is the best known algorithm to factor $N = pq$ with $N < 2^{350}$.

:::{note}

The number $2^{350}$ is huge!  The estimated number of atoms in the know universe is about $2^{272}$.  We would need to double this number $78$ times to get $2^{350}$.
:::

:::{note}

For $N > 2^{350}$, the [Number Field Sieve](https://en.wikipedia.org/wiki/General_number_field_sieve) is more efficient, but beyond the scope of these notes.
:::

+++

### Sieving $B$-Smooth Numbers

Let's start with a simple and intuitive way of finding $B$-smooth numbers in a list of consecutive integers:

:::{prf:algorithm} Sieving $B$-Smooth Numbers
:label: al-seive-b-smooth


Given a list of numbers $2, 3, 4, \ldots , n$ and some $B > 0$, the following procedure finds the $B$-smooth numbers in the list.  We refer to the "number in position $k$" in the list following Sage/Python's convention: $2$ is position $0$, $3$ in position $1$, etc.  So, initially, the number $k$ is in position $k-2$.

1) Initialize $p \leftarrow 2$ and a new list as a copy of the original.
2) While $p < B$:
   1) Set $i \leftarrow 1$:
   2) While $p^i < n$:
      1) Set $j \leftarrow p^i - 2$.
      2) While $j \leq n-2$:
         1) Divide the number in position $j$ of the *new list* by $p$.
         2) Set $j \leftarrow j + p^i$
      3) Set $i \leftarrow i + 1$.
   3) Set $p$ as the next element on the *new list* different from $1$.
3) Return the elements from the original list in the positions where we have $1$'s in the new list.
:::


Here is an example for finding $3$-smooth numbers up to $19$.

```{math}
\begin{array}{ccccccccccccccccc}
2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 & 13 & 14 & 15 & 16 & 17 & 18 & 19
\end{array}
```

We start $p = 2$ and divide all multiples of $2$ by $2$:

```{math}
\begin{array}{rrrrrrrrrrrrrrrrrr}
2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 & 13 & 14 & 15 & 16 & 17 & 18 & 19 \\
{\color{red} 1} & 3 & {\color{red} 2} & 5 & {\color{red} 3} & 7 & {\color{red} 4} & 9 & {\color{red} 5} & 11 & {\color{red} 6} & 13 & {\color{red} 7} & 15 & {\color{red} 8} & 17 & {\color{red} 9} & 19 \\
\end{array}
```

Now, we divide all numbers in positions corresponding to multiples of $2^2$ by $2$:

```{math}
\begin{array}{rrrrrrrrrrrrrrrrrr}
2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 & 13 & 14 & 15 & 16 & 17 & 18 & 19 \\
1 & 3 & 2 & 5 & 3 & 7 & 4 & 9 & 5 & 11 & 6 & 13 & 7 & 15 & 8 & 17 & 9 & 19 \\
1 & 3 & {\color{red} 1} & 5 & 3 & 7 & {\color{red} 2} & 9 & 5 & 11 & {\color{red} 3} & 13 & 7 & 15 & {\color{red} 4} & 17 & 9 & 19 \\
\end{array}
```


Now, we divide all numbers in positions corresponding to multiples of $2^3$ by $2$:

```{math}
\begin{array}{rrrrrrrrrrrrrrrrrr}
2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 & 13 & 14 & 15 & 16 & 17 & 18 & 19 \\
1 & 3 & 2 & 5 & 3 & 7 & 4 & 9 &  5 & 11 &  6 & 13 &  7 & 15 &  8 & 17 &  9 & 19 \\
1 & 3 & 1 & 5 & 3 & 7 & 2 & 9 &  5 & 11 &  3 & 13 &  7 & 15 &  4 & 17 &  9 & 19 \\
1 & 3 & 1 & 5 & 3 & 7 & {\color{red} 1} & 9 &  5 & 11 &  3 & 13 &  7 & 15 &  {\color{red} 2} & 17 &  9 & 19 \\
\end{array}
```

Now, we divide all numbers in positions corresponding to multiples of $2^4$ by $2$:

```{math}
\begin{array}{rrrrrrrrrrrrrrrrrr}
2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 & 13 & 14 & 15 & 16 & 17 & 18 & 19 \\
1 & 3 & 2 & 5 & 3 & 7 & 4 & 9 &  5 & 11 &  6 & 13 &  7 & 15 &  8 & 17 &  9 & 19 \\
1 & 3 & 1 & 5 & 3 & 7 & 2 & 9 &  5 & 11 &  3 & 13 &  7 & 15 &  4 & 17 &  9 & 19 \\
1 & 3 & 1 & 5 & 3 & 7 & 1 & 9 &  5 & 11 &  3 & 13 &  7 & 15 &  2 & 17 &  9 & 19 \\
1 & 3 & 1 & 5 & 3 & 7 & 1 & 9 &  5 & 11 &  3 & 13 &  7 & 15 &  {\color{red} 1} & 17 &  9 & 19 \\
\end{array}
```

Since $2^5 = 32 > 19$, we set $p$ to the next element on the list different from $1$, so $3$ in this case:

```{math}
\begin{array}{rrrrrrrrrrrrrrrrrr}
2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 & 13 & 14 & 15 & 16 & 17 & 18 & 19 \\
1 & 3 & 2 & 5 & 3 & 7 & 4 & 9 &  5 & 11 &  6 & 13 &  7 & 15 &  8 & 17 &  9 & 19 \\
1 & 3 & 1 & 5 & 3 & 7 & 2 & 9 &  5 & 11 &  3 & 13 &  7 & 15 &  4 & 17 &  9 & 19 \\
1 & 3 & 1 & 5 & 3 & 7 & 1 & 9 &  5 & 11 &  3 & 13 &  7 & 15 &  2 & 17 &  9 & 19 \\
1 & {\color{blue} 3} & 1 & 5 & 3 & 7 & 1 & 9 &  5 & 11 &  3 & 13 &  7 & 15 &  1 & 17 &  9 & 19 \\
\end{array}
```

We then repeat the process for $p=3$, dividing terms in positions corresponding to $3$, and then $3^2$, by $3$:

```{math}
\begin{array}{rrrrrrrrrrrrrrrrrr}
2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 & 13 & 14 & 15 & 16 & 17 & 18 & 19 \\
1 & 3 & 2 & 5 & 3 & 7 & 4 & 9 &  5 & 11 &  6 & 13 &  7 & 15 &  8 & 17 &  9 & 19 \\
1 & 3 & 1 & 5 & 3 & 7 & 2 & 9 &  5 & 11 &  3 & 13 &  7 & 15 &  4 & 17 &  9 & 19 \\
1 & 3 & 1 & 5 & 3 & 7 & 1 & 9 &  5 & 11 &  3 & 13 &  7 & 15 &  2 & 17 &  9 & 19 \\
1 & 3 & 1 & 5 & 3 & 7 & 1 & 9 &  5 & 11 &  3 & 13 &  7 & 15 &  1 & 17 &  9 & 19 \\
1 & {\color{red} 1} & 1 & 5 & {\color{red} 1} & 7 & 1 & {\color{red} 3} &  5 & 11 &  {\color{red} 1} & 13 &  7 &  {\color{red} 5} &  1 & 17 &  {\color{red} 3} & 19 \\
1 & 1 & 1 & 5 & 1 & 7 & 1 & {\color{red} 1} &  5 & 11 &  1 & 13 &  7 &  5 &  1 & 17 & {\color{red} 1} & 19 \\
\end{array}
```

Now, the next $p$ would be the next number different from $1$, so $5$, but $5 > B = 3$, so we stop, and return the numbers from the original list (top row) corresponding to $1$'s in the new one (bottom row):

```{math}
\begin{array}{rrrrrrrrrrrrrrrrrr}
{\color{green} 2} & {\color{green} 3} & {\color{green} 4} & 5 & {\color{green} 6} & 7 & {\color{green} 8} & {\color{green} 9} & 10 & 11 & {\color{green} 12} & 13 & 14 & 15 & {\color{green} 16} & 17 & {\color{green} 18} & 19 \\
1 & 3 & 2 & 5 & 3 & 7 & 4 & 9 &  5 & 11 &  6 & 13 &  7 & 15 &  8 & 17 &  9 & 19 \\
1 & 3 & 1 & 5 & 3 & 7 & 2 & 9 &  5 & 11 &  3 & 13 &  7 & 15 &  4 & 17 &  9 & 19 \\
1 & 3 & 1 & 5 & 3 & 7 & 1 & 9 &  5 & 11 &  3 & 13 &  7 & 15 &  2 & 17 &  9 & 19 \\
1 & 3 & 1 & 5 & 3 & 7 & 1 & 9 &  5 & 11 &  3 & 13 &  7 & 15 &  1 & 17 &  9 & 19 \\
1 & 1 & 1 & 5 & 1 & 7 & 1 & 3 &  5 & 11 &  1 & 13 &  7 &  5 &  1 & 17 &  3 & 19 \\
{\color{green} 1} & {\color{green} 1} & {\color{green} 1} & 5 & {\color{green} 1} & 7 & {\color{green} 1} & {\color{green} 1} &  5 & 11 &  {\color{green} 1} & 13 &  7 &  5 &  {\color{green} 1} & 17 & {\color{green} 1} & 19 \\
\end{array}
```

Therefore, the $3$-smooth numbers less than or equal to $19$ are: $2, 3, 4, 6, 8, 9, 12, 16, 18$.

+++

#### Implementation

Here is an implementation of the algorithm above:

```{code-cell} ipython3
def b_smooth_sieve(n, B):
    """
    Given and upper bound n and some B, finds all B-smooth numbers between 2 and n.

    INPUTS:
    n: integer greater than one;  check number from 2 to n for B-smoothness.
    B: positive integer (or float) used for smoothness.

    OUTPUT:
    A list containing all B-smooth numbers between 2 and n (inclusive).
    """
    numbers = list(range(2, n + 1))
    p = 2  # first prime
    index = 0  # position of current prime
    while p <= B:
        # divide entries by all possible powers of p
        i = 1
        while p^i <= n:
            for j in range(p^i - 2, n - 1, p^i):
                numbers[j] = numbers[j] // p
            i += 1
        # go to next prime (next element different from 1 in the list)
        index += 1
        while numbers[index] == 1:
            index += 1
        p = numbers[index]
    # select numbers where we obtained 1
    return [i for i in range(2, n + 1) if numbers[i - 2] == 1]
```

Let's check our work above:

```{code-cell} ipython3
b_smooth_sieve(19, 3)
```

And for all $5$-smooth numbers less than or equal to $100$:

```{code-cell} ipython3
b_smooth_sieve(100, 5)
```

(sec-relation_building)=
### Relation Building

The method above works for consecutive numbers.  But in our application, we need to find $a$'s, with $q > \sqrt{N}$,  such that the reduction module $N$ of $a^2$ are $B$-smooth.  Hence, we need to adapt our previous method.

We define the function $F(t) = t^2 - N$ (so $t$ is a variable and $N = pq$ the number we are trying to factor).  Then, if $\sqrt{N} < a < \sqrt{2N}$, we have that $0 < F(a) < N$, and hence $F(a)$ is its own reduction module $N$ and congruent to $a^2$ modulo $N$, i.e., $F(a)$ is the corresponding $c$.  Note that we had to restrict the size of $a$, but it helps avoid reducing $a^2$ module $N$: no long division, we just subtract $N$.

Therefore, we go through the list starting at $a = \lfloor \sqrt{N} \rfloor + 1$ up to some upper bound $b < \sqrt{2N}$ and find the $B$-smooth numbers in the list $F(a), F(a+1), F(a+2) , \ldots, F(b)$.  Note that since $N$ is very large, we have that $\sqrt{2N} - \sqrt{N}$ (about the largest length for our list) is about $0.41 \sqrt{N}$ and still quite larger, which should be enough to find a sufficient number of $B$-smooth numbers for the difference of squares algorithm.

Before we describe the actual process, we need the following definition:

:::{prf:definition} Factor Base
:label: def-factor-base

Given $B>0$, the *factor base of $B$* is the set of primes less than or equal to $B$.
:::

To find $B$-smooth number in $F(a), F(a+1), \ldots , F(b)$, for each $p$ in the factor base of $B$, we look for $t \in \{ a, a+1 , a+2, \ldots , b \}$ such that
```{math}
F(t) \equiv 0 \pmod{p}, \quad \text{i.e.,} \quad t^2 \equiv N \pmod{p}.
```
This means that $N$ is a square modulo $p$.  Fortunately, we have seen how to do this, for instance, we can use [Quadratic Reciprocity](#sec-quad_rec).  If $N$ is not square modulo $p$, we move to the next prime.

Note that if $p \mid N$, then we found a prime factor and are done.  So, let's assume that $p \nmid N$.  Then, if $N$ is a square modulo $p$, we get either two square roots, when $p$ is odd, or four, when $p=2$.  If $c$ is a square root of $N$, i.e., $c^2 \equiv N \pmod{p}$, then $F(c), F(c + p), F(c + 2p), \ldots$ are all divisible by $p$ (i.e., congruent to $0$ modulo $p$).  Then, as with consecutive numbers, we sieve through the list by dividing each every $p$ terms of our list by $p$.  More precisely, if $c_p$ is the smallest integer in $a, a+1, a+2, \ldots, b$ such that $c_p \equiv c \pmod{p}$, then we divide $F(c_p), F(c_p+p), F(c_p + 2p) \ldots$ by $p$.

But we need to also divide the terms that are divisible by higher powers of $p$.  For that, we can use [Hensel's Lemma](#sec-hl) to solve
```{math}
t^2 \equiv N \pmod{p^k}, \text{ for $k=1, 2, 3, \ldots $.}
```

+++

### Algorithm

Here is the algorithm for relation building:

:::{prf:algorithm} Relation Building
:label: al-rel-build


Given an integer $N$ (to be eventually factored), $B>0$, and an upped bound $b$ between $\sqrt{N}$ and $\sqrt{2N}$, we will produce two lists:

  - A list of integers between $\lfloor \sqrt{N} \rfloor + 1$ and $b$ such that their squares reduced modulo $N$ are $B$-smooth (the "$a_i$'s") and
  - the list of their squares reduced modulo $N$ (the "$c_i$'s").

We obtain these lists as follows:

1) Initialize:
   1) set `list_a` with elements from $\lfloor \sqrt{N} \rfloor + 1$ to the given $b$ (inclusive);
   2) set `list_c` with entries as $a^2 - N$ for $a$'s in `list_a`
   3) create a copy of `list_c`, say `sieve_list`.
2) Loop over primes $p$ less than or equal to the given $B$:
   1) If $N$ is not a square modulo $p$, break out of this loop (and go to the next prime).
   2) Set $n \leftarrow 1$.
   3) Until we manually break out, do:
      1) Compute all square roots of $N$ modulo $p^n$.
      2) For each one of the roots:
         1) Find (if possible) the index, say $i$, in `sieve_list` for the first entry that is congruent to the root modulo $p^n$.
         2) While $i$ is less than the length of `sieve_list`, divide the entry of `sieve_list` at index $i$ by $p$ and set $i \leftarrow i + p^n$.
      3) If no root had a match in the list, break this loop (and go to the next prime).
      4) Set $n \leftarrow n + 1$.
3) Return the elements of `list_a` corresponding to entries in `sieve_list` with $1$'s and, similarly, the elements of `list_c` corresponding to entries in `sieve_list` with $1$'s.
:::


:::{important}

We know how to find square roots modulo $p$ or verify if there is no such root.  But when finding square roots modulo $p^2$, $p^3$, etc., we should use *Hensel's Lemma*: when we have a square root modulo $p^k$ (from the previous step), we can use it to easily find a square root modulo $p^{k+1}$.  Also, remember that we only need one root, as the others are easy to find:
  - If $p$ is odd and $r$ is one square root modulo $p^n$, then the other is $p^n - r$.
  - If $p=2$:
    - There is a single square root modulo $2$.
    - If $r$ is a square root modulo $r$, then the other is $r + 2$.
    - If $r$ is a square root modulo $2^n$, for $n \geq 3$, then the others are $2^n - a$, $2^n - a - 2^{n-1}$, $a + 2^{n-1}$.
:::

+++

### Example

Let's illustrate the process with an example: let $N = 1073$.  Then, $a = \lfloor \sqrt{1073} \rfloor + 1 = 33$.  Let's use $b = 46 < \sqrt{2 \cdot 1147}$.  So, we computer $F(33), F(34), F(35), \ldots , F(46)$:

```{code-cell} ipython3
N = 1073
a  = floor(sqrt(N)) + 1
b = ceil(sqrt(2 * N)) - 1

def F(t):
    return t^2 - N

[F(x) for x in range(a, b + 1)]
```

In the tables below, the first row will always be the elements in the original list (the $a_i$'s), and below are the corresponding squares module $N$.

+++

```{math}
\begin{array}{rrrrrrrrrrrrrr}
33 & 34 &  35 &  36 &  37 &  38 &  39 &  40 &  41 &  42 &  43 &  44 &  45 &   46 \\
\hline
16 & 83 & 152 & 223 & 296 & 371 & 448 & 527 & 608 & 691 & 776 & 863 & 952 & 1043
\end{array}
```

+++

Let's find all $19$-smooth numbers in the second row $F(33), F(34), \ldots, F(46)$.

We start with $p=2$.  Since $N$ is odd, we have that $F(t)$ is even whenever $t$ is odd.  Or, we have that the square root of $N$ modulo $2$ is $1$, so any $t \equiv 1 \pmod{2}$ is such that $F(t) \equiv 0 \pmod{2}$ and can be divided by $2$.  Moreover that is the *only* square root modulo $2$.

```{math}
\begin{array}{rrrrrrrrrrrrrrr}
33 & 34 &  35 &  36 &  37 &  38 &  39 &  40 &  41 &  42 &  43 &  44 &  45 &   46 \\
\hline
16 & 83 & 152 & 223 & 296 & 371 & 448 & 527 & 608 & 691 & 776 & 863 & 952 & 1043 \\
 {\color{red} 8} & 83 &  {\color{red} 76} & 223 & {\color{red} 148} & 371 & {\color{red} 224} & 527 & {\color{red} 304} & 691 & {\color{red} 388} & 863 & {\color{red} 476} & 1043
\end{array}
```

Now, we see if $N$ has a square root modulo $4$.  But $N \equiv 1 \pmod{4}$, so we have two square roots modulo $4$: $t \equiv 1, 3 \pmod{4}$.  We have that $33 \equiv 1 \pmod{4}$ and $35 \equiv 3 \pmod{4}$.  We now divide $F(33), F(37), F(41), \ldots , F(45)$ and $F(35), F(39), F(43), \ldots F(43)$ by $2$:

```{math}
\begin{array}{rrrrrrrrrrrrrrr}
33 & 34 &  35 &  36 &  37 &  38 &  39 &  40 &  41 &  42 &  43 &  44 &  45 &   46 \\
\hline
16 & 83 & 152 & 223 & 296 & 371 & 448 & 527 & 608 & 691 & 776 & 863 & 952 & 1043 \\
 8 & 83 &  76 & 223 & 148 & 371 & 224 & 527 & 304 & 691 & 388 & 863 & 476 & 1043 \\
 {\color{red} 4} & 83 &  {\color{red} 38} & 223 &  {\color{red} 74} & 371 & {\color{red} 112} & 527 & {\color{red} 152} & 691 & {\color{red} 194} & 863 & {\color{red} 238} & 1043
\end{array}
```

Moving on to $2^3$, we have that $N \equiv 1 \pmod{8}$, so we have $4$ square roots modulo $8$: $1$, $3$, $5$, and $7$.  This means that again, we can divide every other element of the list of $F(t)$'s by $2$:


```{math}
\begin{array}{rrrrrrrrrrrrrrr}
33 & 34 &  35 &  36 &  37 &  38 &  39 &  40 &  41 &  42 &  43 &  44 &  45 &   46 \\
\hline
16 & 83 & 152 & 223 & 296 & 371 & 448 & 527 & 608 & 691 & 776 & 863 & 952 & 1043 \\
 8 & 83 &  76 & 223 & 148 & 371 & 224 & 527 & 304 & 691 & 388 & 863 & 476 & 1043 \\
 4 & 83 &  38 & 223 &  74 & 371 & 112 & 527 & 152 & 691 & 194 & 863 & 238 & 1043 \\
 {\color{red} 2} & 83 &  {\color{red} 19} & 223 &  {\color{red} 37} & 371 &  {\color{red} 56} & 527 &  {\color{red} 76} & 691 &  {\color{red} 97} & 863 & {\color{red} 119} & 1043
\end{array}
```

Modulo $2^4 = 16$ we also know that we have $4$ square roots, since $N \equiv 1 \pmod{8}$.  Now we apply Hensel's Lemma to compute these.  We find them to be $1$, $7$, $9$, $15$.

1) The first element in $\{ 33, 34, 35, \ldots, 46 \}$ congruent to $1$ modulo $16$ is $33$.  Since $33 + 16 > 46$, we only divide the number corresponding to $F(33)$ by $2$.
2) The first element in $\{ 33, 34, 35, \ldots, 46 \}$ congruent to $7$ modulo $16$ is $39$.  Since $39 + 16 > 46$, we only divide the number corresponding to $F(39)$ by $2$.
3) The first element in $\{ 33, 34, 35, \ldots, 46 \}$ congruent to $9$ modulo $16$ is $41$.  Since $41 + 16 > 46$, we only divide the number corresponding to $F(41)$ by $2$.
4) There is no element in $\{ 33, 34, 35, \ldots, 46 \}$ congruent to $15$ modulo $16$, so there is no other element to divide by $2$.


```{math}
\begin{array}{rrrrrrrrrrrrrrr}
33 & 34 &  35 &  36 &  37 &  38 &  39 &  40 &  41 &  42 &  43 &  44 &  45 &   46 \\
\hline
16 & 83 & 152 & 223 & 296 & 371 & 448 & 527 & 608 & 691 & 776 & 863 & 952 & 1043 \\
 8 & 83 &  76 & 223 & 148 & 371 & 224 & 527 & 304 & 691 & 388 & 863 & 476 & 1043 \\
 4 & 83 &  38 & 223 &  74 & 371 & 112 & 527 & 152 & 691 & 194 & 863 & 238 & 1043 \\
 2 & 83 &  19 & 223 &  37 & 371 &  56 & 527 &  76 & 691 &  97 & 863 & 119 & 1043 \\
 {\color{red} 1} & 83 &  19 & 223 &  37 & 371 &  {\color{red} 28} & 527 &  {\color{red} 38} & 691 &  97 & 863 & 119 & 1043
\end{array}
```


The square roots of $N$ modulo $2^5 = 32$ (using Hensel's Lemma again) are $7$, $9$, $23$, $25$.  In $ \{ 33, 34, \ldots, 46 \}$, only $39 \equiv 7 \pmod{32}$ and $41 \equiv 9 \pmod{32}$, so we can divide the corresponding numbers by $2$:

```{math}
\begin{array}{rrrrrrrrrrrrrrr}
33 & 34 &  35 &  36 &  37 &  38 &  39 &  40 &  41 &  42 &  43 &  44 &  45 &   46 \\
\hline
16 & 83 & 152 & 223 & 296 & 371 & 448 & 527 & 608 & 691 & 776 & 863 & 952 & 1043 \\
 8 & 83 &  76 & 223 & 148 & 371 & 224 & 527 & 304 & 691 & 388 & 863 & 476 & 1043 \\
 4 & 83 &  38 & 223 &  74 & 371 & 112 & 527 & 152 & 691 & 194 & 863 & 238 & 1043 \\
 2 & 83 &  19 & 223 &  37 & 371 &  56 & 527 &  76 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 & 371 &  28 & 527 &  38 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 & 371 &  {\color{red} 14} & 527 &  {\color{red} 19} & 691 &  97 & 863 & 119 & 1043
\end{array}
```

The square roots modulo $2^6 = 64$ are $7$, $25$, $39$, and $57$.  This only gives $39$ in our list, so we divide the corresponding number by $2$:

```{math}
\begin{array}{rrrrrrrrrrrrrrr}
33 & 34 &  35 &  36 &  37 &  38 &  39 &  40 &  41 &  42 &  43 &  44 &  45 &   46 \\
\hline
16 & 83 & 152 & 223 & 296 & 371 & 448 & 527 & 608 & 691 & 776 & 863 & 952 & 1043 \\
 8 & 83 &  76 & 223 & 148 & 371 & 224 & 527 & 304 & 691 & 388 & 863 & 476 & 1043 \\
 4 & 83 &  38 & 223 &  74 & 371 & 112 & 527 & 152 & 691 & 194 & 863 & 238 & 1043 \\
 2 & 83 &  19 & 223 &  37 & 371 &  56 & 527 &  76 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 & 371 &  28 & 527 &  38 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 & 371 &  14 & 527 &  19 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 & 371 &   {\color{red} 7} & 527 &  19 & 691 &  97 & 863 & 119 & 1043
\end{array}
```

The square roots modulo $2^7 = 128$ are $7$, $57$, $71$, and $121$, but no number in our list is congruent to any of these modulo $128$, so we move on to the next prime, $p=3$.

We have that $N \equiv 2 \pmod{3}$, and hence not a square.  So, we move to $p=5$.  But $N \equiv 3 \pmod{5}$, also not a square.  We then try $7$, and $N \equiv 2 \pmod{7}$, which *is* a square!  The square roots are $3$ and $4$.  The numbers in our list which are congruent to $3$ modulo $7$ are $38$ and $45$, and the ones congruent to $4$ are $39$ and $46$.  We divide the corresponding numbers in our list by $7$:

```{math}
\begin{array}{rrrrrrrrrrrrrrr}
33 & 34 &  35 &  36 &  37 &  38 &  39 &  40 &  41 &  42 &  43 &  44 &  45 &   46 \\
\hline
16 & 83 & 152 & 223 & 296 & 371 & 448 & 527 & 608 & 691 & 776 & 863 & 952 & 1043 \\
 8 & 83 &  76 & 223 & 148 & 371 & 224 & 527 & 304 & 691 & 388 & 863 & 476 & 1043 \\
 4 & 83 &  38 & 223 &  74 & 371 & 112 & 527 & 152 & 691 & 194 & 863 & 238 & 1043 \\
 2 & 83 &  19 & 223 &  37 & 371 &  56 & 527 &  76 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 & 371 &  28 & 527 &  38 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 & 371 &  14 & 527 &  19 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 & 371 &   7 & 527 &  19 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 &  {\color{red} 53} &   {\color{red} 1} & 527 &  19 & 691 &  97 & 863 &  {\color{red} 17} &  {\color{red} 149}
\end{array}
```

Now, using Hensel's Lemma, we have that $17$ and $32$ are square roots modulo $7^2 = 49$, but we have no elements in our list congruent to those, so we move to the next prime, $p = 11$.  But $N$ is not a square modulo $11$, nor modulo $13$, but it is modulo $17$.  The square roots modulo $17$ are $6$ and $11$.  The only elements congruent to $6$ modulo $17$ in our list is $40$ and the only one congruent to $11$ is $45$.  We divide the corresponding numbers:

```{math}
\begin{array}{rrrrrrrrrrrrrrr}
33 & 34 &  35 &  36 &  37 &  38 &  39 &  40 &  41 &  42 &  43 &  44 &  45 &   46 \\
\hline
16 & 83 & 152 & 223 & 296 & 371 & 448 & 527 & 608 & 691 & 776 & 863 & 952 & 1043 \\
 8 & 83 &  76 & 223 & 148 & 371 & 224 & 527 & 304 & 691 & 388 & 863 & 476 & 1043 \\
 4 & 83 &  38 & 223 &  74 & 371 & 112 & 527 & 152 & 691 & 194 & 863 & 238 & 1043 \\
 2 & 83 &  19 & 223 &  37 & 371 &  56 & 527 &  76 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 & 371 &  28 & 527 &  38 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 & 371 &  14 & 527 &  19 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 & 371 &   7 & 527 &  19 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 &  53 &   1 & 527 &  19 & 691 &  97 & 863 &  17 &  149 \\
 1 & 83 &  19 & 223 &  37 &  53 &   1 &  {\color{red} 31} &  19 & 691 &  97 & 863 &   {\color{red} 1} &  149
\end{array}
```

The square roots modulo $17^2$ are $28$ and $261$, but neither has representatives in our list.  So, we move on to our next, and last, prime, $p=19$.  $N$ is a square modulo $19$, with roots $3$ and $16$.  This gives only $41$ and $35$, and we divide the corresponding elements in our list by $19$:


```{math}
\begin{array}{rrrrrrrrrrrrrrr}
33 & 34 &  35 &  36 &  37 &  38 &  39 &  40 &  41 &  42 &  43 &  44 &  45 &   46 \\
\hline
16 & 83 & 152 & 223 & 296 & 371 & 448 & 527 & 608 & 691 & 776 & 863 & 952 & 1043 \\
 8 & 83 &  76 & 223 & 148 & 371 & 224 & 527 & 304 & 691 & 388 & 863 & 476 & 1043 \\
 4 & 83 &  38 & 223 &  74 & 371 & 112 & 527 & 152 & 691 & 194 & 863 & 238 & 1043 \\
 2 & 83 &  19 & 223 &  37 & 371 &  56 & 527 &  76 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 & 371 &  28 & 527 &  38 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 & 371 &  14 & 527 &  19 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 & 371 &   7 & 527 &  19 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 &  53 &   1 & 527 &  19 & 691 &  97 & 863 &  17 &  149 \\
 1 & 83 &  19 & 223 &  37 &  53 &   1 &  31 &  19 & 691 &  97 & 863 &   1 &  149 \\
 1 & 83 &   {\color{red} 1} & 223 &  37 &  53 &   1 &  31 &   {\color{red} 1} & 691 &  97 & 863 &   1 &  149
\end{array}
```

The square roots of $N$ modulo $19^2$ are $60$ and $301$, but no element in our list is congruent to either of those modulo $19^2$.  Hence, we are done and to find the the list of $a$'s which are such that the reduction modulo $N$ of $a^2$ are $19$-smooth, we take the numbers corresponding to the numbers ending with $1$:

```{math}
\begin{array}{rrrrrrrrrrrrrrr}
{\color{blue} 33} & 34 &  {\color{blue} 35} &  36 &  37 &  38 &  {\color{blue} 39} &  40 &  {\color{blue} 41} &  42 &  43 &  44 &  {\color{blue} 45} &   46 \\
\hline
{\color{blue} 16} & 83 & {\color{blue} 152} & 223 & 296 & 371 & {\color{blue} 448} & 527 & {\color{blue} 608} & 691 & 776 & 863 & {\color{blue} 952} & 1043 \\
 8 & 83 &  76 & 223 & 148 & 371 & 224 & 527 & 304 & 691 & 388 & 863 & 476 & 1043 \\
 4 & 83 &  38 & 223 &  74 & 371 & 112 & 527 & 152 & 691 & 194 & 863 & 238 & 1043 \\
 2 & 83 &  19 & 223 &  37 & 371 &  56 & 527 &  76 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 & 371 &  28 & 527 &  38 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 & 371 &  14 & 527 &  19 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 & 371 &   7 & 527 &  19 & 691 &  97 & 863 & 119 & 1043 \\
 1 & 83 &  19 & 223 &  37 &  53 &   1 & 527 &  19 & 691 &  97 & 863 &  17 &  149 \\
 1 & 83 &  19 & 223 &  37 &  53 &   1 &  31 &  19 & 691 &  97 & 863 &   1 &  149 \\
 {\color{blue} 1} & 83 &   {\color{blue} 1} & 223 &  37 &  53 &   {\color{blue} 1} &  31 &   {\color{blue} 1} & 691 &  97 & 863 &   {\color{blue} 1} &  149
\end{array}
```


Hence, we have the following $a$'s: $33, 35, 39, 41, 45$; and their corresponding $19$-smooth $c$'s (their squares reduced modulo $N$): $16, 152, 448, 608, 952$:
```{math}
\begin{align*}
33^2 &\equiv 16 = 2^4 \pmod{1073}, \\
35^2 &\equiv 152 = 2^3 \cdot 19 \pmod{1073}, \\
39^2 &\equiv 448 = 2^6 \cdot 7 \pmod{1073}, \\
41^2 &\equiv 608 = 2^5 \cdot 19 \pmod{1073}, \\
45^2 &\equiv 952 = 2^3 \cdot 7 \cdot 17 \pmod{1073}.
\end{align*}
```

We can now do the process of elimination.  In this case, for instance, we have:
```{math}
(35 \cdot 41)^2 \equiv (2^4 \cdot 19)^2 \pmod{1073}.
```
We then compute
```{math}
\gcd(1073, 35 \cdot 41 - 2^4 \cdot 19) = 29.
```
And indeed, $29$ is a factor of $1073$:

```{code-cell} ipython3
divmod(1073, 29)
```

So, we've factored $1073$ as $29 \cdot 37$.


:::{admonition} Homework
:class: note

You will implement the algorithm in your homework.
:::

+++

(sec-index-calc)=
## Index Calculus

Here we introduce the most efficient method to solve the *Discrete Log Problem* (in the context we introduced here):

:::{prf:definition} The Discrete Log Problem
:label: def-dlp-2


We call the (computationally intensive) problem of computing a discrete log $\log_g(a)$, i.e., finding a power $x$ (in $\mathbb{Z}/|a|\mathbb{Z}$) such that $g^x = a$ in $\mathbb{Z}/m\mathbb{Z}$, the *discrete log problem (DLP)*.
:::

As in the context of the ElGamal cryptosystem, we take the modulus $m$ to be a prime $p$ and the base $g$ to be a primitive root in $\mathbb{F}_p$.   Suppose we want then to compute $\log_g(h)$, i.e., find a power $x$ such that $g^x = h$ in $\mathbb{F}_p$.

+++

### General Computation

The idea is the following: let $B$ be a positive number and $\ell_1, \ell_2, \ldots , \ell_n$ be all primes less than or equal to $B$.  Then, we solve (with a method to be described below):
```{math}
\log_g(\ell_1), \quad \text{for $i=1, 2, \ldots, n$.}
```
Then, we compute $h \cdot g^{-k}$ (in $\mathbb{F}_p$) for $k=0, 1, 2, \ldots$ until the result is $B$-smooth.  This has to eventually happen, since these values will run over all elements of $\mathbb{F}_p^{\times}$.  So, we have:
```{math}
h \cdot g^{k} = \ell_1^{r_1} \cdot \ell_2^{r_2} \cdots \ell_n^{r_n}
```
for some positive integers $r_1, r_2, \ldots , r_n$.

Taking $\log_g$ on the left-side, we get
```{math}
\log_g(h \cdot g^{-k}) = \log_g(h) + \log_{g}(g^{-k}) = \log_g(h) - k,
```
while the log of the right-side is
```{math}
\log_g(\ell_1^{r_1} \cdot \ell_2^{r_2} \cdots \ell_n^{r_n}) = \log_g(\ell_1^{r_1}) + \log_g(\ell_2^{r_2}) + \cdots + \log_g(\ell_n^{r_n}) = r_1 \log_g(\ell_1) + r_2\log_g(\ell_2) + \cdots + r_n \log_g(\ell_n).
```
Putting these last two equations together, we get:
```{math}
:label: eq-index-calc1

\log_g(h) = k + r_1 \log_g(\ell_1) + r_2\log_g(\ell_2) + \cdots + r_n \log_g(\ell_n).
```
On the left we have what we want to compute, while on the right all terms are known!

+++

#### Example

Let's illustrate the process with a concrete example: we take $p = 32051$.

```{code-cell} ipython3
p = 32051
is_prime(p)
```

We have that $g = 10$ is a primitive element:

```{code-cell} ipython3
g = Mod(10, p)
g.multiplicative_order() == p - 1
```

Let's then find the discrete log base $g = 10$ of $h = 1205$ in $\mathbb{F}_{32051}$.

```{code-cell} ipython3
h = Mod(1205, p)
```

We will use $B = 19$ with our method.  Let's save the corresponding primes in the `primes` list.

```{code-cell} ipython3
B = 19
B_primes = prime_range(B + 1)
B_primes
```

Our first steps is to compute $\log_g(\ell)$ for all primes $\ell \leq B$.  We will learn below how to do that in an efficient way, but here we will simply use Sage's `discrete_log` function.  (You will do the same in your homework!)

```{code-cell} ipython3
logs_B = [discrete_log(Mod(l, p), g) for l in B_primes]
logs_B
```

Now, we first check if $h$ is $B$-smooth.

:::{important}

We should not use `factor` to check if a number `n` is $B$-smooth.  The proper way would be

```python
n == prod(p^valuation(n, p) for p in primes(B + 1))
```

On the other hand, in the present case, we not only need to determine if numbers are $B$-smooth, but also need the corresponding prime factorization.  Therefore, we save the exponents (i.e., the `valuation(n, p)`) in a list to obtain the corresponding factorization in the $B$-smooth case.
:::

```{code-cell} ipython3
element = ZZ(h)  # convert to an integer
powers = [valuation(element, l) for l in B_primes]  # powers
element == prod(l^r for l, r in zip(B_primes, powers))  # is it B-smooth?
```

So, $h$ is not $B$-smooth.  We then try $h \cdot g^{-1}$:

```{code-cell} ipython3
g_inv = g^(-1)  # compute it only once!
element = ZZ(h * g_inv)
powers = [valuation(element, l) for l in B_primes]
element == prod(l^r for l, r in zip(B_primes, powers))
```

Since it is not $B$-smooth, we try $h \cdot g^{-2}$:

```{code-cell} ipython3
element = ZZ(element * g_inv)
powers = [valuation(element, l) for l in B_primes]
element == prod(l^r for l, r in zip(B_primes, powers))
```

We keep trying $h \cdot g^{-3}, h \cdot g^{4}, \ldots$ until we find a $B$-smooth one:

```{code-cell} ipython3
element = ZZ(element * g_inv)  # i = -3
powers = [valuation(element, l) for l in B_primes]
element == prod(l^r for l, r in zip(B_primes, powers))
```

```{code-cell} ipython3
element = ZZ(element * g_inv)  # i = -4
powers = [valuation(element, l) for l in B_primes]
element == prod(l^r for l, r in zip(B_primes, powers))
```

```{code-cell} ipython3
element = ZZ(element * g_inv)  # i = -5
powers = [valuation(element, l) for l in B_primes]
element == prod(l^r for l, r in zip(B_primes, powers))
```

Ah, so $h \cdot g^{-5}$ is $B$-smooth.  According to [](#eq-index-calc1), we have that the discrete log $\log_g(h)$ is:

```{code-cell} ipython3
disc_log = (5 + sum(r * log_l for r, log_l in zip(powers, logs_B))) % (p - 1)
disc_log
```

And we can double check it with Sage:

```{code-cell} ipython3
g^disc_log == h
```

:::{admonition} Homework
:class: note

You will implement this algorithm in your homework.
:::

+++

### Discrete Logs of Small Primes

So, how can we efficiently compute $\log_g(\ell_1), \log_g(\ell_2), \ldots, \log_g(\ell_n)$?

The idea is to choose some *random* exponents $a \in \mathbb{Z}/(p-1)\mathbb{Z}$ and compute $g^{a}$.  If the result is $B$-smooth, we save it in a list, if not, we discard it and try another random $a$.  We repeat this process until we have enough $B$-smooth powers of $g$.  We need at least $\pi(B)$ (i.e., the number of primes less than or equal to $B$, which we denoted by $n$ here) distinct powers of $g$.

So, assume that we have powers $a_1, a_2, \ldots, a_m$ (for some $m \geq n = \pi(B)$), with $g^{a_i}$ $B$-smooth, say:
```{math}
\begin{align*}
g^{a_1} &= \ell_1^{r_{1,1}} \cdot \ell_2^{r_{1,2}} \cdots \ell_n^{r_{1,n}} \\
g^{a_2} &= \ell_1^{r_{2,1}} \cdot \ell_2^{r_{2,2}} \cdots \ell_n^{r_{2,n}} \\
& \;\; \vdots \\
g^{a_m} &= \ell_1^{r_{m,1}} \cdot \ell_2^{r_{m,2}} \cdots \ell_n^{r_{m,n}}
\end{align*}
```

Taking $\log_g$, we obtain
```{math}
\begin{align*}
a_1 &= r_{1,1} \log_g(\ell_1) + r_{1,2} \log_g(\ell_2) + r_{1,n} \log_g(\ell_n) \\
a_2 &= r_{2,1} \log_g(\ell_1) + r_{2,2} \log_g(\ell_2) + r_{2,n} \log_g(\ell_n) \\
& \;\; \vdots \\
a_m &= r_{m,1} \log_g(\ell_1) + r_{m,2} \log_g(\ell_2) + r_{m,n} \log_g(\ell_n)
\end{align*}
```

Note that all the $a_i$'s and $r_{i,j}$'s are known, and we are trying to find the $\log_g(\ell_j)$'s.  These should be then the solution of the system
```{math}
\begin{align*}
a_1 &= r_{1,1} x_1 + r_{1,2} x_2 + r_{1,n} x_n \\
a_2 &= r_{2,1} x_1 + r_{2,2} x_2 + r_{2,n} x_n \\
& \;\; \vdots \\
a_m &= r_{m,1} x_1 + r_{m,2} x_2 + r_{m,n} x_n
\end{align*}
```
with $x_j$ found being $\log_g(\ell_j)$.  So, we just need to solve this system!

:::{admonition} Homework
:class: note

In your homework you will write the code to obtain the *matrix of coefficients* of the system above.  This basically means a list containing the rows of the system (which is itself another list).  But you will not implement the solution of the system.

:::


But there is a problem: the coefficients (since they are all exponents) are in $\mathbb{Z}/(p-1)\mathbb{Z}$, which is not a *field* (like the real numbers or $\mathbb{F}_p$), so solving the system is not as straight forward.  But it still can be done, and here is the (vague) idea on how to do it:

1) For each prime factor $q$ of $p-1$, we solve the system modulo $q$ (i.e., in the field $\mathbb{F}_q$, where our methods for solving systems work well).
2) If $q^s$ is the largest power of $q$ dividing $p-1$, then we "lift" the solution we've found (modulo $q$) to a solution modulo $q^n$.  (The method to do this is similar to {prf:ref}`th-hl-sqrt-odd` or {prf:ref}`th-hl-sqrt-2`.)
3) We use the {prf:ref}`Chinese Remainder Theorem <th-crt>` to "patch" these solutions to a solution modulo $p-1$.  More precisely, if $p-1 = q_1^{s_1} q_2^{s_2} \cdots q_t^{s_t}$, and if we've obtained $x_i \equiv b_{i,j} \pmod{q_j^{s_j}}$ for $j = 1, 2, \ldots, t$, solving
```{math}
\begin{align*}
x_i &\equiv b_{i,1} \pmod{q_1^{s_1}} \\
x_i &\equiv b_{i,2} \pmod{q_2^{s_2}} \\
& \;\; \vdots \\
x_i &\equiv b_{i,t} \pmod{q_t^{s_t}}
\end{align*}
```
(with the Chinese Remainder Theorem) we obtain the solution $\log_g(\ell_i)$ (in $\mathbb{Z}/(p-1)\mathbb{Z}$).


:::{important}

Step 1 might be difficult!  So, with ElGamal we want $p-1$ to not have small prime factors other than $2$, to make this process as difficult as possible.  Again, the ideal is to have $(p-1)/2$ to be prime.
:::


:::{note}

One can generalize the discrete log and ElGamal cryptosystem by replacing $\mathbb{F}_p^{\times}$ with an arbitrary [group](https://en.wikipedia.org/wiki/Group_(mathematics)).  (We will do this in a [later chapter](#sec-ec_crypto).)  While our previous methods for computing the discrete log (e.g., [*Shanks Babystep-Giantstep*](#sec-bsgs), [*Pohlig-Hellman*](#sec-pohlig-hellman)) generalize for arbitrary groups, this index calculus algorithm (introduced here) does *not*.  Since it is the faster than the previous methods, to make ElGamal more secure, one can use different groups instead of $\mathbb{F}_p^{\times}$.
:::
