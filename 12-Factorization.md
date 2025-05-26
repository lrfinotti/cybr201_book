---
jupytext:
  formats: ipynb,md:myst,sage:percent
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.17.1
kernelspec:
  name: sage-10.5
  display_name: SageMath 10.5
  language: sage
---

(ch-factorization)=
# Factorization

+++

## Naive Factorization

How can we find the prime factorization of a number $N$?  If one knows all the primes less than or equal to $N$, this is not so bad: we test each prime.  If it divides $N$ we see how many times it does, and save the both the prime and exponent.  We then keep dividing until we get $1$.  Here is an implementation of this process:

```{code-cell} ipython3
def naive_factor(n):
    """
    Given n returns the factiorization of n as a list of tuples (p, k),
    where p is prime, and k is the power of p dividing n.
    """
    factorization = []  # result
    p = 1  # initialized (not used)
    while n > 1:
        p = next_prime(p)  # prime
        k = 0  # exponent
        while n % p == 0:
            k += 1
            n /= p
        if k != 0:
            factorization.append((p, k))
    return factorization
```

Note that we've used Sage's `next_prime`.  If not using Sage, we would need to use some primality test, which can be time consuming, to find the next prime.  But note that this is a case in which a probabilistic test is fine: it might slow things down in the unlikely event that it gives a false positive, but it will not produce a fake prime factor.

Indeed, we would be testing element after element, so if some number $q$ is composite and the test has told us that it is prime, then $q$ will not divide the number, since it must be made of smaller prime factors that do not divide the number anymore at this point.

Thus, we would have an unnecessary division, but no error is introduced in the result.

+++

Let's test it in a couple of simple examples.

```{code-cell} ipython3
naive_factor(6)
```

```{code-cell} ipython3
naive_factor(17)
```

Now, let's run a more extensive test:

```{code-cell} ipython3
lower_bound = 2
upper_bound = 10^6

number_of_tests = 10^2
for _ in range(number_of_tests):
    n = randint(lower_bound, upper_bound + 1)
    factorization = naive_factor(n)
    m = prod(p^k for (p, k) in factorization)
    if n != m:
        print(f"Failed for {n = }.  Factorization given: {factorization}.")
else:
    print("It works!")
```

It seems to work, but if you run it you will likely see that it is slow.  Therefore, we need more efficient ways to factor large integers, specially if they only have large prime factors.

+++

(sec-pollards_p-1)=
## Pollard's $p-1$ Factorization Algorithm

The following idea and resulting algorithm were introduced by [J. Pollard](https://en.wikipedia.org/wiki/John_Pollard_(mathematician)) in 1974.

Suppose you want to factor $N = pq$, where $p$ and $q$ are very large distinct primes, as used with the RSA encryption.  Suppose that somehow we find an integer $L$ such that:

1) $L = (p - 1)i$, for some integer $i$, and so $p - 1$ divides $L$;
2) $L = (q - 1)j + k$, for integers $i$ and $k$, with $k \in \{ 1, 2, \ldots, (q-2) \}$, and so $q-1$ does *not* divide $L$.

Then, if $\gcd(a, N) = 1$, i.e., $a$ not divisible by either $p$ or $q$, then, by {prf:ref}`Fermat's Little Theorem <th-flt>` (or {prf:ref}`Euler's Theorem <th-euler>`):
```{math}
a^L = a^{(p-1)i} = \left( a^{p-1} \right)^i \equiv 1^i = 1 \pmod{p}
```
and
```{math}
a^L = a^{(q-1)j + k} = \left( a^{q-1} \right)^j \cdot a^k \equiv 1^j \cdot a^k = a^k \pmod{p}.
```

For a randomly chosen $a$ relatively prime to $pq$, we have that the probability that $a^k \not\equiv 1 \pmod{q}$ is high, and in this case we have that $p \mid a^L - 1$ and $q \nmid a^L - 1$, so $\gcd(a^L - 1, N) = \gcd(a^L, pq) = p$.  Using the Euclidean algorithm we can quickly compute this GCD and find $p$.  Dividing $N$ by $p$ we find $q$ and have factored $N$.

So, the question is really how do we find this $L$ (with the properties above)?  Here is Pollard's observation: if $p - 1$ is a product of *small primes only*, then $p-1$ divides $n!$ for some $n$ "not too large".  Then, if $\gcd(a, p) = 1$, we have that
```{math}
a^{n!} = \left( a^{p-1} \right)^{n!/(p-1)} \equiv 1^{n!/(p-1)} = 1 \pmod{p}
```
(noting that in this case $n!/(p-1)$ is an integer by assumption).

Hoping that $a^{n!} \not\equiv 1 \pmod{q}$, which can happen with a reasonable likelihood, as observed above, we can reduce $a^{n!}$ modulo $N$, obtaining, say, $r$, and then compute $\gcd(r, N)$.  If it is neither $1$ nor $N$, then this GCD is $p$, one the prime factors, and we can factor $N$.

Here is a possible procedure:

:::{prf:algorithm} Pollard's $p-1$ Factorization
:label: al-pollard


Given a composite integer $N$, we want to find a proper factor (i.e., a factor different from $1$ and $N$) of $N$.

1) Choose a bound $B$ for $n$ (as in the $n!$ above).
2) Initialize $a \leftarrow 2$ and $b \leftarrow a$.
3) For $j$ in $\{ 2, 3, \ldots, B \}$:
   1) Set $b$ as the reduction modulo $N$ of $b^j$.
   2) Compute $d = \gcd(b-1, N)$.
   3) If $d \neq 1, N$, then it is a factor, and we return it (and stop).  If not, go to the next iteration of the loop.
4) If the loop reaches $B$ with not success, increase $a$, avoiding perfect powers, e.g., going to the next prime, and repeat (from 2).
:::

First, observe that in step 3, we are computing $a^{j!}$, as the values of $b$ are:
```{math}
b \leftarrow a = a^{1!}, \quad b \leftarrow b^2 = a^2 = a^{2!}, \quad b \leftarrow b^3 = (a^2)^3 = a^{3!}, \quad b \leftarrow b^4 = (a^{3!})^4 = a^{4!}, \quad \text{etc.}
```


One can also try to reduce the number of operations: note that of $(p-1)$ divides $n!$, then it divides $m!$ for any $m > n$ (as $n!$ is then a factor of $m!$).  So, instead of computing $\gcd(b-1, N)$ at every step, we can do it at every $k$ steps, reducing the number of operations.  So, we would only compute $\gcd(a^{k!} - 1, N)$, $\gcd(a^{(2k)!} - 1, N)$, $\gcd(a^{(3k)!} - 1, N)$, etc.

The downside of this approach is that increases the chances that both $p-1$ and $q-1$ divide $a^{(rk)!}$, which we need to avoid.  But, if $k$ is not too large, this is not very likely and it might be worth the risk.

:::{admonition} Homework
:class: note

You will implement this algorithm in your [homework](#sec-hw7).
:::

+++

### Number of Operations

If we perform the powers in the algorithm using {prf:ref}`Fast Powering <al-fast_power>`, the products in the loop will require, at worst,

```{math}
\begin{align*}
(2 \log_2(2) + 2) &+ (2 \log_2(3) + 2) + \cdots + (2 \log_2(B) + 2) \\
&= 2 (\log_2(2) + \log_2(3) + \cdots + \log_2(B)) + 2B - 2 \\
&= 2 \log_2(B!) + 2B - 2
\end{align*}
```

products.  So, indeed, this $B$ cannot be large!

We also need $B$ computations of GCDs, and this will require, in the original algorithm, at most
```{math}
(B-1) \cdot (2 \log_2(N) + 2)
```
long divisions.  If we skip in step-sizes of $k$, as explained above, this number would be divided by $k$.  (But note that $k$ should not be large!)

So, although this is a great improvement in factorization of large numbers (with a prime factor $p$ such that $p-1$ has only small prime factors), it is still a very time consuming algorithm.

+++

### Example

Let's try to use this method to factor $N = 4{,}288{,}337{,}437$:

```{code-cell} ipython3
N = 4288337437
```

We initialize $a$ and $b$ as $2$:

```{code-cell} ipython3
a = b = 2
```

Now, comes the loop.  Here, we will not explicitly choose $B$, but just see how many iterations we need until we find a factor.

We start with $j=2$, and set $b$ to the residue of $b^2$ module $N$.

```{code-cell} ipython3
j = 2
b = ZZ(Mod(b, N)^j)
```

:::{important}

Note that we use `Mod(b, N)^j` to efficiently compute the power $b^j$ and reduce it modulo $N$, and then `ZZ` to convert it back to an integer.  (We convert it to an integer so that we can compute the GCD below.)  Do not use `Mod(b^j, N)`, as it is a lot less efficient.
:::

Now, we compute the GCD of $b-1$ and $N$, and check if we get something different from $1$ and $N$.

```{code-cell} ipython3
d = gcd(b - 1, N)
d
```

We didn't, so we repeat:

```{code-cell} ipython3
j = 3
b = ZZ(Mod(b, N)^j)
d = gcd(b - 1, N)
d
```

```{code-cell} ipython3
j = 4
b = ZZ(Mod(b, N)^j)
d = gcd(b - 1, N)
d
```

```{code-cell} ipython3
j = 5
b = ZZ(Mod(b, N)^j)
d = gcd(b - 1, N)
d
```

```{code-cell} ipython3
j = 6
b = ZZ(Mod(b, N)^j)
d = gcd(b - 1, N)
d
```

```{code-cell} ipython3
j = 7
b = ZZ(Mod(b, N)^j)
d = gcd(b - 1, N)
d
```

```{code-cell} ipython3
j = 8
b = ZZ(Mod(b, N)^j)
d = gcd(b - 1, N)
d
```

```{code-cell} ipython3
j = 9
b = ZZ(Mod(b, N)^j)
d = gcd(b - 1, N)
d
```

```{code-cell} ipython3
j = 10
b = ZZ(Mod(b, N)^j)
d = gcd(b - 1, N)
d
```

```{code-cell} ipython3
j = 11
b = ZZ(Mod(b, N)^j)
d = gcd(b - 1, N)
d
```

```{code-cell} ipython3
j = 12
b = ZZ(Mod(b, N)^j)
d = gcd(b - 1, N)
d
```

Since we've got $768011$, this means that $76801$ is a factor of $N$:

```{code-cell} ipython3
divmod(N, 76801)
```

Indeed, we have that $N = 76801 \cdot 55837$, and we have factored $N$.

```{code-cell} ipython3
N == 76801 * 55837
```

Note that in principle we do not know if this is the *prime* factorization of $N$, but if we know that $N$ is the modulus for some RSA cryptosystem, then it must be.

Let's now illustrate the method if we compute the GCD only every $k$ steps.  Let's use $k=3$ here.

We initialize it the same way:

```{code-cell} ipython3
a = b = 2
```

But now we compute $k$ consecutive powers, without computing the GCD:

```{code-cell} ipython3
j = 2
b = ZZ(Mod(b, N)^j)

j = 3
b = ZZ(Mod(b, N)^j)

j = 4
b = ZZ(Mod(b, N)^j)
```

Then, we compute the GCD.

```{code-cell} ipython3
d = gcd(b - 1, N)
d
```

Since we got $1$, we repeat: three consecutive powers, and then the GCD:

```{code-cell} ipython3
j = 5
b = ZZ(Mod(b, N)^j)

j = 6
b = ZZ(Mod(b, N)^j)

j = 7
b = ZZ(Mod(b, N)^j)

d = gcd(b - 1, N)
d
```

Repeat it:

```{code-cell} ipython3
j = 8
b = ZZ(Mod(b, N)^j)

j = 9
b = ZZ(Mod(b, N)^j)

j = 10
b = ZZ(Mod(b, N)^j)

d = gcd(b - 1, N)
d
```

```{code-cell} ipython3
j = 11
b = ZZ(Mod(b, N)^j)

j = 12
b = ZZ(Mod(b, N)^j)

j = 13
b = ZZ(Mod(b, N)^j)

d = gcd(b - 1, N)
d
```

Again, we found the factor $76801$.


Note that $p=76801$ is such that $p-1$ has only small factors:

```{code-cell} ipython3
factor(76800)
```

On the other hand, if $q = 55837$, then $q-1$ does have some "large-ish" factors:

```{code-cell} ipython3
factor(55836)
```

## Choosing $p$ and $q$ for the RSA Cryptosystem

Firstly, we must note:

:::{important}

Since {prf:ref}`al-pollard` is a lot more efficient than the naive factorization, when producing $N = pq$ for the RSA cryptosystem, we need to choose $p$ and $q$ such $p-1$ and $q-1$ have large prime factors!
:::


Let's introduce some useful terminology:

:::{prf:definition} $B$-Smooth Numbers
:label: def-b_smooth


For some $B >0$, a number $n$ is called *$B$-smooth* if all its prime factors are less than or equal to $B$.
:::


So, with the RSA, we don't want $p-1$ and $q-1$ to $B$-smooth for any relatively small value of $B$.  But, if we choose a random large prime $p$, how likely it is that $p-1$, or equivalently, $(p-1)/2$,  will be $B$-smooth for a given $B$?

The number $(p-1)/2$, for some random prime $p$, is "more ore less" like a random number of size about $p/2$.  (We use $(p-1)/2$ instead of $p-1$, since the latter is always even, so not really a random integer.)  Thus, the question becomes:

:::{admonition} Question
:class: note

Given $B$, how likely is that $n$, within a certain bound, is $B$-smooth?
:::

Or, alternatively:

:::{admonition} Question
:class: note

Given a certain range, how large must $B$ be so that a random element $n$ in that range has a "good chance" of being $B$-smooth?
:::

These questions are in fact relevant to *all* modern factorization methods and we will come back to them in the [Smooth Numbers section](#smooth-numbers) below.

+++

(sec-diff-squares)=
## Factorization via Difference of Squares

We will now introduce another more efficient factorization algorithm. We start with the following definition:

:::{prf:definition} Perfect Square
:label: def-perfect_square


An integer $x$ is a *perfect square* if there is another integer $y$ such that $x = y^2$.
:::

Remember from Algebra the factorization
```{math}
x^2 - y^2 = (x-y)(x+y).
```
We use this idea to try to factor a large integer $N$: we can try to find some integer $b$ such that $N + b^2$ is a *perfect square*, i.e., there is another integer $a$ such that $N + b^2 = a^2$.  (Note that this implies that $a > b$.)  If we do, then
```{math}
N = a^2 - b^2 = (a-b)(a+b).
```
If $a > b + 1$, then $a - b$ is a proper factor!

We already know that $a > b$, so $a \geq b+1$, but in fact we *cannot* have that $a = b + 1$, as in that case we must have that
```{math}
\begin{align*}
a - b &= 1, \\
a + b &= N.
\end{align*}
```
Solving this system we get $a = (N+1)/2$ and $b=(N-1)/2$.  But this then implies that
```{math}
N = (a-b)(a+b) = \frac{N^2 - 1}{4} \quad \Longrightarrow  N^2 - 4N - 1 = 0.
```
Using the quadratic formula, this means that
```{math}
N = \frac{4 \pm \sqrt{20}}{2} = 2 \pm \sqrt{5},
```
which is *not an integer*.  Therefore, we must have that $a > b+1$, and $a-b$ would indeed be a proper factor.

Thus, we can try to take some random values for $b$ and then check if $N + b^2$ is a perfect square.  (But how does one check if an integer is a perfect square efficiently?)  Unfortunately this method takes too long for large $N$.

But here is an idea that can help: choose random $b$ and $k$ and see if $kN + b^2$ is a perfect square (again, one might wonder how to do that), i.e., $kN + b^2 = a^2$, for some integer $a$.  This means that $kN = a^2 - b^2 = (a-b)(a+b)$.  *Often*, either $a-b$ or $a+b$ contains some factor of $N$, and so we compute $\gcd(N, a - b)$ and $\gcd(N, a + b)$, hoping to find a proper factor.

Note that  $kN = a^2 - b^2$ means that $a^2 \equiv b^2 \pmod{N}$, or $a^2 = b^2$ in $\mathbb{Z}/N\mathbb{Z}$.  Moreover, since $a^2 = kN + b^2 > N$, we must have that $a > \lfloor \sqrt{N} \rfloor$.  So, we want
```{math}
:label: eq-diff_sqrs

a^2 = b^2  \quad \text{in $\mathbb{Z}/N\mathbb{Z}$, with $a > \lfloor \sqrt{N} \rfloor$.}
```
But still, finding $a$ and $b$ from [](#eq-diff_sqrs) will likely take too long, so we need a method to make it more efficient.

Here is the general procedure to find $a$ and $b$ as in [](#eq-diff_sqrs):


1) **Relation Building:**  Find "many" $a_1, a_2, \ldots, a_r < \lfloor N \rfloor$ such that the reduction modulo $N$ of $a_i^2$, which we shall denote by $c_i$, is {prf:ref}`B-smooth <def-b_smooth>` for some relatively small $B$.

2) **Elimination:**  Take a product of $c_{i_1} c_{i_2} \cdots c_{i_s}$ of *some* of the $c_i$'s such that every prime in the product appears an *even* number of times, i.e., with an even power in the prime factorization, so that $c_{i_1} c_{i_2} \cdots c_{i_s} = b^2$ for some integer $b$.

3) **GCD Computation:** Let $a = a_{i_1} a_{i_2} \cdots a_{i_s}$ (with the same indices, i.e., we take the products of the $a_i$'s corresponding to the $c_i$'s we've used in the Elimination).  Then
```{math}
a^2 = a_{i_1}^2 a_{i_2}^2 \cdots a_{i_s}^2 \equiv c_{i_1} c_{i_2} \cdots c_{i_s} = b^2 \pmod{N},
```
so we compute $\gcd(N, a - b)$.  If this GCD is neither $1$ nor $N$, we've found a factor of $N$.


:::{note}

The fact that $a_i > \lfloor N \rfloor$ implies that $a_i^2 > N$, so when we reduce $a_i^2$ modulo $N$ (to get a number between $0$ and $N-1$), we are getting a different integer than $a_i^2$ itself.  This is important for this method!  If not, in the *Elimination* process, each $c_i$ would automatically always have even powers for each prime divisor, making the process futile.
:::

:::{important}

In the *Elimination* process, we will need to *factor* each $c_i$, and that is why it is important that they are all $B$-smooth for some small $B$, so that these can be quickly factored.
:::


Now, if we do find $a$ and $b$ such that $a^2 \equiv b^2 \pmod{N}$, how likely is it that $\gcd(N, a-b)$ gives a proper factor of $N$?

The worst case is when $N=pq$, with $p$ and $q$ distinct prime factors (so, $N$ has only two proper factors).  Then,
```{math}
(a-b)(a+b) = a^2 - b^2 = kN = kpq,
```
so $p \mid (a-b)$ or $p \mid (a+b)$ (and possibly dividing both), *with (about) the same probability* and similarly for $q$.  So, there is about a $50\%$ chance that, in this case, $p \mid (a-b)$ and $q \nmid (a-b)$.  And note that if that is the case, then $q \mid (a+b)$, and quite likely $q \nmid (a+b)$, since for the latter to happen, we would need that $p \mid k$, and $k$ should not be that large.  So, we do not need to compute both $\gcd(N, a+b)$ and $\gcd(N, a-b)$: quite likely one gives us a factor if and only if the other does as well.  Since $a-b$ is smaller, we use it instead.

Note that this $50\%$ change of finding a factor when [](#eq-diff_sqrs) is satisfied is quite good, which means we would likely not need to check many pairs $(a, b)$.

+++

### Example

We will discuss the *Relation Building* process in a [future section](sec-relation_building).  The *GCD Computation* is straight forward.  So, here we will illustrate how the *Elimination* process works, through an example.

Suppose that the *Relation Building* process gave us the following $11$-smooth $c_i$'s:
```{math}
\begin{align*}
c_1 &= 3 \cdot 5^2 \cdot 7^3 \cdot 11, \\
c_2 &= 3 \cdot 5^5 \cdot \phantom{7^3} \cdot 11, \\
c_3 &= \phantom {3 \cdot} 5\phantom{^5} \cdot 7\phantom{^3} \cdot 11^3.
\end{align*}
```

So, we want to make products of these $c_i$'s that produce an integer that is a perfect square.  That is the same as to say that all primes in their prime factorizations appear with an even power: as
```{math}
x = p_1^{2r_1} p_2^{2r_2} \cdots p_k^{2 r_k} \quad \Longleftrightarrow \quad x = \left( p_1^{r_1} p_2^{r_2} \cdots p_k^{r_k} \right)^2.
```


Now, a product of the $c_i$'s can be written as
```{math}
c_1^{v_1} c_2^{v_2} c_3^{v_3}, \qquad \text{where $v_i$ is either $0$ or $1$.}
```
If $v_i = 0$, it means that $c_i$ is *not* a part of the product (it is left out), and if $v_i$ is $1$, then $c_i$ is a factor in the product.  So, collecting the powers, we have that
```{math}
c_1^{v_1} c_2^{v_2} c_3^{v_3} = 3^{v_1 + v_2} \cdot 5^{2v_1 + 5 v_2 + v_3} \cdot 7^{3v_1 + v_3} \cdot 11^{v_1 + v_2 + 3v_3}
```
and we want all the powers of the prime factors to be *even*.

Note that the powers $v_i$ (which can only be $0$ or $1$) are our *unknowns*!  We want to find these $v_i$'s that make the product a perfect square.  So, we want to find $v_i$'s, each either $0$ or $1$, such that
```{math}
:label: eq-og_system

\begin{align*}
\phantom{2}v_1 + \phantom{5}v_2 \phantom{+ 3v_3} & \equiv 0 \pmod{2}, \\
2v_1 + 5v_2 + \phantom{3}v_3 & \equiv 0 \pmod{2}, \\
3v_1 + \phantom{5v_2 + } \phantom{3}v_3 & \equiv 0 \pmod{2}, \\
\phantom{2}v_1 + \phantom{5}v_2 + 3v_3 & \equiv 0 \pmod{2}.
\end{align*}
```

But, since $v_i$'s are either $0$ or $1$, we can think of this as a system in $\mathbb{F}_2 = \mathbb{Z}/2\mathbb{Z}$, and can then also reduce the coefficients modulo $2$, obtaining the system (in $\mathbb{F}_2$):
```{math}
\begin{align*}
v_1 + v_2  \phantom{+ v_3} & =0, \\
\phantom{v_1 +} v_2 + v_3 & =0, \\
v_1 + \phantom{v_2 +} v_3 & =0, \\
v_1 + v_2 + v_3 & =0.
\end{align*}
```
Systems in $\mathbb{F}_2$ are very easy to solve.  We can use the same techniques we use with regular systems (with real numbers as coefficients), but remembering that in $\mathbb{F}_2$ we have that $x = -x$ (as $2$ divides $x - (-x) = 2x$).

So, the first equation gives us that $v_1 = -v_2 = v_2$.  The second gives us that $v_2 = -v_3 = v_3$, so $v_1 = v_2 = v_3$.  Now the fourth equation gives us that
```{math}
0 = v_1 + v_2 + v_3 = v_1 + v_1 + v_1 = 3 v_1 = v_1,
```
and so $v_1 = v_2 = v_3 = 0$.  So, the only way to get even exponents is to have all $v_i$'s equal to $0$, which means we use no $c_i$.  But this does not help us!  We need at least one $v_i$ to be $1$.

This means we need more $c_i$'s, so we go back to *Relation Building* to get more $c_i$'s.  Suppose we get now:
```{math}
\begin{align*}
c_4 &= 3\phantom{^3} \cdot \phantom{5 \cdot 7^2 \cdot} 11^2, \\
c_5 &= 3^3 \cdot 5 \cdot 7^2.
\end{align*}
```

+++

So, now we have
```{math}
:label: eq-ex-elimination1

c_1^{v_1} c_2^{v_2} c_3^{v_3} c_4^{v_4} c_5^{v_5}= 3^{v_1 + v_2 + v_4 + 3v_5} \cdot 5^{2v_1 + 5 v_2 + v_3 + v_5} \cdot 7^{3v_1 + v_3 + 2v_5} \cdot 11^{v_1 + v_2 + 3v_3 + 2v_4}.
```
Again, we need the exponents to be even, so we set the system in $\mathbb{F}_2$ (already reducing the coefficients odulo $2$) having these exponents as $0$:
```{math}
\begin{align*}
v_1 + v_2  +\phantom{v_3 +} v_4 + v_5& =0, \\
\phantom{v_1 +} v_2 + v_3 + \phantom{v_4 +} v_5 & =0, \\
v_1 + \phantom{v_2 +} v_3 \phantom{+ v_4 + v_5}& =0, \\
v_1 + v_2 + v_3 \phantom{ + v_4 + v_5}& =0.
\end{align*}
```

The third equation gives us that $v_1 = v_3$.  Then, the fourth gives us:
```{math}
0 = v_1 + v_2 + v_3 = 2v_1 + v_2 = v_2,
```
so $v_2 = 0$.  Now, substituting in the second, we get
```{math}
0 = 0 + v_1 + v_5 \qquad \Longrightarrow \qquad v_5 = v_1,
```
and hence $v_1 = v_3 = v_5$ (and $v_2 = 0$).  Finally, substituting it in the first, we have
```{math}
0 = v_1 + 0 + v_4 + v_1 = 2v_1 + v_4 = v_4,
```
and hence $v_4 = 0$.  So, *all* solutions of the system are of the form $(v_1, 0, v_1, 0, v_1)$, where $v_1$ is either $0$ or $1$.  If we take $v_1 = 0$, then all exponents become zero again, which is pointless, so we choose $v_1 = 1$.  This means that
```{math}
c_1^1 \cdot c_2^0 \cdot c_3^1 \cdot c_4^0 \cdot c_5^1 = c_1 c_3 c_5
```
is a perfect square.  In fact, from [](#eq-ex-elimination1), we have
```{math}
c_1 c_3 c_5 = 3^4 \cdot 5^4 \cdot 7^6 \cdot 11^4 = \left( 3^2 \cdot 5^2 \cdot 7^3 \cdot 11^2 \right)^2.
```

+++

#### Solving the System with Sage

How could we solve the system in Sage?  Let's first enter the $c_i$'s as a list in Sage.  We will start with the system that did not work:

```{code-cell} ipython3
list_c = [3 * 5^2 * 7^3 * 11, 3 * 5^5 * 11, 5 * 7 * 11^3]
```

Now we need to create a [matrix](https://en.wikipedia.org/wiki/Matrix_(mathematics)) for our system.  A matrix is simply a "table" containing the coefficients of the variable for the system.  For example, here is our original system

```{math}
\begin{align*}
v_1 + v_2  \phantom{+ v_3} & =0, \\
\phantom{v_1 +} v_2 + v_3 & =0, \\
v_1 + \phantom{v_2 +} v_3 & =0, \\
v_1 + v_2 + v_3 & =0.
\end{align*}
```

The corresponding matrix is:

```{math}
\begin{bmatrix}
1 & 1 & 0 \\
0 & 1 & 1 \\
1 & 0 & 1 \\
1 & 1 & 1
\end{bmatrix}.
```

The first column of this matrix contains the coefficients (in $\mathbb{F}_2$) of $v_1$, the second contains the coefficients of $v_2$, and the third the coefficients of $v_3$.

We can create this matrix in Sage with:

```{code-cell} ipython3
M = matrix(GF(2), [[1, 1, 0], [0, 1, 1], [1, 0, 1], [1, 1, 1]])
M
```

So, a matrix is created using a list containing each row (as another list) as its elements.

Remember that `GF(2)`, used as the first argument, is the same as `FiniteField(2)` and (basically the same as) `Zmod(2)`, and gives the [field](https://en.wikipedia.org/wiki/Field_(mathematics)) $\mathbb{F}_2$.  Using it as the first argument of `matrix` tells Sage that all the entries of the matrix are in the $\mathbb{F}_2$.  In particular, if the entries were not already zeros and ones, they would be automatically reduced modulo $2$ when creating the matrix.  So, we could have entered the original coefficients of the system before manually reducing them, i.e., [](#eq-og_system):

```{code-cell} ipython3
M = matrix(GF(2), [[1, 1, 0], [2, 5, 1], [3, 0, 1], [1, 1, 3]])
M
```

To get the solutions, we use the `.right_kernel()` method:

```{code-cell} ipython3
M.right_kernel()
```

The `[]` means that only all zeros is a solution, so this means that we need more $c_i$'s.  In practice, we can see when this happens by saving the result in a variable, say `K` and then using the `.dimension` method.  If we get $0$, then it means we only have the solution with all zeros.

```{code-cell} ipython3
K = M.right_kernel()
K.dimension()
```

So, we added $c_4$ and $c_5$:

```{code-cell} ipython3
list_c.extend([3 * 11^2, 3^3 * 5 * 7^2])
```

Then, we had the following matrix:

```{code-cell} ipython3
M = matrix(GF(2), [[1, 1, 0, 1, 3], [2, 5, 1, 0, 1], [3, 0, 1, 0, 2], [1, 1, 3, 2, 0]])
M
```

Then, we find the solutions again:

```{code-cell} ipython3
K = M.right_kernel()
K
```

The `[1 0 1 0 1]` is our solution non-zero solution, the same we found before!  We can also see that we have found a solution from the dimension, which is not zero now:

```{code-cell} ipython3
K.dimension()
```

We can print all solutions by looping over the kernel:

```{code-cell} ipython3
for v in K:
    print(v)
```

To loop over non-zero solutions, we can use a slice:

```{code-cell} ipython3
for v in K[1:]:
    print(v)
```

But now we need to automate the creation of the matrix `M` from the $c_i$'s.  We need the factorization of each one, but again, we would know a priori, from the *Relation Building* step, that all of them are $B$-smooth for some $B$.  In this case, we know that they are all $11$-smooth.  So, we test all primes less than $B$ and use `valuation` to get the exponent for each of these primes.  These exponents will give us the coefficients of the system.

Let's start by getting a list of all primes less than or equal to $11$:

```{code-cell} ipython3
list_p = list(primes(12))  # all primes less than or equal to 11
```

Now, let's find the first row.  It contains the powers of the first prime (i.e., $2$) for *all* $c_i$'s.  The second row contains the powers of the second prime (i.e., $3$) for all $c_i$'s, and so on.  So, each row is given by

```python
[valuation(c, p) for c in list_c]
```

for a given `p` in `list_p`.  Hence:

```{code-cell} ipython3
coef_matrix = matrix(ZZ, [[valuation(c, p) for c in list_c] for p in list_p])
coef_matrix
```

(The `ZZ` specifies that the entries are *integers*.)

+++

Note that we are starting with `coef_matrix` that contains the exponents as *integers*, i.e., before being reduced modulo $2$, as it will be useful later.  But now, we can obtain `M` (with entries in $\mathbb{F}_2$):

```{code-cell} ipython3
M = matrix(GF(2), coef_matrix)
M
```

Note that this matrix is not quite the same as before, since we introduced the prime $2$ that does not appear in our $c_i$'s.  But that does not affect the result:

```{code-cell} ipython3
K = M.right_kernel()
K
```

And now, to produce our $b$'s.  Since the solution is $(1, 0, 1, 0)$, we have that
```{math}
b^2 = c_1^1 \cdot c_2^0 \cdot c_3^1 \cdot c_4^0 \cdot c_5^1 = c_1 \cdot c_3 \cdot c_5.
```
So, to get $b$ itself, we need to take a square root:

```{code-cell} ipython3
v = K[1]  # first non-zero solution
b = sqrt(prod(c^x for (c, x) in zip(list_c, v)))
b
```

Note that if we had `list_a`, with the corresponding $a_i$'s, we would obtain $a$ in a similar manner (without the square root):
```python
a = prod(ai^x for (ai, x) in zip(list_a, v))
```

+++

Note that when computing $b$ we need to take a square root.  But we can speed up this calculation since we can easily now find the powers of the primes that appear in $b^2$ (as in [](#eq-ex-elimination1)) and hence we can simply divide them by $2$.

The trick to find these exponents of the prime factors of $b^2$ is to use [matrix multiplication](https://en.wikipedia.org/wiki/Matrix_multiplication).  We just have to use each solution found and multiply `coef_matrix` (and *not* `M`) by it:

```{code-cell} ipython3
coef_matrix * vector(ZZ, list(v))  # note the *list* there!
```

(Note that for this multiplication to work, we need to convert the solution (out list of zeros and ones) to a [vector](https://en.wikipedia.org/wiki/Euclidean_vector) with integer entries.)

So, this is saying, in terms of matrix multiplications, that
```{math}
\underbrace{\begin{bmatrix}
0 & 0 & 0 & 0 & 0 \\
1 & 1 & 0 & 1 & 3 \\
2 & 5 & 1 & 0 & 1 \\
3 & 0 & 1 & 0 & 2 \\
1 & 1 & 3 & 2 & 0
\end{bmatrix}}_{\text{coefficient matrix}}
\cdot
\underbrace{\begin{bmatrix}
1 \\
0 \\
1 \\
0 \\
1
\end{bmatrix}}_{\text{solution}} =
\underbrace{\begin{bmatrix}
0 \\
4 \\
4 \\
6 \\
4
\end{bmatrix}}_{\text{exponents of the primes}}
```

+++

This means that
```{math}
b^2 = 2^0 \cdot 3^4 \cdot 5^4 \cdot 7^6 \cdot 11^4,
```
and hence
```{math}
b = 2^0 \cdot 3^2 \cdot 5^2 \cdot 7^3 \cdot 11^2.
```

So, we can divide these exponents by $2$ to obtain the correct exponents for the prime factors of $b$.

```{code-cell} ipython3
exponents = 1/2 * coef_matrix * vector(ZZ, list(v))
b = prod(p^x for (p, x) in zip(list_p, exponents))
b
```

We get the same result (but faster)!

+++

:::{note}

This method only works for $b$ and not for $a$, which we would still compute as above:

```python
a = prod(ai^x for (ai, x) in zip(list_a, v))
```
:::

:::{important}

If we are trying to factor $N$, as we would in practice, we should reduce each $a$ and $b$ modulo $N$, as in

```python
a = ZZ(prod(Mod(ai, N)^x for (ai, x) in zip(list_a, v)))
b = ZZ(prod(Mod(p, N)^x for (p, x) in zip(list_p, exponents)))
```

to make speed up the computation of the GCD.  Note that we compute the products in $\mathbb{Z}/N\mathbb{Z}$ and then convert them back to $\mathbb{Z}$ to make this reduction modulo $N$ more efficient.
:::

+++

In this case, we only have one $b$, as we've seen above, since we have only one non-zero solution, but we might have more if there is more than a single solution.

What we do is to loop over the solutions in `K[1:]`.  At each iteration we find $a$ and $b$ (as shown above), and compute $\gcd(N, a - b)$.  It is neither $1$ not $N$, we found our divisor.  If not, we proceed the next iteration (i.e., the next solution).  If we run through all solutions, never finding a divisor, the method failed.

:::{admonition} Homework
:class: note

You will implement this *Elimination* process in your [homework](#sec-hw7).
:::

+++

(smooth-numbers)=
## Smooth Numbers

As previously mentioned, {prf:ref}`smooth numbers <def-b_smooth>` appear in all modern factorization methods (as well as other computational problems).  In this section we will give some mathematical properties of $B$-smooth numbers.  The proofs are complex and beyond the scope of these notes, so we will simply state the properties.  But let's start with some examples.

:::{prf:example} $5$-Smooth Numbers
:label: ex-5-smooth


We can break down the integers into $5$-smooth numbers and not $5$-smooth:
```{math}
\begin{align*}
\text{$5$-smooth:} &\quad 2, 3, 4, 5, 6, 8, 9, 10, 12, 15, 16, 18, 20, 24, 25, 27, 30, \ldots \\
\text{not $5$-smooth:} &\quad 7, 11, 13, 14, 17, 19, 21, 22, 23, 26, 28, 29, \ldots
\end{align*}
```
:::

We now introduce a function to count the number of $B$-smooth numbers up to a given bound:

:::{prf:definition} Number of Smooth Numbers
:label: def-n_smooth


We define $\psi(x, B)$ to be the number of smooth numbers less than or equal to $x$.
:::

So, we can see from the example above that $\psi(30, 5) = 17$.

We also need the following function:

:::{prf:definition} Function $L$
:label: def-function_L

We define function $L(x)$, for $x >0$, as
```{math}
L(x) = e^{\sqrt{\log(x) \cdot \log(\log(x))}}.
```
(Remember that $\log(x)$ is the *natural log*, i.e., the log base $e \approx 2.7183$).
:::

We then have the following technical result:

:::{prf:theorem}
:label: th-psi_L

For any real number $c$ with $0 < c < 1$ and for "large" values of $x$, we have
```{math}
\psi(x, L(x)^c) \approx x \cdot L(c)^{- \frac{1}{2c} \cdot (1 + s_x)},
```
where $s_x$ approaches $0$ as $x$ gets large.
:::

When using the [difference of squares factorization method](#sec-diff-squares), in order to find solution we need that the system must have more equations than variables.  The number of equations is given by the number of primes less than or equal to $B$.  When we require the $c_i$'s to be $B$-smooth this number is $\pi(B)$ (the number of primes less than or equal to $B$).  The number of variables is given by the number of $a_i$'s (or $c_i$'s).  So, we need the number of $B$-smooth $c_i$'s to be greater than $\pi(B)$.

The theorem above gives us the an idea of how difficult finding that many $B$-smooth numbers is:

:::{prf:theorem}
:label: th-b_smooth_application

Let $N$ be a large integer and set $B = L(N)^{\frac{1}{\sqrt{2}}}$.  We expect to check about $B^2 = L(N)^{\sqrt{2}}$ random numbers modulo $N$ to find $\pi(B)$ numbers that are $B$-smooth.  Thus, we expect to check $B^2 = L(N)^{\sqrt{2}}$ random numbers of the form $a^2$ reduced modulo $N$ to be able to factor $N$.
:::


Here is a table to give you an idea of the size of $L(N)$ and $L(N)^{\sqrt{2}}$:

:::{table} Sizes of $L(N)$ and $L(N)^{\sqrt{2}}$ compared to $N$.
:align: center
:widths: auto
:width: 100 %
:name: tb-b_smooth_sizes

| $N$        | $L(N)$       | $L(N)^{\sqrt{2}}$ |
|------------|--------------|-------------------|
| $2^{100}$  | $2^{24.73}$  | $2^{34.97}$       |
| $2^{250}$  | $2^{43.12}$  | $2^{60.98}$       |
| $2^{500}$  | $2^{64.95}$  | $2^{91.85}$       |
| $2^{1000}$ | $2^{97.14}$  | $2^{137.38}$      |
| $2^{5000}$ | $2^{242.48}$ | $2^{342.91}$      |
:::

Or, in terms of the number of digits

:::{table} Numer of digits of $L(N)$ and $L(N)^{\sqrt{2}}$ compared to $N$.
:align: center
:widths: auto
:width: 100 %
:name: tb-b_smooth_sizes_digits

| $\log_{10}(N)$ | $\log_{10}(L(N))$ | $\log_{10}(L(N)^{\sqrt{2}})$ |
|----------------|-------------------|------------------------------|
| $31$           | $8$               | $11$                         |
| $76$           | $13$              | $19$                         |
| $151$          | $20$              | $28$                         |
| $302$          | $30$              | $42$                         |
| $1506$         | $73$              | $104$                        |
:::


One can improve this process by taking the $a_i$'s, which we square and reduce modulo $N$, only slightly larger than $\sqrt{N}$ (instead of purely randomly), which reduces the number of $a_i$'s to try to about $L(N)$, which is a good improvement.

We will come back to this process (the *Relation Building*) in a [later section](#sec-relation_building).


### Checking for $B$-Smoothness in Sage

If you want to check that some number $a$ is $B$-smooth in Sage, one should *not* use the `factor` function.  If the number *is* $B$-smooth, for a relatively small $B$, that could work.

```{code-cell} ipython3
a = 2^6 * 7^3 * 11^4 * 13^5 * 23^2
a
```

```{code-cell} ipython3
B = 23
a = 63127307789850304

# test
prime_divisors = [x[0] for x in factor(a)]

if max(prime_divisors) <= B:
    print(f"{a} is {B}-smooth.")
else:
    print(f"{a} is not {B}-smooth.")
```

Note that Sage actually has a `prime_factors` function that could make this even easier:

```{code-cell} ipython3
B = 23
a = 63127307789850304

# test
if max(prime_factors(a)) <= B:
    print(f"{a} is {B}-smooth.")
else:
    print(f"{a} is not {B}-smooth.")
```

But, if not, it will take a lot longer than necessary!

```{code-cell} ipython3
%%time

a = 505315045110283216972911558435118337
B = 23

# test
if max(prime_factors(a)) <= B:
    print(f"{a} is {B}-smooth.")
else:
    print(f"{a} is not {B}-smooth.")
```

The idea is to simply see how many times each prime less than or equal to $B$ divides the number, and see if only those primes raised to their corresponding powers and multiplied give the number.

Remember that we can use `valuation(a, p)` in Sage to see how many times the prime `p` divides `a`.  Hence, to check for $B$-smoothness, we can do

```python
a == [p^(valuation(a, p)) for p in primes(B + 1)]
```

For example:

```{code-cell} ipython3
%%time

a = 505315045110283216972911558435118337
B = 23

# test
if a == [p^(valuation(a, p)) for p in primes(B + 1)]:
    print(f"{a} is {B}-smooth.")
else:
    print(f"{a} is not {B}-smooth.")
```

It's a lot faster, as it only tests divisibility by small numbers!

+++

Here is some information about the computer used for the computations above:

```{code-cell} ipython3
!inxi --system --cpu --memory
```
