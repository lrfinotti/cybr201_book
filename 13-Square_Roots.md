---
jupytext:
  formats: ipynb,sage:percent,md:myst
  encoding: '# -*- coding: utf-8 -*-'
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

# Square Roots Modulo $m$

+++

We will soon come back to factorization and computation of discrete logs, but before then we need to investigate square roots in $\mathbb{Z}/m\mathbb{Z}$.


(sec:sqrt_mod_p)=
## Squares Module Odd Primes

First, we need to recall some definitions and results from the [chapter on powers](./05-Powers.md).  Recall *Fermat's Little Theorem*:

:::{prf:theorem} Fermat's Little Theorem
:label: th-flt-3


If $p$ is prime and $p \nmid a$, then $a^{p-1} = 1$ in $\mathbb{Z}/p\mathbb{Z}$ (i.e., $a^{p-1} \equiv 1 \pmod{p}$).
:::

Also, remember that we've seen before that if $p$ is prime and $x \in \mathbb{F}_p$ is such that $x^2 = 1$, then $x=1$ or $x=-1$.

Remember also our definition of *primitive root*:

:::{prf:theorem} Primitive Root Theorem
:label: th-prim_root-2


Let $p$ be a prime.  (Remember then that $\mathbb{F}_p$ is just another way to write $\mathbb{Z}/p\mathbb{Z}$.)  Then, there is an element $g \in \mathbb{F}_p^{\times}$ such that every element of $\mathbb{F}_p^{\times}$ is a power of $g$.  In other words:
```{math}
\mathbb{F}_p^{\times} = \{1, g, g^2, g^3, \ldots, g^{p-2}\}.
```
:::

:::{prf:definition} Primitive Root
:label: def-prim2


A $g$ as above is called a *primitive root* of $\mathbb{F}_p$ or a *generator* of $\mathbb{F}_p^{\times}$.
:::

We also introduced the *order* of elements in $\mathbb{Z}/m\mathbb{Z}$:

:::{prf:definition} Order of an Element
:label: def-ord2


If $a$ is a unit of $\mathbb{Z}/m\mathbb{Z}$, then the *order of $a$*, usually denoted by $|a|$, is the smallest positive power $k$ such that $a^k = 1$.
:::

So, the order of a primitive root in $\mathbb{F}_p$ is $p-1$.

Finally, we have the following results about orders:

:::{prf:proposition}
:label: pr_power_one-2


Let $a$ be a unit of $\mathbb{Z}/m\mathbb{Z}$. If $a^k = 1$, for some integer $k$, then $|a| \mid k$.  In particular, we always have that $|a| \mid \varphi(m)$.
:::


:::{prf:proposition} Order of a Power
:label: pr-order_power-2


Let $a \in (\mathbb{Z}/m\mathbb{Z})^{\times}$ with $|a| = n$.  Then, we have that
```{math}
|a^k| = \frac{n}{\gcd(n, k)}.
```
:::




With that, we can show the following result:

:::{prf:proposition} Squares in $\mathbb{F}_p$
:label: pr-squares-fp


Let $p$ be an odd prime and $a \in \mathbb{F}_p = \mathbb{Z}/p\mathbb{Z}$, with $a \neq 0$.  Then, we have that $a^{(p-1)/2}$ is either $1$ or $-1$.  The former occurs when $a$ is a square in $\mathbb{F}_p$ (i.e., when there is some $b \in \mathbb{F}_p$ such that $a = b^2$) and the latter when $a$ is *not* a square in $\mathbb{F}_p$.
:::


:::{prf:proof}
:nonumber:

First, by Fermat's Little Theorem, we have that
```{math}
\left( a^{(p-1)/2} \right)^2 = a^{p-1} = 1,
```
and, as observed above, this means that $a^{(p-1)/2}$ must be either $1$ or $-1$.

If $a = b^2$, for some $b \in \mathbb{F}_p$ (and $b \neq 0$, since $a \neq 0$), then, by Fermat's Little Theorem again, we have that
```{math}
a^{(p-1)/2} = \left( b^2 \right)^{(p-1)/2} = b^{p-1} = 1.
```
Hence, if $a$ is a square, then $a^{(p-1)/2} = 1$.

Now, let $g$ be a primitive root of $\mathbb{F}_p$.  If $a = g^k$, where $k$ is *even* (and so $k/2$ is an integer), then $a$ is a square, namely $a = \left( g^{k/2} \right)^2$.  So, if $a$ is *not* a square, then $k$ must be *odd*.  This means that $\gcd(k \cdot (p-1)/2, p-1) = (p-1)/2$: first, it is clear that $(p-1)/2$ is a common divisor.  So the GCD is at least $(p-1)/2$ and divides $p-1$, which means that is either $(p-1)/2$ or $p-1 = 2 \cdot (p-1)/2$.  But $k$ being odd, we have that $p-1 = 2 \cdot (p-1)/2$ does not divide $(p-1)/2$, so indeed,
```{math}
\gcd(k \cdot (p-1)/2, p-1) = (p-1)/2.
```

Then, by {prf:ref}`pr-order_power-2`, we have
```{math}
|a^{(p-1)/2}| = | g^{k \cdot (p-1)/2} | = \frac{|g|}{\gcd(k \cdot (p-1)/2, |g|)} = \frac{p-1}{\gcd(k \cdot (p-1)/2,  p-1)} = \frac{p-1}{(p-1)/2} = 2.
```
Since the order is not $1$, it means that $a^{(p-1)/2} \neq 1$, and hence it must be $-1$.
:::

:::{note}

With [fast powering](./05-Powers.md#fast_powering), one can use {prf:ref}`pr-squares-fp` to relatively quickly decide if an element in $\mathbb{F}^{\times}$ is a square.  But we will see a better method below, using {prf:ref}`Quadratic Reciprocity <sec-quad_rec>`
:::


The proof of {prf:ref}`pr-squares-fp` also shows the following:

:::{prf:proposition}
:label: pr-squares_gen


If $g$ is a primitive root in $\mathbb{F}_p$ and $a \in \mathbb{F}^{\times}$, then $a$ is a square if and only if $a = g^k$ with $k$ *even*.  In particular, a random element in $\mathbb{F}^{\times}$ has a $50\%$ chance of being a square.
:::

+++

(sec-quad_rec)=
## Quadratic Reciprocity

### Legendre Symbol

{prf:ref}`pr-squares-fp` gives a way to determine if some $a \in \mathbb{F}^{\times}$ is a square.  Here will introduce a more efficient way.  We start with the following definition:

:::{prf:definition} Legendre Symbol
:label: def-legendre


Let $p$ be a prime and $a$ be an integer.  Then, the *Legendre symbol* of $a$ modulo $p$ is given by
```{math}
\left(\frac{a}{p}\right) = \begin{cases}
\phantom{-}0, & \text{if $p$ divides $a$}; \\
\phantom{-}1, & \text{if $p$ does not divide $a$ and $a$ is a square inn $\mathbb{F}_p$};\\
-1, & \text{if $p$ does not divide $a$ and $a$ is not a square inn $\mathbb{F}_p$.}
\end{cases}
```
:::

:::{note}

If $p$ is an *odd* prime, then, by {prf:ref}`pr-squares-fp`, we could have defined
```{math}
\left(\frac{a}{p}\right) = a^{(p-1)/2} \quad \text{(computed in $\mathbb{F}_p$).}
```
:::

:::{prf:proposition} Basic Properties of the Legendre Symbol
:label: pr-basic_prop_legendre

Here are some immediate properties of the Legendre Symbol:

1) If $a \equiv a' \pmod{p}$, then clearly $\left(\dfrac{a}{p}\right) = \left(\dfrac{a'}{p}\right)$.
2) If $k$ is an odd integer, then ${\left(\dfrac{a}{p}\right)}^k = \left(\dfrac{a}{p}\right)$.
3) If $p$ does not divide $a$ and $k$ is an even integer, then ${\left(\dfrac{a}{p}\right)}^k = 1$.
:::


We also have the following property:

:::{prf:proposition} Multiplicativity of the Legendre Symbol
:label: pr-legengre-mult


Let $a, b \in \mathbb{F}^{\times}$.  Then $ab$ is a square in $\mathbb{F}^{\times}$ if and only if either both $a$ and $b$ are squares in $\mathbb{F}^{\times}$ or neither is.  Therefore, we have
```{math}
\left(\frac{ab}{p}\right) = \left(\frac{a}{p}\right) \cdot \left(\frac{b}{p}\right).
```
:::

:::{prf:proof}
:nonumber:

This follows from {prf:ref}`pr-squares_ge`.  Let $g$ be a primitive root of $\mathbb{F}^{\times}$ and write $a = g^r$, $b = g^s$.  Then, $ab = g^{r+s}$ is a square if and only if $r + s$ is even.  But this happens if and only if either $r$ and $s$ are both even or both odd, i.e., if and only if $a$ and $b$ are both squares or neither is.
:::


The following theorem, referred as [Quadratic Reciprocity](https://en.wikipedia.org/wiki/Quadratic_reciprocity), is a very important result in Number Theory.  It was proved by [C.F. Gauss](https://en.wikipedia.org/wiki/Carl_Friedrich_Gauss) in 1798.

:::{prf:theorem} Quadratic Reciprocity
:label: th-qr


Let $p$ and $q$ be *odd* primes.  Then:

1)
```{math}
\left(\frac{-1}{q}\right) = (-1)^{(q-1)/2} = \begin{cases}
\phantom{-}1, & \text{if $q \equiv 1 \pmod{4}$};\\
-1, & \text{if $q \equiv 3 \pmod{4}$}.
\end{cases}
```

2)
```{math}
\left(\frac{2}{q}\right) = (-1)^{(q^2-1)/8} = \begin{cases}
\phantom{-}1, & \text{if $q \equiv 1, 7 \pmod{8}$};\\
-1, & \text{if $q \equiv 3, 5 \pmod{8}$}.
\end{cases}
```

3)
```{math}
\left(\frac{p}{q}\right) = (-1)^{\frac{p-1}{2} \frac{q-1}{2}} \left(\frac{q}{p}\right) = \begin{cases}
\phantom{-}\left(\dfrac{q}{p}\right), & \text{if $p \equiv 1 \pmod{4}$ or $q \equiv 1 \pmod{4}$};\\[3ex]
-\left(\dfrac{q}{p}\right), & \text{if $p \equiv 3 \pmod{4}$ and $q \equiv 3 \pmod{4}$}.
\end{cases}
```
:::

The proof of this theorem is not hard, but beyond the scope of these notes.  (There are in fact *many* different proofs!)  But we illustrate how we can use it to determine if an integer is a square in some $\mathbb{F}_p$:

:::{prf:example}
:label: ex-qr-1


Is $-250{,}192$ a square modulo the prime $91{,}139$?
:::

We have:

\begin{align}
\left(\frac{-250192}{91139}\right) &= \left(\frac{-67914}{91139}\right) & &\text{(reduce the top module the bottom)}\\
&= \left(\frac{-1}{91139}\right) \cdot \left(\frac{67914}{91139}\right) & &\text{(multiplicativity of the Legendre symbol)} \\
&= (-1) \cdot \left(\frac{2 \cdot 3^2 \cdot 7^3 \cdot 11}{91139}\right) && \text{(as $91139 \equiv 4 \pmod{4}$)} \\
&= (-1) \cdot \left(\frac{2}{91339}\right) \cdot \left(\frac{3}{91139}\right)^2 \cdot  \left(\frac{7}{91139}\right)^3 \cdot \left(\frac{11}{91139}\right)  & &\text{(multiplicativity of the Legendre symbol)} \\
&= (-1) \cdot (-1) \cdot 1 \cdot \left(\frac{7}{91139}\right) \cdot \left(\frac{11}{91139}\right)  & &\text{(as $91139 \equiv 3 \pmod{8}$)} \\
&= -\left(\frac{91139}{7}\right) \cdot -\left(\frac{91139}{11}\right)  & &\text{(as $7, 11, 91139 \equiv 3 \pmod{4}$)} \\
&= \left(\frac{6}{7}\right) \cdot \left(\frac{4}{11}\right)  & &\text{(reduce top module bottom)} \\
&= \left(\frac{-1}{7}\right) \cdot \left(\frac{2^2}{11}\right) \\
&= (-1) \cdot \left(\frac{2}{11}\right)^2 \\
&= (-1) \cdot 1 = \boxed{-1},
\end{align}

So, $-250{,}192$ is *not* a square modulo the $91{,}139$.


:::{warning}

Note we had to factor a number, and this can be hard!
:::

Of course, Sage has the Legendre symbol:

```{code-cell} ipython3
legendre_symbol(-250192, 91139)
```

In fact it has the `is_square` method as well.

```{code-cell} ipython3
Mod(-250192, 91139).is_square()
```

### Jacobi Symbol

We often have to factor the top number with this method, as we did in the previous example, which can be difficult.  Next, we will see how we can avoid it!  We need the following generalization of the Legendre symbol:

:::{prf:definition} Jacobi Symbol
:label: def-js


Let $a$ and $b$ be integers with $b \geq 2$ and *odd*.  Suppose that the prime factorization of $b$ is given by
```{math}
b = p_1^{r_1} p_2^{r_2} \cdots p_k^{r_k}.
```
Then, we define the Jacobi symbol
```{math}
\left(\frac{a}{b}\right) = {\left(\frac{a}{p_1}\right)}^{e_1} {\left(\frac{a}{p_2}\right)}^{e_2} \cdots {\left(\frac{a}{p_k}\right)}^{e_k}.
```
(Note that the $\left(\frac{a}{p_i}\right)$ on the right are Legendre symbols.)
:::

So, the Jacobi  symbol generalizes the Legendre symbol to the case where the bottom number does not have to be prime.

:::{caution}

If the Jacobi symbol $\left(\frac{a}{b}\right) = 1$, it is *not necessarily the case* that $a$ is a square modulo $b$!
:::

For instance:
```{math}
\left(\frac{2}{15}\right) = \left(\frac{2}{3}\right) \cdot \left(\frac{2}{5}\right) = (-1) \cdot (-1) = 1,
```
but $2$ is not a square modulo $15$:

```{code-cell} ipython3
Mod(2, 15).is_square()
```

On the other hand, if the Jacobi symbol $\left(\frac{a}{b}\right) = -1$, it is the case that $a$ is *not* a square modulo $b$.  And, as we shall soon see, the Jacobi symbol is still quite useful to determine if some integer is a square module a *prime*.  But first, we need some basic properties:

:::{prf:proposition} Basic Properties of the Jacobi Symbol
:label: pr-js-prop


Let $a$, $a_1$, $a_2$, $b$, $b_1$, and $b_2$ be integers, with $b$, $b_1$, and $b_2$ odd and greater than $1$.  We then have:

1) If $\left(\dfrac{a}{b}\right) = -1$, then $a$ is not a square modulo $b$.

2) If $a_1 \equiv a_2 \pmod{b}$, then $\left(\dfrac{a_1}{b}\right) = \left(\dfrac{a_2}{b}\right)$.

3) $\left(\dfrac{a_1a_2}{b}\right) = \left(\dfrac{a_1}{b}\right) \cdot \left(\dfrac{a_2}{b}\right)$.

4) $\left(\dfrac{a}{b_1b_2}\right) = \left(\dfrac{a}{b_1}\right) \cdot \left(\dfrac{a}{b_2}\right)$.
:::

All of these are straight-forward to prove, but we will leave it to the interested reader to try to do it on their own.  But, what makes it useful is the fact that {prf:ref}`th-qr` can be extended to the Jacobi symbol:

:::{prf:theorem} Quadratic Reciprocity for Jacobi Symbol
:label: th-qr-jacobi


Let $a$ and $b$ be *odd* integers greater than one.  Then:

1)
```{math}
\left(\frac{-1}{b}\right) = (-1)^{(b-1)/2} = \begin{cases}
\phantom{-}1, & \text{if $b \equiv 1 \pmod{4}$};\\
-1, & \text{if $b \equiv 3 \pmod{4}$}.
\end{cases}
```

2)
```{math}
\left(\frac{2}{b}\right) = (-1)^{(b^2-1)/8} = \begin{cases}
\phantom{-}1, & \text{if $b \equiv 1, 7 \pmod{8}$};\\
-1, & \text{if $b \equiv 3, 5 \pmod{8}$}.
\end{cases}
```

3)
```{math}
\left(\frac{a}{b}\right) = (-1)^{\frac{a-1}{2} \frac{b-1}{2}} \left(\frac{b}{a}\right) = \begin{cases}
\phantom{-}\left(\dfrac{b}{a}\right), & \text{if $a \equiv 1 \pmod{4}$ or $b \equiv 1 \pmod{4}$};\\[3ex]
-\left(\dfrac{b}{a}\right), & \text{if $a \equiv 3 \pmod{4}$ and $b \equiv 3 \pmod{4}$}.
\end{cases}
```
:::

:::{note}

Note that {prf:ref}`th-qr-jacobi` is exactly the same as {prf:ref}`th-qr` with all instances of $p$ replaced by $a$ and all instances of $q$ replaced by $b$.
:::

The proof of {prf:ref}`th-qr-jacobi` just requires {prf:ref}`def-js` and repeated use of {prf:ref}`th-qr`, and thus is again left to the reader as an exercise.

+++

### Example

Let's show it an example.  We take the large *prime* $p = 789473$:

```{code-cell} ipython3
p = 789473
```

Let's see if  $a = 195960$ is a square in $\mathbb{F}_p$.

```{code-cell} ipython3
a = 195960
```

We will use the *Jacobi* symbol in the process, without having to factor numbers!

On the other hand, it is important to note that since $p$ is *prime*, we have that $\left(\dfrac{a}{p}\right)$ is a *Legendre* symbol, so if we get $1$, then $a$ is a square, and if we get $-1$, then $a$ is *not* a square.

+++

First, we need to remove factors of $2$ from $a$:

```{code-cell} ipython3
valuation(a, 2)
```

```{code-cell} ipython3
a // 2^3
```

Then, we have $a = 2^3 \cdot 24495$.  So,
```{math}
\left(\frac{a}{p}\right) = \left(\frac{2^3 \cdot 24495}{p}\right) = \left(\frac{2}{p}\right)^3 \cdot \left(\frac{24495}{p}\right).
```

We need to know then what is the residue of $p$ modulo $8$:

```{code-cell} ipython3
p % 8
```

So, we have
```{math}
\left(\frac{a}{p}\right) = 1 \cdot \left(\frac{24495}{p}\right) = \left(\frac{24495}{p}\right).
```

We know "flip", using {prf:ref}`th-qr-jacobi`, but we need to know the residues modulo $4$.  But since $p \equiv 1 \pmod{8}$, we have that $p \equiv 1 \pmod{4}$.

```{code-cell} ipython3
p % 4
```

:::{tip}

One can easily reduce *positive* numbers modulo $4$: we simply reduce the last two digits!  This is true since $100$ is divisible by $4$, and hence we have
```{math}
789473 = 789400 + 73 =  7894 \cdot 100 + 73 \equiv 7894 \cdot 0 + 73 =  73 \pmod{4}.
```
:::

We also need to know the reduction of $p$ modulo $24495$:

```{code-cell} ipython3
p % 24495
```

So, we have:
```{math}
\left(\frac{a}{p}\right) = \left(\frac{p}{24495}\right) = \left(\frac{5633}{24495}\right).
```
Note that at this point we are dealing with Jacobi symbols, as we do not know if the bottom number is prime!

+++

The new top is odd, so we can repeat the flip, checking we need to change the sign:

```{code-cell} ipython3
5633 % 4
```

```{code-cell} ipython3
24495 % 5633
```

So:
```{math}
\left(\frac{a}{p}\right) = \left(\frac{24495}{5633}\right) = \left(\frac{1963}{5633}\right).
```
Since we already know that $5633 \equiv \pmod{4}$, we can flip (with no sign change) and reduce:

```{code-cell} ipython3
5633 % 1963
```

This gives:
```{math}
\left(\frac{a}{p}\right) = \left(\frac{5633}{1963}\right) = \left(\frac{1707}{1963}\right).
```
The new top is odd, so we can keep flipping:

```{code-cell} ipython3
1707 % 4
```

```{code-cell} ipython3
1963 % 4
```

So, we need to flip the sing.

```{code-cell} ipython3
1963 % 1707
```

This gives us
```{math}
\left(\frac{a}{p}\right) = (-1) \cdot \left(\frac{1963}{1707}\right) = (-1) \cdot \left(\frac{256}{1707}\right).
```
But now, $256 = 2^8$, so we get:
```{math}
\left(\frac{a}{p}\right) = (-1) \cdot \left(\frac{2^8}{1707}\right) = (-1) \cdot {\left(\frac{2}{1707}\right)}^8 = (-1) \cdot 1 = \boxed{-1}.
```
Therefore, $a = 195960$ is *not* a square modulo the prime $p = 789473$.

+++

### Algorithm

Here is the algorithm used above to find if an integer $a$ is a square modulo a prime $p$.

:::{prf:algorithm} Quadratic Reciprocity for Square Checking
:label: al-sqr-qr


Given an integer $a$ and an *odd* prime $p$, we find if $a$ is a square in $\mathbb{F}_p$.

1) Initialize by changing $a$ to its reduction modulo $p$.
2) If $a = 0$, return *True*.
3) If not, initialize the result: `result = True`.
4) While $a \neq 1$:
    1) Let $k$ be the number of times that $2$ divides $a$ (i.e., `k = valuation(a, 2)`).
    2) If $k$ is odd *and* $p$ is congruent to either $3$ or $5$ modulo $8$, then `result = not result`.
    3) Set $a \leftarrow a / 2^k$.
    4) If $a = 1$, return `result` (and we are done).
    5) If *both* $a$ and $p$ is congruent to $3$ modulo $4$, update `result = not result` (for flipping).
    6) Swap the values of $a$ and $p$ (e.g., `a, p = p, a` in Sage).
    7) Reduce $a$ modulo $p$.
5) When the loop is done (if we did not return the result in the body of the loop), return `result`.
:::

:::{note}

In this algorithm we basically have $1$ replaced by `True` and $-1$ replaced by `False`.  So, changing the sign (i.e., multiplying by $-1$) corresponds to the `not` operation of booleans.

Also note that we do not deal with negatives, since we always reduce modulo the bottom number.
:::

:::{admonition} Homework
:class: note

You will implement this algorithm in your homework.
:::

+++

## Square Roots Module Odd Primes

+++

### Number of Square Roots

We start with a definition:

:::{prf:definition} Square Roots Modulo $m$
:label: def-sqrt_mod_m


If element $a \in \mathbb{Z}/m\mathbb{Z}$ is square modulo $m$, i.e., if $a = b^2$ modulo $m$, then $b$ is a *square root of $a$* (in $\mathbb{Z}/m\mathbb{Z}$).
:::

Note that the number of square roots can vary.  For instance, in $\mathbb{Z}/2\mathbb{Z}$, the element $1$ has a single square root, namely $1$ itself.  In $\mathbb{Z}/3\mathbb{Z}$, it has two, namely $1$ and $-1 = 2$.  In $\mathbb{Z}/8\mathbb{Z}$ it has four: $1$, $3$, $5$, and $7$.  But, we have:

:::{prf:proposition} Number of Square Roots Modulo Odd Primes
:label: pr-n_sqrt_odd_p


If $p$ is an *odd* prime and $a \in \mathbb{F}^{\times}$ has a square root in $\mathbb{F}_p$, say $a = b^2$, then $a$ has *exactly two* square roots in $\mathbb{F}_p$, namely $b$ and $-b$ (or $p-b$).  Moreover, $0$ has a single square root, namely, $0$ itself.
:::

:::{prf:proof}
:nonumber:

Clearly we have that $-b$ is also a square root, since
```{math}
(-b)^2 = b^2 = a.
```
Also note that since $p \neq 2$, we have that $-b \neq b$, as if $b = -b$, then $p \mid 2b$, and so $p \mid b$.  This means that $b=0$ and so $a= b^2 = 0$, but we assumed that $a \in \mathbb{F}^{\times}$, so $a$ cannot be zero.

For the last part, just note that if $0 = b^2$, then $p \mid b^2$, and hence $p \mid b$ (since it is prime), i.e., $b = 0$ in $\mathbb{F}_p$.
:::

Note that square roots in $F_2$ are easy: $0$ and $1$ are their own square roots.

+++

### Computing Square Roots

But now, if $p$ is an *odd* prime and we know that $\mathbb{F}^{\times}$ is a square in $\mathbb{F}_p$, i.e., $a = b^2$ for some $b \in \mathbb{F}_p$ (e.g., by using {prf:ref}`pr-sqaures-fp`), how do we find $b$?

If $p \equiv 3 \pmod{4}$, it is relatively easy: we have that $a^{(p+1)/4}$ is a square root!  (Note that since $p \equiv 3 \pmod 4$, we have that $(p+1)/4$ is an *integer*!)  Indeed, if $a = b^2$, then, using {prf:ref}`Fermat's Little Theorem <th-flt-3>`
```{math}
\left( a^{(p+1)/4} \right)^2  = a^{(p+1)/2} = \left( b^2 \right)^{(p+1)/2} = b^{p+1} = b^{2 + p-1} = b^2 \cdot b^{p-1} = a \cdot 1 = a.
```
This computation is relatively fast with Fast Powering.

If $p$ is odd and $p \not\equiv 3 \pmod{4}$, then we must have that $p \equiv 1 \pmod{4}$.  In this case we use the [Tonelli–Shanks algorithm](https://en.wikipedia.org/wiki/Tonelli%E2%80%93Shanks_algorithm):


:::{prf:algorithm} Tonelli-Shanks Algorithm
:label: al-TS


Given a prime $p \equiv 1 \pmod{4}$ and some $a \in \mathbb{F}^{\times}$ that we know to be a square, then to find a square root of $a$ in $\mathbb{F}_p$ (i.e., to find $b \in \mathbb{F}_p$ such that $a=b^2$), we follow:

1) *Initialization*:
    1) Find integers $h$ and $m$ such that $p-1=2^h \cdot m$, with $m$ odd.  (We can use `h = valuation(p - 1, 2)` in Sage.)
    2) Find some $c \in \mathbb{F}^{\times}$ that is *not* a square in $\mathbb{F}_p$.  This can be done by taking a random elements and testing if it is a square.  We can use {prf:ref}`Quadratic Reciprocity <sec-quad_rec>` for testing.  Since the odds of picking a non-square is $50\%$, we should quickly find $c$.
    3) Set
    ```{math}
        \begin{align*}
         t &\leftarrow a^m,\\
         r &\leftarrow a^{(m+1)/2}.
       \end{align*}
    ```
   (Since $m$ is odd, $(m+1)/2$ is an integer.)
2) *Loop*: while $t \neq 1$:
    1) Compute the powers $t, t^2, t^4, \ldots$ (*by squaring the previous!*) until we get $-1$, and let $k$ be such $t^{2^{k-1}} = -1$.
    2) Update the values (*in this order*):
  ```{math}
\begin{align*}
    d &\leftarrow \left( c^m \right)^{2^{h-k-1}}\\
    t & \leftarrow d^2 \cdot t \\
    r & \leftarrow d \cdot r.
  \end{align*}
```
3) *Return:* $r$ (and/or $-r$).
:::


:::{note}

The Tonelli-Shanks algorithm also works for $p \equiv 3 \pmod{4}$, but the previous method is faster.
:::

+++

#### Why Does It Work?

Let's verify that the Tonelli-Shanks Algorithm works.  So, let $p$ be an odd prime and $a \in \mathbb{F}^{\times}$ that is a square in $\mathbb{F}_p$.  We then set $p-1 = 2^h \cdot m$, with $m$ odd, $t = a^m$, and $r = a^{(m+1)/2}$.  If $t=1$, then using {prf:ref}`Fermat's Little Theorem <th-flt-3>`, we have
```{math}
r^2 = \left( a^{(m+1)/2} \right)^2 = a^{m+1} = a^{p-1} = 1.
```
Hence, $r$ is a square root of $a$ as needed.

So, suppose now that $t \neq 1$.  This means that $|t| \neq 1$, but what is $|t|$?  Since $p-1 = 2^h \cdot m$ and using {prf:ref}`pr-squares-fp`, we have that
```{math}
t^{2^{h-1}} = (a^m)^{2^{h-1}} = a^{2^{h-1} \cdot m} = a^{(p-1)/2} = 1,
```
Hence, by {prf:ref}`pr_power_one-2`, we have that $|t| \mid 2^{h-1}$, so $|t| = 2^k$ for some $0 < k \leq h-1$.  We need to find this order, so we compute $t^2, (t^2)^2 = t^4, (t^4)^2 = t^8$, etc., until we get $-1$, as we know that the next power will give us $1$ (and that is the *only* way we can get to $1$).  Hence, the power that gives $-1$ will be $t^{2^{k-1}}$.

Then, we have
```{math}
r^2 = \left( a^{(m+1)/2} \right)^2 = a^{m+1} =a \cdot a^m = a \cdot t,
```
and so we have
```{math}
\begin{align*}
\label{eq-TS1}
r^2 &= a \cdot t, \\
|t| &= 2^k, \quad \text{for some $1 \leq k \leq h-1$}.
\end{align*}
```

Let now $c \in \mathbb{F}^{\times}$ not a square and let
```{math}
\begin{align*}
d &= \left( c^m \right)^{2^{h - k - 1}}, \\
t' &= d^2 \cdot t, \\
r' &= d \cdot r.
\end{align*}
```
Then, we have
```{math}
(r')^2 = d^2 \cdot r^2 = d^2 \cdot a \cdot t = (d^2 \cdot t) \cdot a = t' \cdot a.
```
Thus, it $t' = 1$, then $r'$ is a square root of $a$ and needed.  Moreover, by {prf:ref}`pr-squares-fp`, we have
\begin{align}
(t')^{2^{k-1}} &= (d^2 \cdot t)^{2^{k-1}} = d^{2^k} \cdot t^{2^{k-1}} \\
&= \left( \left( c^m \right)^{2^{h - k - 1}} \right)^{2^k} \cdot (-1) = - \left( c^m \right)^{2^{h-1}}\\
&= -c^{2^{h-1}m} = -c^{(p-1)/2} = -(-1) \\
&=1
\end{align}
This means that $|t'| \mid 2^{k-1}$, and hence $|t'| = 2^{k'}$ for some $0 < k' < k$.  So, we get a "new version" of {prf:ref}`eq-TS1`:
```{math}
\begin{align*}
(r')^2 &= a \cdot t' \\
|t'| &= 2^{k'}, \quad \text{for some $1 \leq k' \leq k-1$}.
\end{align*}
```
The important thing here is that $|t'| < |t|$.  If we repeat now the process, eventually we will get that the "new $t$" must have order $1$ and the corresponding $r$ is the square root of $a$.

+++

#### Example

Let's illustrate the algorithm with an example.  We will take $p = 5{,}756{,}436{,}641$.

```{code-cell} ipython3
p = 5756436641
```

Note that $p \equiv 1 \pmod{4}$:

```{code-cell} ipython3
p % 4
```

We have that $5$ is a square in $\mathbb{F}_p$:

```{code-cell} ipython3
a = Mod(5, p)
# a^((p-1) / 2)
a.is_square()
```

Let's find a square root of $5$.  We find $h$ and $m$, with $m$ odd, such that $p-1= 2^h \cdot m$:

```{code-cell} ipython3
h = valuation(p - 1, 2)
m = (p - 1) // 2^h
```

We then initialize $t$ and $r$, and check if $t = 1$:

```{code-cell} ipython3
t, r = a^m, a^((m + 1)/2)
t
```

Since it is not, we have to start the loop, but before that we need to find the non-square $c$.  Here I just typed a random number and checked it was not a square.  If it were, I could type another one and try again, until finding a non-square.

```{code-cell} ipython3
c = Mod(573847843, p)
c.is_square()
```

:::{important}

In practice, you would find `c` with something like:

```python
c = Mod(randint(2, p-1), p)
while c.is_square():
    c = Mod(randint(2, p-1), p)
```

The reason that I did not do that here is because I need some control over the number of steps, which varies depending on `c`.  So, I tried a few and found one with a reasonable number of steps to illustrate the process.
:::


Now, we need to find $k$ such that $|t|^2{k}$.  We do that with a simple loop:

```{code-cell} ipython3
k = 1
t_power = t  # powers of t
while t_power != Mod(-1, p):
    k += 1
    t_power ^= 2  # square previous
k
```

With $k$ in hand, we can get our new values:

```{code-cell} ipython3
d = (c^m)^(2^(h - k - 1))
t = d^2 * t
r = d * r
```

We check $t$ again.

```{code-cell} ipython3
t
```

It is still not $1$, so we repeat the process:

```{code-cell} ipython3
k = 1
t_power = t
while t_power != Mod(-1, p):
    k += 1
    t_power ^= 2

d = (c^m)^(2^(h - k - 1))
t = d^2 * t
r = d * r

t
```

We need to repeat again:

```{code-cell} ipython3
k = 1
t_power = t
while t_power != Mod(-1, p):
    k += 1
    t_power ^= 2

d = (c^m)^(2^(h - k - 1))
t = d^2 * t
r = d * r

t
```

It is now $1$!  So, `r` should be our square root:

```{code-cell} ipython3
r
```

Let's check:

```{code-cell} ipython3
r^2 == a
```

(sec-hl)=
## Square Roots Modulo Powers of Primes

Now we know how to find if $a$ has a square root in $\mathbb{Z}/p\mathbb{Z}$ and to compute it if it does.  How about in $\mathbb{Z}/p^n\mathbb{Z}$ for some $n > 1$?  We can easily do it using [Hensel's Lemma](https://en.wikipedia.org/wiki/Hensel%27s_lemma).  In fact, we need only a restricted version that we state below:

:::{prf:theorem} Square Roots Module $\mathbb{Z}/p^n\mathbb{Z}$ for $n>1$ and $p$ Odd Prime
:label: th-hl-sqrt-odd


Let $p$ be an odd prime, $a$ an integer not divisible by $p$, and suppose that there is some integer $b_k$ such that $b_k^2 \equiv a \pmod{p^k}$ for some $k \geq 1$, i.e., $b_k$ is a square root of $a$ modulo $p^k$.  Then let
```{math}
\begin{align*}
  c_k &= \text{an inverse of $2a_k$ modulo $p^{k+1}$ (an integer)},\\
  \Delta_k &= -(b_k^2 - a) \cdot c_k \text{ reduced modulo $p^{k+1}$}, \\
  b_{k+1} &= b_k + \Delta_k.
\end{align*}
```
Then, $b_{k+1}^2 \equiv a \pmod{p^{k+1}}$, i.e., $b_{k+1}$ is a square root of $a$ modulo $p^{k+1}$.

Moreover, if $b^2 \equiv a \pmod{p^{k+1}}$ and $b \equiv b_k \pmod{p^k}$, then $b \equiv b_{k+1} \pmod{p^{k+1}}$, with $b_{k+1}$ obtained from $b_k$ using the procedure above.
:::

Let's break down what this means.  First note that if $a$ has no square root modulo $p$, it cannot have a square root modulo any $p^k$ with $k \geq 1$, as if $b$ is a square root modulo $p^k$, then $p^k \mid (b^2 - a)$, which means that $p \mid (b^2 - a)$ and so this same $b$ is a square root modulo $p$ as well.

Now if $a$ does have a square root modulo $p$, say $b_1$, the theorem above tells us how to obtain a square root modulo $p^2$, say $b_2$.  Then, from this square root modulo $p^2$ we can construct a square root modulo $p^3$, say $b_3$.  We can iterate this process to obtain a square root of $a$ modulo *any* power of $p$!

We know that if $a$ has a square root modulo $p$, and $a \not\equiv 0 \pmod{p}$, then $a$ has exactly two roots modulo $p$: if $b_1$ is one of them, then $-b_1$ is the other.  (Since $p \neq 2$, we have that $b_1 \not\equiv -b_1 \pmod{p}$.)  So, how many square roots do we have modulo $p^2$?

Suppose that $b$ is a square root of $a$ modulo $p^2$, i.e., $p^2 \mid (b^2 - a)$.  Then, clearly $p \mid (b^2 - a)$, i.e., $b$ is also a square root modulo $p$.  Therefore, either $b \equiv b_1 \pmod{p}$ or $b \equiv -b_1 \pmod{p}$.  The latter part of the theorem tells us that $b$ then is congruent to the square root obtained by the procedure if gives starting with the corresponding root modulo $p$.  Therefore, there are only two roots modulo $p^2$: $b_2$, obtained from $b_1$ using the theorem, and the one obtained from the theorem from $-b_1$.  It is not hard to see that this latter one must simply be $-b_2$.

Hence, if we iterate this process, we can see that if $a$ has a square root modulo $p$, is has *exactly* two square roots module $p^k$ *for any $k \geq 1$*.

Let's prove the theorem:

:::{prf:proof} Proof of {prf:ref}`th-hl-sqrt-odd`
:nonumber:

First, note since $p \nmid a$ and $p^k \mid (b_k^2 - a)$, we have that $p \nmid b_k$.  Then, since $p$ is odd, we have that $p \nmid 2b_k$, and hence $\gcd(p^{k+1}, 2b_k) = 1$.  Therefore, there is some integer $c_k$ such that
```{math}
c_k \cdot 2b_k \equiv 1 \pmod{p^{k+1}}.
```

Then,
```{math}
\begin{align*}
  b_{k+1}^2 &= (b_k + \Delta_k)^2 \\
  &= b_k^2 + 2b_k \Delta_k + \Delta_k^2 \\
  &= b_k^2 - 2b_k (b_k^2 - a)c_k + (b_k^2 - a)^2 c_k^2 \\
  &\equiv b_k^2 - (b_k^2 - a) + (b_k^2 - a)^2 c_k^2  & \text{(since $c_k$ is an inverse of $2a_k$ modulo $p^{k+1}$)}\\
  &\equiv a + (b_k^2 - a)^2 c_k^2 \pmod{p^{k+1}}
\end{align*}
```

Now, we know that $p^k \mid (b_k^2 - a)$, so $p^{2k} \mid (b_k^2 - a)$, and since $2k > k+1$ (as $k \geq 1$), we have that $p^{k+1} \mid (b_k^2 - a)$.  Hence, in the expression above we get $b_{k+1}^2 \equiv a \pmod{p^{k+1}}$.

For the second part, suppose that $b^2 \equiv a \pmod{p^{k+1}}$ and $b \equiv b_k \pmod{p^k}$, where $b_k^2 \equiv a \pmod{p^k}$.

Also, using the algorithm in the first part we can construct $b_{k+1}$ such that $b_{k+1}^2 \equiv a \pmod{p^{k+1}}$.  (We need to show $b \equiv b_{k+1}$.)  Note that since $b_k^2 \equiv a \pmod{p^k}$, we have that $\Delta_k = -(b_k^2 -a)c_k \equiv 0 \cdot c_k = 0 \pmod{p^k}$, so $b_{k+1} = b_k + \Delta_k \equiv b_k + 0 = b_k \pmod{p^k}$.

So, we have that
```{math}
b \equiv b_k \equiv b_{k+1} \pmod{p^k},
```
and hence, $p \mid (b - b_{k+1})$.  We also have
```{math}
b^2 \equiv  \equiv a \equiv b_{k+1}^2 \pmod{p^{k+1}},
```
which means that $p^{k+1} \mid b^2 - b_{k+1}^2 = (b - b_{k+1})(b + b_{k+1})$.  If $p \nmid (b + b_k)$, then we must have that $p^k \mid (b - b_{k+1})$, and we are done!

But if $p \mid (b + b_{k+1})$, since also $p \mid (b - b_{k+1})$, we have that $p$ must divide the sum $2b$.  Since $p$ is odd, it must be the case that $p \mid b$.  But $b \equiv b_k \not\equiv 0 \pmod{p}$, so it cannot happen.
:::

+++

### Algorithm

Let's describe now the algorithm that given a square root $b$ of $a$ modulo an odd prime $p$ and some $n$, finds the square root of $a$ modulo $p^n$.

:::{prf:algorithm} Square Root Modulo Powers of Odd Primes
:label: al-sqrt-power-p


Given an odd prime $p$ and integer $a$ not divisible by $p$, a square root of $b$ of $a$ modulo $p$, and some integer $n \geq 1$, we find a square root of $a$ modulo $p^n$:

1) For $k$ in $\{2, 3, 4, \ldots, n\}$, we do:
   1) Set $c$ as an inverse of $2b$ modulo $p^k$.
   2) Set $\Delta$ as the reduction modulo $p^k$ of $c \cdot (b^2 - a)$.
   3) Set $b \leftarrow b + \Delta$.
2) Return $b$.
:::

+++

### Example

Let's find a square root of $3$ in $\mathbb{Z}/13^4\mathbb{Z}$.  First, we can find, with previous methods, a square root modulo $13$: $4$ is one, since $4^2 = 16 \equiv 3 \pmod{13}$.  So, have $b = 4$.

```{code-cell} ipython3
a = 3
p = 13
b = 4
```

Now, we set:

```{code-cell} ipython3
c = ZZ(Mod(-2 * b, p^2)^(-1))
Delta = c * (b^2 - a) % p^2
b = b + Delta % p^2
b
```

If this worked, then we must have that the new $b$ is a square root modulo $p^2$:

```{code-cell} ipython3
Mod(b, p^2)^2 == Mod(a, p^2)
```

Now, we repeat, with powers adjusted:

```{code-cell} ipython3
c = ZZ(Mod(-2 * b, p^3)^(-1))
Delta = c * (b^2 - a) % p^3
b = b + Delta % p^3
b
```

And check:

```{code-cell} ipython3
Mod(b, p^3)^2 == Mod(a, p^3)
```

Finally, we get to the fourth power:

```{code-cell} ipython3
c = ZZ(Mod(-2 * b, p^4)^(-1))
Delta = c * (b^2 - a) % p^4
b = b + Delta % p^4
b
```

And the final check:

```{code-cell} ipython3
Mod(b, p^4)^2 == Mod(a, p^4)
```

:::{admonition} Homework
:class: note

You will implement this algorithm in your Homework.
:::

+++

## Square Roots Module Powers of $2$

{prf:ref}`th-hl-sqrt-odd` does not apply when $p=2$.  In fact, the case when $p=2$ is more complicated.  But before we give the version of the theorem for $p=2$, let's first investigate when we have square roots modulo $2^n$ and how many square roots we have.

:::{prf:proposition} Number of Square Roots Modulo $2^n$
:label: pr-n-roots-power-2


Let $a$ be an *odd* integer and $k \geq 3$.

1) If $a \not\equiv 1 \pmod{3}$, then there are no square roots of $a$ modulo $2^k$ (i.e., $a$ is not a square in $\mathbb{Z}/2^k\mathbb{Z}$).
2) If $a \equiv 1 \pmod{3}$, then there are *exactly* four square roots of $a$ modulo $2^k$ (in particular, $a$ is a square in $\mathbb{Z}/2^k\mathbb{Z}$).
:::

:::{prf:proof}
:nonumber:

For the first item, we have that if $b$ is square root module $2^k$, then it is also a square root modulo $8$ since $k \geq 3$.  And we can just check by hand that $1$ the only odd that is a square modulo $8$:
```{math}
1^2 \equiv 3^3 \equiv 5^2 \equiv 7^2 \equiv 1 \pmod{8}.
```
We can see then that the square roots of $1$ are four: $1$, $3$, $5$, and $7$.

Now suppose that $a \equiv 1 \pmod{8}$.  We must show that there is a solution.  This will follow from our next result, (#th-hl-sqrt-2), which does not rely on this current proposition.

Now, let's show that if there is a square root modulo $2^k$, for $k \geq 3$, then there are exactly $4$ square roots.  Suppose that $x$ and $y$, with $x \neq y$, are two such roots, i.e.,
```{math}
x^2 \equiv a \equiv y^2 \pmod{2^k},
```
and hence $2^k \mid y^2 - x^2 = (y-x)(y+x)$.

Since $a$ is odd, we must have that $x$ and $y$ are also odd, and so $2 \mid (y-x)$ and $2 \mid (y+x)$.  Since $2^k \mid (y-x)(y+x)$, together $y-x$ and $y+x$ must have $k$ factors of $2$.


Suppose the $4$ also divides both.  (We will show that this cannot happen.)  If so, then $4$ would also divide their sum $2x$, but that means that $x$ even, but we know it is odd.  So, $4$ divides only one of them, this one must have $k-1$ factors of $2$.  We will write that $2^{k-1} \mid y + ux$, where $u$ is either $1$ or $-1$.  And, hence, we have that
```{math}
y \equiv -ux + t 2^{k-1} \pmod{2^k}
```
where $t$ is either $0$ or $1$.

Therefore, since we have two choices (modulo $2^k$) for each of $u$ ($1$ or $-1$) and $t$ ($0$ or $1$), we have four possible values for $y$ (modulo $2^k$) for a fixed square root $x$ of $a$ (which includes $x$ itself, when $u=-1$ and $t=0$), and hence we have *at most* four possible roots.

Therefore, to finish the proof, we just need to show that these are all distinct modulo $2^k$.  But:

1) For $t \in \{0, 1\}$, we have that
```{math}
x + t2^{k-1} \not\equiv -x t2^{k-1} \pmod{2^k},
```
since $x$ is odd (and $k \geq 3$), and so $2x \not\equiv 0 \pmod{2^k}$.  (This takes care of the cases when we have the same value of $t$ for two possible solutions.  So now we need to check when we have different values.)

2) For $u \in \{-1, 1\}$, we have that
```{math}
ux \not\equiv ux + 2^{k-1} \pmod{2^k},
```
since $2^{k-1} \not\equiv 0 \pmod{2^k}$.  (This takes care of cases when we have different values of $t$, but the same value for $u$.)

3) For $u \in \{-1, 1\}$, we have that
```{math}
ux \not\equiv -ux + 2^{k-1} \pmod{2^k},
```
since $\pm 2x + 2^{k-1} \not\equiv 0 \pmod{2^k}$, since $x$ is odd.  (This takes care of cases when we have different values of $t$ and $u$.)
:::

:::{important}

As it can be seen in the proof above, if we have one root $b$ of $a$ modulo $2^k$, then all roots are:
```{math}
b, \qquad -b, \qquad b + 2^{k-1}, \qquad -b + 2^{k-1}.
```
:::

Here is the equivalent version of {prf:ref}`th-hl-sqrt-odd`:

:::{prf:theorem} Square Roots Module $\mathbb{Z}/2^n\mathbb{Z}$ for $n\geq3$
:label: th-hl-sqrt-2


Let $a$ an odd integer and suppose that there is some integer $b_k$ such that $b_k^2 \equiv a \pmod{2^k}$ (so $(b_k^2 - a)/2^k$ is an *integer*) for some $k \geq 3$, i.e., $b_k$ is a square root of $a$ modulo $2^k$.  Then let
```{math}
\begin{align*}
  c_k &= (b_k^2 - a)/2^k \text{reduced modulo $2$ (so it is either $0$ or $1$)},\\
  \Delta_k &= c_k \cdot 2^{k-1}, \\
  b_{k+1} &= b_k + \Delta_k.
\end{align*}
```
Then, $b_{k+1}^2 \equiv a \pmod{2^{k+1}}$, i.e., $b_{k+1}$ is a square root of $a$ modulo $2^{k+1}$.

Moreover, if $b^2 \equiv a \pmod{p^{k+1}}$ and $b \equiv b_k \pmod{p^{k-1}}$, then $b \equiv b_{k+1} \pmod{2^{k}}$, with $b_{k+1}$ obtained from $b_k$ using the procedure above.
:::

:::{caution}

Note that the second part is weaker than for $p$ odd: as we have $b \equiv b_{k+1} \pmod{2^{\color{red} k}}$ and not module $2^{k+1}$.
:::

:::{prf:proof}
:nonumber:

First, note that since $2^{k-1} \mid \Delta_k$, we have that $2^{k-2} \mid \Delta_k^2$.  Since $k \geq 3$, we have that $2k-2 \geq k + 1$, and we have that $2^{k+1} \mid \Delta_k^2$.  Thus
```{math}
\begin{align*}
b_{k+1}^2 &= (b_k + \Delta_k)^2 \\
&=b_k^2 + 2b_k \Delta_k + \Delta_k^2 \\
&\equiv b_k^2 + b_kc_k2^{k}\\
&\equiv b_k^2 + c_k2^{k} & \text{(since $b_k \equiv 1 \pmod{2}$)} \\
&= b_k^2 + a - b_k^2 = a \pmod{2^{k+1}}.
\end{align*}
```

Now suppose that $b^2 \equiv a \pmod{2^{k+1}}$ with $b \equiv b_k \pmod{2^{k-1}}$ and $b_{k+1}$ obtained from $b_{k}$ with the method above.  Then, $b = b_k + t \cdot 2^{k-1}$ for some integer $t$, and hence
```{math}
a \equiv b^2 = b_k^2 + b_k t 2^{k} \pmod{2^{k+1}}.
```
Since $b_k$ is odd, this implies that
```{math}
a - b_k^2 \equiv b_kt 2^k \equiv t 2^k \pmod{2^{k+1}},
```
and thus
```{math}
t \equiv \frac{a - b_k^2}{2^k} \equiv c_k \pmod{2}.
```
Hence,
```{math}
b = b_k + t \cdot 2^{k-1} \equiv b_k + c_k 2^{k-1} = b_k + \Delta_k = b_{k+1} \pmod{2^k}.
```
:::

+++

### Example

Let's find a square root of $a=33$ modulo $2^7$.  Firstly, we might ask if such square root exist.  But, since $33 \equiv 1 \pmod{8}$, by {prf:ref}`pr-n-roots-power-2`, the square root exists.

The first step is to find a root modulo $8$, and $1$, $3$, $5$, and $7$ all are.  In fact, different ones *might* give different square roots modulo $2^6$ with the process from {prf:ref}`th-hl-sqrt-2`.  Let's use $3$ here in this example.  (In principle we could *always* use $1$ (or $3$, or $5$ or $7$), but we use $3$ just to show it also works.)  We then have:
```{math}
\begin{align*}
c_3 &= \frac{33 - 1^2}{2^3} = \frac{24}{8} = 3 \equiv 1 \pmod{2} \\
\Delta_3 &= 1 \cdot 2^2 = 4 \\
b_4 &= 3 + 4 = 7.
\end{align*}
```

We then should have that $b_4$ is a square root modulo $2^4$, and indeed:
```{math}
7^2 = 49 \equiv 33 \pmod{16}.
```

Next, we have:
```{math}
\begin{align*}
c_4 &= \frac{33 - 7^2}{2^4} = \frac{-16}{16} = -1 \equiv 1 \pmod{2} \\
\Delta_4 &= 1 \cdot 2^3 = 8 \\
b_5 &= 7 + 8 = 15.
\end{align*}
```

And indeed, we do have:
```{math}
15^2 = 225 = 1 + 224 = 1 + 32 \cdot 7 \equiv 1 \equiv 33 \pmod{2^5}.
```

Next:
```{math}
\begin{align*}
c_5 &= \frac{33 - 15^2}{2^5} = \frac{-192}{32} = -6 \equiv 0 \pmod{2} \\
\Delta_5 &= 0 \cdot 2^4 = 0 \\
b_6 &= 15 + 0 = 15.
\end{align*}
```

And, checking, we have:
```{math}
15^2 = 225 = 33 + 3 \cdot 64 \equiv 33 \pmod{2^6}
```

And, finally:
```{math}
\begin{align*}
c_6 &= \frac{33 - 15^2}{2^6} = \frac{-192}{64} = -3 \equiv 1 \pmod{2} \\
\Delta_6 &= 1 \cdot 2^5 = 32 \\
b_7 &= 15 + 32 = 47.
\end{align*}
```

And, our final check:
```{math}
47^2 = 2209 = 33 + 17 \cdot 128 \equiv 33 \pmod{2^7}.
```
So, $47$ is a square root of $33$ modulo $2^7 = 128$.  The other roots are:
```{math}
\begin{align*}
-47 &\equiv 81 \pmod{128}, \\
47 + 64 &\equiv 111 \pmod{128}, \\
-47 + 64 &\equiv 17 \pmod{128}.
\end{align*}
```


:::{caution}

It is worth noting that if we started with $1$, instead of $3$, our algorithm would give the square root $17$.  Starting with $5$ and $7$ would give the square roots $17$ and $47$, respectively.  Therefore, the square roots $81$ and $111$ would not be obtained *directly* from this method.  We need to find other roots as described before.
:::

+++

### Implementation

Here is a function that returns all square roots of a number congruent to $1$ modulo $8$  modulo a given power of $2$.

```{code-cell} ipython3
def sqrt_mod_power_2(a, n):
    """
    Given an integer a and a exponent n, returns all square roots of
    a modulo 2^n for .

    INPUTS:
    a: a integer for which we compute the square root modulo 2^n;
    n: an integer equal to 3 or larger, that is the exponent of 2 for the modulus
       of the square root.

    OUTPUT: A list containing all four square roots of a modulo 2^n in increasing
    order.  If not square root exists, returns the empty list.
    """
    #  check if square root exists
    if a % 8 != 1:
        # no square root
        return []

    b = 1  # use 1 for square root modulo 8

    # find one root
    for k in range(3, n):
        c = ((a - b^2) // 2^k) % 2
        Delta = c * 2^(k - 1)
        b += Delta

    return sorted([
        b % 2^n,
        -b % 2^n,
        (b + 2^(n - 1)) % 2^n,
        (-b + 2^(n - 1)) % 2^n,
    ])
```

As an example, here are the square roots we've computed above.

```{code-cell} ipython3
sqrt_mod_power_2(33, 7)
```
