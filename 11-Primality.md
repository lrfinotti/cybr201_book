---
jupytext:
  formats: ipynb,sage:percent,md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.17.0
kernelspec:
  display_name: SageMath 10.5
  language: sage
  name: sage-10.5
---

---
math:
  '\F': '\mathbb{F}'
  '\Fpt': '\F_p^{\times}'

abbreviations:
  GRH: Generalized Riemann Hypothesis
---

+++

# Primality Testing

The only *know* way to break RSA's security if by factoring $N = pq$, where $p$ and $q$ are very large primes.  But before we can even try to factor a number, we need an efficient way to test if a number is prime.

## Applying Fermat's Little Theorem

Remember that we have:

:::{prf:theorem} Fermat's Little Theorem
:label: th-flt
:numbered: true

If $p$ is prime and $p \nmid a$, then $a^{p-1} = 1$ in $\Z/p\Z$ (i.e., $a^{p-1} \equiv 1 \pmod{p}$).  In particular, for any integer $a$, we have that $a^p = a$ in $\Z/p\Z$.
:::

(This is a consequence of [Euler's Theorem](./05-Powers.md#th-euler).)

We can use Fermat's Little Theorem try to check if a number is prime or composite:

:::{prf:algorithm} Fermat's Little Theorem Compositeness Test
:label: al-flt
:numbered: true

To test if $n$ is *composite*:

1) Take a random integer $a \in \{ 2, 3, \ldots, (n-1) \}$.
2) If $a^n \neq a$ (in $\Z/n\Z$), then $n$ is **composite** (and we are done).  (This $a$ would be a *witness for the compositeness of $n$*.)
3) If $a^n = a$, then the test is **inconclusive**, but we can repeat the steps to try again.
:::

Note that a single application of this algorithm (i.e., for one choice of $a$) is fast, since Fast Powering is quite efficient.

+++

### Example

Let's illustrate it with an example: let's take $n = 8{,}704{,}201$.

```{code-cell} ipython3
n = 8704201
```

Let's test $a=2$:

```{code-cell} ipython3
Mod(2, n)^n
```

Since we did not get $2$, this $n$ is *not* prime!  (Note that we were very lucky here by finding such a small witness!  Witnesses can be very large, in general.)

+++

### Carmichael Numbers

Again, our algorithm only can tell us, in some cases, when some $n$ is composite.  On the other hand, if it is true that the *only* way that $a^n = a$ for *all* $a \in \Z/n\Z$ is for $n$ to be prime, we can repeat the algorithm for $a = 1, 2, 3, \ldots , (n-1)$, and if we *never* found that $n$ was composite, we would know that $n$ is prime.

Of course, the first problem is that, when $n$ is large, this would very time consuming.  But even worse, that is not true:

```{code-cell} ipython3
n = 3 * 11 * 17

for a in srange(2, (n-1)):
    if Mod(a, n)^n != Mod(a, n):
        print(f"{a} is a witness for the compositeness of {n}.")
        break
else:
    print("No witnees found.")
```

Clearly $561 = 3 \cdot 7 \cdot 11$ is not prime, and yet, we have no witness for its compositeness.  So, [](#al-flt) is far from ideal, as it can never guarantee primality.  But it does illustrate a point: *we could, at least in cases, find when a number is **not** prime, without factoring!*

:::{prf:definition} Carmichael Number
:label: def-carmichael
:numbered: true

A *composite* integer $n > 2$ is a *Carmichael number* if $a^n = a$ in $\Z/n\Z$ for all $a \in \Z$.  (So, $n$ is composite, but there is no witness for its compositeness.)
:::

:::{admonition} Homework
:class: note

In your homework you will write a function to test if a number is either composite of a Carmichael number using [](#al-flt).
:::

:::{note}

Mathematicians proved that there *infinitely* many Carmichael numbers, but they are rare.
:::


## The Miller-Rabin Test

Our previous attempt on primality testing was not successful, but the idea is an important one: test primality without factoring!  We now introduce a similar method that can provide a very efficient (probabilistic) primality test.  It's based on the following mathematical result:

:::{prf:theorem}
:label: th-mr
:numbered: true

Let $p>2$ be a prime, let $p-1=2^kq$, with $q$ odd, and $a$ an integer not divisible by $p$.  Then, either:
1) $a^q = 1$ in $\Z/p\Z$, or
2) at least one among $a^q, a^{2q}, a^{4q}, a^{8q}, \ldots, a^{2^{k-1}q}$ is equal to $-1$ in $\Z/p\Z$.
:::

:::{prf:proof}
:numbered: false

First note that $b^2 = 1$ in $\Z/p\Z$ if and only if $p \mid (b^2 -1) = (b-1)(b+1)$.  Since $p$ is prime, this true if and only if $p$ divides either $b-1$ or $b + 1$, i.e., if and only if $b$ is either $1$ or $-1$ in $\Z/p\Z$.

Since $p$ is prime and $p \nmid a$, we have by [{name}](#th-flt) we know that
$$
\left( a^{2^{k-1}q} \right)^2 =  a^{2^kq} = a^{p-1} = 1 \quad \text{(in $\Z/p\Z$)}.
$$
Thus, we have that $a^{2^{k-1}q}$ is either $1$ or $-1$.  If $-1$, we are in case 2.  If $1$, we can repeat and have
$$
\left( a^{2^{k-2}q} \right)^2 =  a^{2^{k-1}q} =  1,
$$
and hence $a^{2^{k-2}q}$ is either $1$ or $-1$.  By repeating this process, we either have that some $a^{2^i q} = -1$, or we arrive at the last step with $a^q$ as either $1$ (and we would be in case 1) or $-1$ (and we would be in case 2).
:::

:::{important}

[](#th-mr) tells us that $p$ is prime, then one of the two conditions must be true.  It does **not** say that if a number $p$  satisfies both conditions, then $p$ must be prime.
:::

For example, if $n = 7^2 = 49$ (not prime and odd), and $a=18$: we have that $48 = 2^4 \cdot 3$, so $k=4$ and $q=3$.  Then, $a^q = 1$:

```{code-cell} ipython3
Mod(18, 49)^3
```

Hence, even though $n = 49$ is not prime, we have $a = 18$ satisfies the first condition of [](#th-mr).

+++

Let's introduce some useful terminology:

:::{prf:definition} Miller-Rabin Witness
:label: def-mr_witness
:numbered: true

Let $n$ be an odd, positive integer, and write $n = 2^{k}q$, with $q$ odd.  If $a$ is an integer such that

1) $\gcd(a, n) = 1$,
2) $a^q \neq 1$ in $\Z/n\Z$,
3) and $a^{2^iq} \neq -1$ for all $i \in \{ 0, 1, \ldots, (k-1) \}$,

then $n$ is composite and we call $a$ a *Miller-Rabin witness for the compositeness of $n$*.
:::

Note that $a$ as above tells us that $n$ is composite, since if it were prime, by [](#th-mr), either item 2 or item 3 of the definition would have to be false.

[](#th-mr) gives the following test:

:::{prf:algorithm} Miller-Rabin Compositeness Test
:label: al-mr
:numbered: true

Let $n > 2$ be a integer (to be testes for compositeness) and $a \in \{ 2, 3 ,\ldots, (n-1) \}$ (a potential witness), which we see as an element of $\Z/n\Z$.

1) If $n > 2$ and even, or if $\gcd(a, n) > 1$, then $n$ is **composite**.
2) If not, find $k$ and $q$ such that $n-1 = 2^k$, with $q$ odd.
3) Initialize $b \leftarrow a^q$ (in $\Z/n\Z$).
4) If $b=1$, then the test **fails** (it is inconclusive and we can stop here).
5) If $b \neq 1$, the for $i = 0, 1, 2, \ldots, (k-1)$ we:
   1) If $b=-1$, then the test **fails**.
   2) If $b \neq -1$, then set $b \leftarrow b^2$ and try next $i$.
6) If finish the loop without failing, then $n$ is **composite** and $a$ is a Miller-Rabin witness.
:::

:::{note}

The [Miller-Rabin](https://en.wikipedia.org/wiki/Miller%E2%80%93Rabin_primality_test) was first devised by [G.L. Miller](https://en.wikipedia.org/wiki/Gary_Miller_(professor)) in 1976 and then improved by [M.O. Rabin](https://en.wikipedia.org/wiki/Michael_O._Rabin) in 1980.
:::

+++

### Number of Operations

The algorithm, for a single $a$, is very efficient.  We need to use the Euclidean Algorithm, which is fast.  Then, we only need to compute at most $\log_2(n-1)$ products in $\Z/n\Z$.

+++

### Why Does It Work?

It is easy to see why the algorithm works.  Since we take $a \in \{2, 3, \ldots, (n-1)\}$, if $\gcd(a, n) > 1$, it is a divisor of $n$ between $2$ and $n-1$, so $n$ is composite.

Then, we start with $b=a^q$.  If $b=1$, then $n$ could be a prime, as it is a possibility in [](#th-mr), so we stop here and failed to decide if $n$ is prime or not.  (Prime and composite are possible.)

Now, if $b \neq 1$, then the values of $b$ we have in the algorithm run through $a^q$ (when $i=0$),  $\left( a^q \right)^2 =  a^{2q}$ (when $i=1$), $\left( a^{2q} \right)^2 = a^{4q}$ (when $i=2$), and so on, until at most $ \left( a^{2^{k-2}q} \right)^2 = a^{2^{k-1}q}$.  If $p$ is prime, by [](#th-mr), one of these *must* be equal to $-1$.  So if that is the case, we failed, and $n$ could be prime or composite.

But, if we do not get a $-1$ after running through the whole loop, then $n$ *cannot* be prime, again by [](#th-mr), so $n$ must be composite.

+++

### Example

Let's try the Miller-Rabin test with the Carmichael number $n = 561 = 3 \cdot 7 \cdot 11$.  We know it to be composite, but [](al-flt) would not be able to determine it.

```{code-cell} ipython3
n = 3 * 11 * 17
```

Now, we need to choose a candidate to witness.  Let's start with something simple, $a = 2$ (in $\Z/n\Z$):

```{code-cell} ipython3
a = Mod(2, n)
```

The first step is to compute $\gcd(a, n) = \gcd(2, 561)$.  But, since $561$ is odd, the GCD is clearly equal to $1$.

Now, for the second step, we need to find $k$ and $q$ such that $n - 1 = 2^k q$.  Note that $k$ is simply the number of times that $2$ divides $n-1$.  We know it is at least one, since $n$ is odd.  We could compute it with a simple loop, but Sage has a tool for that task already.  The function `valuation(n, p)` returns how many times the prime `p` divides the integer `n`.

```{code-cell} ipython3
k = valuation(n - 1, 2)
k
```

With $k$ in hand, we can find $q$:

```{code-cell} ipython3
q = (n - 1) // 2^k  # exact division, q odd
q
```

We then initialize $b$ (step 3):

```{code-cell} ipython3
b = a^q
b
```

Next (step 4), we see if $b = 1$, but we can see above it is not.

Then, we move to our loop (step 5).  For $i = 0$, we check if $b = -1$.

```{code-cell} ipython3
# i = 0
b == Mod(-1, n)
```

Since it is not, we update the value of $b$ by squaring it:

```{code-cell} ipython3
b = b^2
```

Then, we move to the next $i$:

```{code-cell} ipython3
# i = 1
b == Mod(-1, n)
```

Since $b$ is not $-1$, we update $b$:

```{code-cell} ipython3
b = b^2
```

And move on to the next $i$:

```{code-cell} ipython3
# i = 2
b == Mod(-1, n)
```

Again, update and move on:

```{code-cell} ipython3
b = b^2

# i = 3
b == Mod(-1, n)
```

Still not equal.  But now we have $i = k - 1 = 3$, so we can stop here.  (There is no need to update the value of $b$ in this case.)  Since we finish the loop without failing, we have that $n$ is *composite*!


:::{admonition} Homework
:class: note

As usual, you will implement this algorithm in your homework.
:::

+++

### Proportion of Witnesses

At first glance, this looks a lot like [](#al-flt), in the sense that it can only detect compositeness in some cases.  So, one might also wonder if there $n$ that are similar to Carmichael numbers, in the sense, that $n$ is composite, but no $a \in \{2, 3, \ldots, (n-1)\}$ is a Miller-Rabin witness for its compositeness.  But in fact, there is *not*!

:::{prf:theorem} Miller-Rabin Witnesses
:label: th-mr_witness
:numbered: true

If $n$ is an odd, composite number, at least three quarters of $a \in \{2, 3, \ldots, (n-1)\}$ are Miller-Rabin witnesses.
:::

:::{admonition} Homework
:class: note

The proportion of Miller-Rabin witnesses is often even larger than $3/4$, in fact most of the times it is larger than $7/8$.  In your homework you will write code to test if some $a$ is a Miller-Rabin is a witness for the compositeness of $n$ and check what sort of proportions we get in practice.
:::


So, we are guaranteed the existence of witnesses for composite numbers.  This makes it possible to make the Miller-Rabin test *deterministic* (meaning, that it can *always* tell us whether $n$ is prime or composite), by simply checking all $a\in \{2, 3, \ldots, (n-1)\}$.  If we find a witness we can stop and know that $n$ is composite, and if we run through the whole set and find no witness, then $n$ is prime.  Unfortunately, the whole process is very time consuming.

Note that we can improve it, as we only need to test $a \in \{ 2, 3, \ldots, \lceil n/4 \rceil\}$.  If none of these are witnesses, we would have fewer than three quarters of elements can be witnesses, which can only happen, by the theorem above, when $n$ is prime.  But, unfortunately, in practice that is still too large.

On the other hand, [](#th-mr_witness) tells us that if we pick some *random* $a$ and $n$ is composite, the probability that we pick a non-witness is less than $1/4$, so it is somewhat unlikely.  So, if we repeat whenever we do not get $a$ a Miller-Rabin witness, the probabilities multiply.  So, if we try $10$ different *random* $a$'s as possible witness and they all fail, if $n$ is composite the probability of this happening is less than
$$
\left( \frac{1}{4} \right)^{10} = \frac{1}{4^{10}} = \frac{1}{1{,}048{,}576}.
$$
so the chance that $n$ is composite is about *one in a million*!  If we do it $20$ times, and never find a witness, the probability that $n$ is composite is less than *one in a million **millions***!  That is practically $0$.  (And we can increase the number of tests even more if we want to be even more certain.)

Mathematicians will still not be convinced, but in practice this gives a very fast *probabilistic* algorithm for primality test!  This is, in fact, the most widely used primality test today.


:::{important}

Note that this method of repeating the Miller-Rabin test for different random potential witnesses will always be accurate when it returns that number is **composite**, since it means that it found a witness.  Only when it returns that the number is **prime** it is probabilistic, meaning that it is probably prime, but there is a small chance (if enough tries were used) that it is composite.
:::

:::{admonition} Homework
:class: note

You will implement this test in your homework.
:::




+++

### Deterministic Miller-Rabin

The [Generalized Riemann Hypothesis (GRH)](https://en.wikipedia.org/wiki/Generalized_Riemann_hypothesis) is a [conjecture](https://en.wikipedia.org/wiki/Conjecture) (i.e., a statement believed to be true, but for which there is still no mathematical proof) that relates to prime numbers.  Even stating it would be beyond the scope of this text, but it is one of the most important conjectures in all of Mathematics, and proving only a particular case, the (non-generalized )[Riemann Hypothesis](https://en.wikipedia.org/wiki/Riemann_hypothesis), one of the [Millennium Prize Problems](https://en.wikipedia.org/wiki/Millennium_Prize_Problems), would pay you a million dollars..

On the other hand, there is ample numerical and theoretical evidence that it is likely true, and many proved results in mathematics can be strengthened if we assume the GRH to be true.  One example allows us to use the Miller-Rabin test deterministically with far fewer tests:

:::{prf:theorem} Deterministic Miller-Rabin
:label: th-dmr
:numbered: true

If the GRH is true, then every composite, odd $n$ has a Miller-Rabin witness $a$ with $a \leq 2 (\log(n))^2$.
:::

This tells us that to *prove* that $n$ is composite, we only need to check $a \in \{2, 3, \ldots, \lfloor 2 (\log(n))^2 \rfloor \}$.  These the involve at most $\lfloor 2 (\log(n))^2 \rfloor - 1$ applications of the test.  For instance, if your number is about $10^{12}$ (one trillion), then we would need $1{,}526$ Miller-Rabin witness tests.  This is much slower than the probabilistic test, but it is deterministic.



## Distribution of Primes

If you take a random integer $a \in \{1, 2, 3, \ldots, N\}$ (for some upper bound $N$) the probability of it being prime is simply
$$
\frac{\text{Number of primes in $\{1, 2, 3, \ldots, N\}$}}{N}.
$$

So, let's introduce some (standard) notation:

:::{prf:definition} Number of Primes Function
:label: def-pi
:numbered: true

Let $x$ be a positive real number.  Then, $\pi(x)$ denotes the number of primes less than or equal to $x$.
:::

Hence, the probability above can be written simply as $\pi(N)/N$.

It is really hard to compute $\pi(x)$ exactly and number theorists have dedicated a considerable amount of work studying it.  Here is one of the most important results:

:::{prf:theorem} Prime Number Theorem
:label: th-pnt
:numbered: true

We have that
$$
\lim_{x \to \infty} \frac{\pi(x)}{x/\log(x)} = 1.
$$
(Here $\log(x)$ is the *natural log*, i.e., base $e$.)
:::

The theorem above is stated using Calculus, but what is basically says is that, for *very* large numbers $x$ we have that $\dfrac{\pi(x)}{x/\log(x)}$ is (relatively) close to $1$, or, $\pi(x)$ about "close" to $x/\log(x)$.

:::{table} $\pi(x)$ versus $x/\log(x)$ for Large $x$
:label: tb-pi
:align: center
:width: 70%

| $n$       | $\pi(n)$               | $n / \log(n)$             |
|-----------|------------------------|---------------------------|
| $10^6$    | $78{,}498$             | $72{,}382.41$             |
| $10^9$    | $50{,}847{,}534$       | $48{,}254{,}942.43$       |
| $10^{12}$ | $37{,}607{,}912{,}018$ | $36{,}191{,}206{,}825.27$ |
:::

:::{note}

Note that these numbers are *relatively* close, in the sense that although their differences are large numbers, they are small compared to the numbers themselves.  For instance, the difference for $n = 10^{12}$ is over one *billion*, but the difference is just about $3.77\%$ of the size of $\pi(10^{12})$.
:::

These numbers were computed using Sage's builtin `prime_pi` function:

```{code-cell} ipython3
prime_pi(10^12)
```

In particular, for large $N$, the probability that a random element between $1$ and $N$ is prime is
$$
\frac{\pi(N)}{N} \approx \frac{N / \log(N)}{N} = \frac{1}{\log(N)}.
$$
For instance, for $N = 10^{12}$, the probability would be about $3.62\%$.  Also, since it is about $1/\log(N)$, this probability gets smaller and smaller as $N$ grows, but *very* slowly.


:::{prf:example} Number of Primes between $9 \cdot 10^5$ and $10^6$
:numbered: true

Estimate the number of primes between $9 \cdot 10^5$ and $10^6$.
:::

The number is
$$
\pi(10^6) - \pi(9 \cdot 10^5) \approx \frac{10^6}{\log(10^6)} - \frac{9 \cdot 10^5}{\log(9 \cdot 10^5)}:
$$

```{code-cell} ipython3
numerical_approx(10^6/log(10^6) - (9 * 10^5)/log(9 * 10^5))
```

The exact number is:

```{code-cell} ipython3
prime_pi(10^6) - prime_pi(9 * 10^5)
```

## Finding a Random Prime

Suppose we want to find a random $1024$-bit prime, i.e., a prime $p$ such that $2^{1023} < p < 2^{1024}$.  There are about
$$
\frac{2^{1024}}{1024 \cdot \log(2)} - \frac{2^{1023}}{1023 \cdot log(2)} \approx 1.26 \cdot 10^{305}
$$
such primes.  That is a lot, but the range is also huge: the probability that a random element in the range is prime is about $0.14\%$.  So, if we pick about $(0.0014)^{-1} \approx 714$ random elements in the range, there is a good change one of them will be prime.  (We can test them using Miller-Rabin.)

But we can do better!  For instance, we can avoid multiples of, say, $2$, $3$, $5$, $7$, and $11$.  Here is one way of doing it: pick a number relatively prime to $2 \cdot 3 \cdot 5 \cdot 7 \cdot 11 = 2310$, e.g., $1139$.

```{code-cell} ipython3
gcd(2310, 1139)
```

Then, for any integer $k$, the number $N = 2310 \cdot k + 1139$ is relatively prime to $2310$, as by the Euclidean Algorithm (or, more precisely, by the idea behind it), we have
$$
\gcd(N, 2310) = \gcd(N - 2310 \cdot k, 2310) = \gcd(1139, 2310) = 1.
$$

Then, to choose a number in our range from $2^{1023}$ to $2^{1024}$, we simply pick $k$ in the range from $\lceil (2^{1023} - 1139)/2310 \rceil$ to $\lfloor (2^{1024} - 1139) / 2310 \rfloor$.

But how much doing this improve the probability of getting a random prime in the range?  The math behind is not complex, and involves basically solutions of systems of congruences modulo the given primes: we must have
\begin{align*}
x &\equiv 1 \pmod{2} \\
x &\equiv a_3 \pmod{3} \\
x & \equiv a_5 \pmod{5} \\
x &\equiv a_7 \pmod{7} \\
x &\equiv a_11 \pmod{11}
\end{align*}
where the $a_p$'s can be any choice between $1$ and $p-1$.  An analysis of the number of solutions gives that between $1$ and some large $N$, we have about
$$
N \cdot \frac{2-1}{2} \cdot \frac{3-1}{3} \cdot \frac{5-1}{5} \cdot \frac{7-1}{7} \cdot \frac{11-1}{11} \approx 0.21 \cdot N,
$$
numbers not divisible by $2$, $3$, $5$, $7$, or $11$.  So, the probability that a random number between $1$ and $N$ and not divisible by those primes is prime, is approximately
$$
\frac{\pi(N) - 4}{0.21 \cdot N} \approx  4.8 \cdot \frac{\pi(N) - 4}{N} \approx 4.8 \cdot \frac{1}{\log(N)}.
$$
In our example, using this method, we probably need to test only about $0.21 \cdot 714 \approx 150$ random numbers $k$ before we find a prime, instead of about $714$, a good improvement.

### Adding More Primes?

This is a very reasonable improvement.  Can we do better if we add more primes to the list?  We can, but not by much.  The problem is that every time we add a prime $p$ to our list of primes to avoid, we increase the probability that a random $k$ will give a prime by a factor of $p/(p-1)$.  As $p$ gets large, this number gets very close to $1$, so it does not make much of a difference.  So, if we avoid primes $2, 3, 5, \ldots, p_k$ (so $p_k$ is the largest prime in the list and we include all primes below it), the increase the probability by a factor of
$$
\frac{2}{1} \cdot \frac{3}{2} \cdot \frac{5}{4} \cdots \frac{p_k}{p_k - 1}.
$$
[](#tb-impr) shows the improvements obtained by going to $p_k$:

:::{table} Improvement Factors by Avoiding Primes Up to $p_k$
:align: center
:widths: auto
:width: 100 %
:name: tb-impr

| $p_k$      | Improvement Factor (Approximate) |
|------------|----------------------------------|
| $11$       | $4.8$                            |
| $13$       | $5.2$                            |
| $17$       | $5.5$                            |
| $19$       | $5.8$                            |
| $1{,}009$  | $12.3$                           |
| $10{,}007$ | $16.4$                           |
:::


:::{admonition} Homework
:class: note

You will implement this idea to get random primes in an interval in your homework.
:::
