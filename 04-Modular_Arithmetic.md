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

# Modular Arithmetic

+++

## Congruences

+++

*Congruences* are very important in Number Theory in general, and will play a big role in many of our applications in cryptography.

:::{prf:definition}
Let $a$, $b$, and $m$ be integers, with $m > 1$.  We say that $a$ is *congruent* to $b$ *modulo* $m$ if $m \mid (a - b)$.  We can denote it by:
```{math}
a \equiv b \pmod{m}.
```
In this case, $m$ is called the *modulus*.
:::

So, it is very easy to check for congruences!  It is just a question about divisibility.


**Examples:**
1) Is $43$ congruent $11$ modulo $8$?  We just check if $8$ divides $43-11 = 32$.  Since it does, the answer is *yes*:
```{math}
43 \equiv 11 \pmod{8}.
```
2) Is $-21$ congruent to $50$ modulo $11$?  We just check if $11$ divides $-21 - 50 = -71$.  Since it doesn't, the answer is *no*:
```{math}
-21 \not\equiv 50 \pmod{11}.
```
3) Is $2{,}694{,}540$ congruent to $412{,}004{,}939$ module $3{,}544$?  Well, this is hard to do by hand, but easy with Sage:

```{code-cell} ipython3
a, b, m =  2694540, 412004939, 3544
(a - b) % m == 0
```

So, *no*!

+++

Here are some important remarks about congruences:

:::{prf:remark}
:enumerated: false

1) We have that $a \equiv b \pmod{m}$ if, and only if, we have that $a = b + km$ for some integer $k$.

   (*Proof:*  Since $a-b$ is divisible by $m$, it is equal to $km$ for some integer $k$.)
3) We always have $a \equiv a \pmod{m}$.

   (*Proof:* Any integer $m$ divides $0 = a - a$.)
4) If $a \equiv b \pmod{m}$, then $b \equiv a \pmod{m}$.

   (*Proof:* If $m$ divides $a-b$, then it also divides $-(a-b) = b-a$.)
5) If $a \equiv b \pmod{m}$ and $b \equiv c \pmod{m}$, then $a \equiv c \pmod{m}$.

   (*Proof:* If $m$ divides $a-b$ and $b-c$, it also divides its sum $(a-b) + (b-c) = (a-c)$.)
6) We have that $a \equiv 0 \pmod{m}$ if, and only if, $a$ is divisible by $m$.
7) If $r$ is the remainder of the division of $a$ by $m$, then $a \equiv r \pmod{m}$.

   (*Proof:*  By long division, we have that $a = mq + r$, so $a-r = qm$.)
8) If $r \in \{0, 1, 2, \ldots, m- 1\}$ (this means that $r$ *belongs to* the set $\{0, 1, 2, \ldots, m-1\}$), then $a \equiv r \pmod{m}$ only if $r$ is the remainder of the division of $a$ by $m$.
9) We have that $a \equiv b \pmod{m}$ if, and only if, $a$ and $b$ have the same remainder when divided by $m$.
:::

+++

These last three facts are very important.  They say we can break the set of all integers in $m$ pieces, depending on the remainder of the division by $m$.  More concretely, for $m=5$, every integer is congruent to one, and only one, among $0$, $1$, $2$, $3$, and $4$ (the possible remainders of the division by $5$):

```{math}
\begin{align*}
\cdots -15 \equiv -10 \equiv -5 \equiv {\color{red} 0} \equiv 5 \equiv 10 \equiv 15 \equiv \cdots \pmod{5}\\
\cdots -14 \equiv -9 \equiv -4 \equiv {\color{red} 1} \equiv 6 \equiv 11 \equiv 16 \equiv \cdots \pmod{5}\\
\cdots -13 \equiv -8 \equiv -3 \equiv {\color{red} 2} \equiv 7 \equiv 12 \equiv 17 \equiv \cdots \pmod{5}\\
\cdots -12 \equiv -7 \equiv -2 \equiv {\color{red} 3} \equiv 8 \equiv 13 \equiv 18 \equiv \cdots \pmod{5}\\
\cdots -11 \equiv -6 \equiv -1 \equiv {\color{red} 4} \equiv 9 \equiv 14 \equiv 19 \equiv \cdots \pmod{5}
\end{align*}
```

+++

So, we often call the remainder of $a$ when divided by $m$ the *residue* modulo $m$.  Most calculators have a "MOD" button to compute this residue/remainder.  In Python/Sage we have `%`.

```{code-cell} ipython3
101 % 37  # residue of 101 modulo 37, or remainder of 101 when divided by 37
```

## Arithmetic and Congruences

+++

Here is very important result:

:::{prf:theorem}
Let $m$ be an integer greater than $1$ and suppose that
```{math}
a_1 \equiv a_2 \pmod{m} \quad \text{and} \quad b_1 \equiv b_2 \pmod{m}.
```
Then
```{math}
\begin{align*}
a_1 + b_1 &\equiv a_2 + b_2 &&\pmod{m}, \\
a_1 - b_1 &\equiv a_2 - b_2 &&\pmod{m}, \\
a_1 \cdot b_1 &\equiv a_2 \cdot b_2 &&\pmod{m}, \\
a_1^k &\equiv a_2^k &&\pmod{m} \quad \text{for any positive integer $k$.}
\end{align*}
```
:::


So, "$\equiv$" is *similar* to "$=$" in computations.  In congruences with sums, differences, and products, we can replace a number by another that is congurent to it.  Let's see it in action in an example:

+++

:::{prf:example}
What is the remainder of
```{math}
5647438438 \cdot 85948594584 - 7548376839
```
when divided by $5$?
:::

We could compute this huge number, then do the long division to find the remainder.  But note that asking for the remainder modulo $5$ is the same to ask for a number between $0$ and $4$ congruent to the number:

```{math}
5647438438 \cdot 85948594584 - 7548376839 \equiv \, ??? \pmod{5}.
```

The idea now is that the theorem above allows us to replace each of the three large numbers by smaller numbers congruent to them modulo $5$, making the computation much simpler!  As we've seen above, we can replace them by their residues modulo $5$ (i.e., their remainders when divided by $5$), so numbers between $0$ and $4$.

Of course, we could just ask Sage for their residues, but we can in fact compute residues modulo $5$ quite easily using the Theorem and the fact that $10 \equiv 0 \pmod{5}$.  For example, let's find the residue of the first number modulo $5$:

```{math}
\begin{align*}
5647438438 &= 5647438430 + 8 \\
&= 564743843 \cdot {\color{red} 10}  + 8 \\
&\equiv 564743843 \cdot {\color{red} 0} + 8 && \text{(since $10 \equiv 0 \pmod{5}$)} \\
&= 8 \\
&= {\color{red} 5} + 3 \\
&\equiv {\color{red} 0} + 3 && \text{(since $5 \equiv 0 \pmod{5}$)} \\
&= 3 \pmod{5}
\end{align*}
```

The same idea shows that a *positive* number is always congruent to its *last digit* modulo $5$!  So, we have:
```{math}
\begin{align*}
8594859458{\color{blue} 4} &\equiv {\color{blue} 4} \pmod{5},\\
754837683{\color{blue} 9} & \equiv {\color{blue} 9} = {\color{red} 5} + 4 \equiv {\color{red} 0} + 4 = 4 \pmod{5}.
\end{align*}
```

So, we have:
```{math}
\begin{align*}
{\color{red} 5647438438} &\equiv {\color{red} 3} \pmod{5}, \\
{\color{blue} 85948594584} &\equiv {\color{blue} 4} \pmod{5},\\
{\color{green} 7548376839} & \equiv {\color{green} 4} \pmod{5}.
\end{align*}
```

Now, using the theorem, we can do:

```{math}
\begin{align*}
{\color{red} 5647438438}  \cdot {\color{blue} 85948594584} - {\color{green} 7548376839}
&\equiv {\color{red} 3} \cdot {\color{blue} 4} - {\color{green} 4} \\
&\equiv 8 = {\color{orange} 5} + 3 \\
&\equiv {\color{orange} 0} + 3 = \boxed{3}  \pmod{5}
\end{align*}
```

So, the remainder is $3$!

+++

```{prf:example}

What is the remainder of $13^{1{,}000{,}000{,}000}$ when divided by $7$?
```

We can again think in terms of congruences and we are asking for a number between $0$ and $6$ congruent to $13^{1{,}000{,}000{,}000}$ modulo $7$. And again, by the Theorem, we can replace $13$ by its residue modulo $7$ in a congruence, and clearly $13 = 7 \cdot 1 + 6$, so we have
```{math}
13^{1{,}000{,}000{,}000} \equiv 6^{1{,}000{,}000{,}000} \pmod{7}.
```
The problem is that, although much better, the number of the right is still *humongous*, too large even for computers!

```{warning}
We *cannot* replace the *exponent* by its residue modulo $7$!  It is not part of the theorem and it does not work in general.  We will later see how we can reduce the exponent as well, *but with a different modulus*!
```

So, for now, we can use a different trick.  Note that $6 \equiv -1 \pmod{7}$, and so we have:

```{math}
\begin{align*}
13^{1{,}000{,}000{,}000}
&\equiv 6^{1{,}000{,}000{,}000} \\
&\equiv (-1)^{1{,}000{,}000{,}000} \\
&= \boxed{1} \pmod{7}.
\end{align*}
```

+++

## Inverses Modulo $m$

+++

:::{prf:definition} Inverse Modulo $m$
:label: def-inv
:numbered: true

Let $a$, $b$, and $m$ be integers with $m>1$.  Then we say that $a$ is the *inverse* of $b$ *modulo* $m$ (or that $b$ is the *inverse* of $a$ *modulo* $m$) if $ab \equiv 1 \pmod{m}$.
:::

For instance, $2$ is the inverse of $3$ modulo $5$, since $2 \cdot 3 = 6 = 1 + 5 \equiv 1 \pmod{5}$.

:::{note}

Here I said "the" inverse instead of "a" inverse, since any two inverses will be congruent.  For instance, we also have that $2 \cdot 8 = 16 \equiv 1 \pmod{5}$, but note that $8 \equiv 3 \pmod{5}$.  In fact, we have that $2b \equiv 1 \pmod{5}$ if, and only if, we have that $b \equiv 3 \pmod{5}$.
:::

+++

Note that not all numbers have inverses.  Clearly $0$ has no inverse modulo any modulus.  But also, for instance, $2$ has no inverse modulo $6$:

```{code-cell} ipython3
for i in range(6):
    print(f"2 * {i} is {(2 * i) % 6} modulo 6.")
```

So, we never get $1$.  Note we do not need to go beyond $5$ by the previous theorem, as $6 \equiv 0 \pmod{6}$, $7 \equiv 1 \pmod{6}$, etc.

+++

Let's write a function that given a modulus $m$, returns all the numbers between $0$ and $m-1$ which have inverses:

```{code-cell} ipython3
def find_inverses(m):
    """
    Given a modulus m, finds all invertible elements modulo m.

    INPUT:
    m: the modulus (integer greater than 1.)

    OUTPUT:
    A set of elements between 0 and m-1 invertible modulo m.
    """
    invertible = set()  # all invertible elements
    for i in xsrange(m):  # test them all
        if i not in invertible:  # no need to test if already there
            for j in xsrange(m):  # look for inverse
                if (i * j) % m == 1:
                    # both i and j are invertible!
                    invertible = invertible.union({i, j})
    return invertible
```

Let's see if we can find some pattern:

```{code-cell} ipython3
for m in xsrange(2, 21):
    print(f"{m:>2}: {sorted(list(find_inverses(m)))}")
```

Can we tell something from these examples?

If we pay attention, we will see:

:::{prf:theorem}
:label: th-inv
:numbered: true

An integer $a$ is invertible modulo $m$ if, and only if, $\gcd(a, m) = 1$.  In other words,
```{math}
ax \equiv 1 \pmod{m}
```
has a solution (with $x$ *integer*) if, and only if, $\gcd(a, m) = 1$.
:::

This is not hard to see.

First, suppose that $\gcd(a, m) = 1$.  (We want to show that $a$ has an inverse modulo $m$.)  By Bezout's Lemma, we have that there are integers $u$ and $v$ such that
```{math}
1 = au + mv.
```
But then, since $m \equiv 0 \pmod{m}$, we have that
```{math}
1 \equiv au + mv  \equiv au + 0 = au \pmod{m}.
```
So, the $u$ found by the Extended Euclidean Algorithm is the inverse of $a$!

+++

Now, assume that $a$ has an inverse $b$ modulo $m$.  (We want to show that $\gcd(a, m)=1$.)  This means that
```{math}
ab \equiv 1 \pmod{m},
```
which means that there is some integer $k$ such that
```{math}
ab = 1 + km, \qquad \text{or} \qquad ab - mk = 1.
```
Now, let $d = \gcd(a,m)$.  Then:

1) $d$ divides $a$ and $m$ (it is a common divisor); so
2) $d$ divides $ab$ and $mk$; so
3) $d$ divides $ab - mk$; so
4) $d$ divides $1$.

But the only positive integer that divides $1$ is $1$ itself, so, $1 = d = \gcd(a, m)$.

+++

### Computing Inverses Modulo $m$

+++

As we can see above, we know how to compute inverses!  We just use the Extended Euclidean Algorithm!

:::{prf:example}
:numbered: false

Is $35$ invertible modulo $131$?  If so, find its inverse.
:::

We can find the answer to *both* using Sage's `xgcd`:

```{code-cell} ipython3
xgcd(35, 131)
```

The GCD (first output) is $1$, so it *is* invertible.  It also tells us that
```{math}
1 = 35 \cdot 15 + 131 (-4)
```
(careful with the order of the output!), so $15$ is the inverse.  Indeed:

```{code-cell} ipython3
(35 * 15) % 131
```

## The Ring of Integers Modulo $m$

+++

Given an integer $m > 1$, we can create a new set:
```{math}
\mathbb{Z} / m\mathbb{Z} = \{0, 1, 2, \ldots, (m-1)\}
```
where *congruences become equalities*!

:::{warning}

***These elements are not integers any more!***  They have different properties!  We will discuss that in more detail below, but it is very important to observe that from the start.
:::

To differentiate these elements from the actual integers, often times authors use an over bar for the elements of this set, as in
```{math}
\mathbb{Z} / m\mathbb{Z} = \{\bar{0}, \bar{1}, \bar{2}, \ldots, \overline{m-1}\}
```
But, we will not use the bars here.  We just have to be aware of the context.

So, while in $\mathbb{Z}$ we had

```{math}
\begin{align*}
\cdots -15 \equiv -10 \equiv -5 \equiv {\color{red} 0} \equiv 5 \equiv 10 \equiv 15 \equiv \cdots \pmod{5}\\
\cdots -14 \equiv -9 \equiv -4 \equiv {\color{red} 1} \equiv 6 \equiv 11 \equiv 16 \equiv \cdots \pmod{5}\\
\cdots -13 \equiv -8 \equiv -3 \equiv {\color{red} 2} \equiv 7 \equiv 12 \equiv 17 \equiv \cdots \pmod{5}\\
\cdots -12 \equiv -7 \equiv -2 \equiv {\color{red} 3} \equiv 8 \equiv 13 \equiv 18 \equiv \cdots \pmod{5}\\
\cdots -11 \equiv -6 \equiv -1 \equiv {\color{red} 4} \equiv 9 \equiv 14 \equiv 19 \equiv \cdots \pmod{5}
\end{align*}
```

in $\mathbb{Z}/5\mathbb{Z} = \{0, 1, 2, 3, 4\}$, we have:

```{math}
\begin{align*}
\cdots -15 = -10 = -5 = {\color{red} 0} = 5 = 10 = 15 = \cdots \\
\cdots -14 = -9 = -4 = {\color{red} 1} = 6 = 11 = 16 = \cdots \\
\cdots -13 = -8 = -3 = {\color{red} 2} = 7 = 12 = 17 = \cdots \\
\cdots -12 = -7 = -2 = {\color{red} 3} = 8 = 13 = 18 = \cdots \\
\cdots -11 = -6 = -1 = {\color{red} 4} = 9 = 14 = 19 = \cdots
\end{align*}
```

So, one can say that $6 \in \mathbb{Z}/5\mathbb{Z}$, but in this new set, we have that $6 = 1$ (since $6 \equiv 1 \pmod{5}$).


In this set, by our previous theorem that allows us to replace elements by elements congruent to it in congruences, we can *add*, *subtract*, and *multiply* elements.  But, again, with congruences becoming equality.  For instance, still in $\mathbb{Z}/5\mathbb{Z}$, we have:

```{math}
\begin{align*}
3 + 4 &= 7 = \boxed{2}, \\
3 - 4 &= -1 = \boxed{4}, \\
3 \cdot 4 &= 12 = \boxed{2}.
\end{align*}
```

Although saying that $3 + 4 = 7$ is technically correct, we usually want to give the result in the range $\{0, 1, 2, 3, 4\}$ (when $m=5$), so it is better to say $3 + 4 = 2$.

This last observation makes clear the fact that the elements of $\mathbb{Z}/5\mathbb{Z}$ are *not integers*, as it is not true for integers that $3 + 4 = 2$.

:::{important}

If $m$ and $n$ are two different moduli, then $\mathbb{Z}/m\mathbb{Z}$ and $\mathbb{Z}/n\mathbb{Z}$ are *unrelated*, meaning that they live in different universes and do not relate to each other!
:::

To make this clear, one might think that since $\mathbb{Z}/3\mathbb{Z} = \{0, 1, 2\}$ and $\mathbb{Z}/4\mathbb{Z} = \{0, 1, 2, 3\}$, then $\mathbb{Z}/3\mathbb{Z}$ is contained in $\mathbb{Z}/4\mathbb{Z}$.  But *this is not the case*!  For instance, their $1$'s are not the same.  In $\mathbb{Z}/3\mathbb{Z}$ we have that $1 + 1 + 1 = 3 = 0$, while in $\mathbb{Z}/4\mathbb{Z}$ we have that $1 + 1 + 1 = 3 \neq 0$.

:::{note}

1) The title of this section is "The *Ring* of Integers Modulo $m$".  The world [ring](https://en.wikipedia.org/wiki/Ring_(mathematics)) comes from [Abstract Algebra](https://en.wikipedia.org/wiki/Abstract_algebra) and essentially says that we can add, subtract, and multiply elements of $\mathbb{Z}/m\mathbb{Z}$ with some of the expected properties for these operations.
2) Many texts use $\mathbb{Z}_m$ for $\mathbb{Z}/m\mathbb{Z}$, since it is quicker to write.  But is ambiguous, as $\mathbb{Z}_p$ (for $p$ prime) is often used for [$p$-adic numbers](https://en.wikipedia.org/wiki/P-adic_number).  The notation $\mathbb{Z}/m\mathbb{Z}$ is universally understood.
:::

:::{prf:definition} Notation
:label: def-fp
:numbered: true

If $p$ is a prime number, then we might write $\mathbb{F}_p$ for $\mathbb{Z}/p\mathbb{Z}$.  That is because when $p$ is prime (and only in that case), the ring $\mathbb{Z}/p\mathbb{Z}$ is a [field](https://en.wikipedia.org/wiki/Field_(mathematics)) with $p$ elements.
:::

+++

### $\mathbb{Z}/m\mathbb{Z}$ in Sage

+++

Fortunately, Sage allows us to create and use this set/ring $\mathbb{Z}/m\mathbb{Z}$, with either `Integers(m)`, `IntegerModRing(m)` or `Zmod(m)`.

```{code-cell} ipython3
Zmod?
```

So, let's create $\mathbb{Z}/5\mathbb{Z}$ and save it in `Z5`:

```{code-cell} ipython3
Z5 = Zmod(5)
Z5
```

So, to convert an integer `n` to an element of $\mathbb{Z}/5\mathbb{Z}$, we can do `Z5(n)`.  For example:

```{code-cell} ipython3
print(3 + 4)
print(3 - 4)
print(3 * 4)
print("-----")
print(Z5(3) + Z5(4))
print(Z5(3) - Z5(4))
print(Z5(3) * Z5(4))
```

We can use Sage's function `parent` to determine the data type of an element:

```{code-cell} ipython3
parent(1)
```

```{code-cell} ipython3
parent(Z5(1))
```

Note that when we convert an element to $\mathbb{Z}/5\mathbb{Z}$, Sage automatically reduces it modulo $5$ as well:

```{code-cell} ipython3
Z5(12)
```

Another way to create an element of $\mathbb{Z}/5\mathbb{Z}$ without creating the ring first is using `Mod`:

```{code-cell} ipython3
Mod(2, 5)
```

```{code-cell} ipython3
parent(Mod(2, 5))
```

```{code-cell} ipython3
Mod(3, 5) * Mod(4, 5)
```

As observed before, Sage knows that we cannot mix different moduli: if you try
```python
Mod(2, 3) + Mod(2, 4)
```
you get a *Type Error*:

```
TypeError: unsupported operand parent(s) for +: 'Ring of integers modulo 3' and 'Ring of integers modulo 4'
```

+++

It also knows that the elements, like their $1$'s, are different:

```{code-cell} ipython3
Mod(1, 3) == Mod(1, 4)
```

## Multiplication by $\mathbb{Z}$

+++

If $k$ is a positive integer and $a$ is an element of $\mathbb{Z}/m\mathbb{Z}$, we can write $k \cdot a$, by which we mean
```{math}
k \cdot a = \underbrace{a + a + \cdots a}_{\text{$k$ summands of $a$}}.
```
So, it is simply a shortcut.  (Note that the addition is the addition of $\mathbb{Z}/m\mathbb{Z}$.)

Now, we also define
```{math}
0 \cdot a = 0
```
for any $a$ in $\mathbb{Z}/mZ$.  **Note:** The $0$ on left is the one from $\mathbb{Z}$, which the one on the right is the one from $\mathbb{Z}/mZ$.

If $k$ is a positive integer, we further define
```{math}
(-k) \cdot a = \underbrace{(-a) + (-a) + \cdots + (-a)}_{\text{$k$ summands of $-a$}}.
```

+++

Sage can handle that:

```{code-cell} ipython3
3 * Mod(5, 7)
```

Indeed, if $3 \in \mathbb{Z}$ and $5 \in \mathbb{Z}/7\mathbb{Z}$, then:
```{math}
3 \cdot 5 = 5 + 5 + 5 = 15 = 1.
```

Also:

```{code-cell} ipython3
-3 * Mod(5, 7)
```

Indeed, if $-3 \in \mathbb{Z}$ and $5 \in \mathbb{Z}/7\mathbb{Z}$, then:
```{math}
(-3) \cdot 5 = (-5) + (-5) + (-5) = 2 + 2 + 2 = 6.
```

+++

**Note:** In the end, multiplying $a$ and $b$ when $a \in \mathbb{Z}$ and $b \in \mathbb{Z}/m\mathbb{Z}$ is the same as multiplying both elements as if they were in $\mathbb{Z}/mZ$.  So, we don't have to worry about it:

```{code-cell} ipython3
Mod(3, 7) * Mod(5, 7) == 3 * Mod(5, 7)
```

```{code-cell} ipython3
Mod(-3, 7) * Mod(5, 7) == -3 * Mod(5, 7)
```

## Exponents

+++

Similar to how we have shortcut to add an element of $\mathbb{Z}/m\mathbb{Z}$ to itself many times over (as in $k \cdot a$) we also have shortcut to multiplying: for any *positive* integer $k$, we let:
```{math}
a^k = \underbrace{a \cdot a \cdots a}_{\text{$k$ factors of $a$}}.
```
Note that this means that $a^1 = a$ (for any $a$) and we extend the definition with
```{math}
a^0 = 1 \qquad \text{for any $a \in \mathbb{Z}/m\mathbb{Z}$.}
```

:::{warning}

Unlike with multiplication, *we cannot replace the exponent $k$ with an integer modulo $m$*!
:::

For instance, in $\mathbb{Z}/4\mathbb{Z}$, we have that $4 =0$, but while
```{math}
2^ 0 = 1,
```
but
```{math}
2^4 = 2 \cdot 2 \cdot 2 \cdot 2 = 16 = 4 \cdot 4 = 0 \cdot 0 = 0,
```
and hence
```{math}
2^0 \neq 2^4.
```

The exponents do have familiar properties, though:

:::{prf:property} Properties of Exponents
:label: pr-exp
:numbered: true

Let $m$ be an integer greater than one, $a$ and $b$ be in $\mathbb{Z}/m\mathbb{Z}$ and $x$ and $y$ be *positive* integers.  Then:

1) $a^x \cdot a^y = a^{x + y}$,
2) $\left( a^x \right)^y = a^{x \cdot y}$,
3) $(a \cdot b)^x = a^x \cdot b^x$.
:::

+++

Of course, Sage can handle exponents as well:

```{code-cell} ipython3
Mod(2, 4)^4
```

```{code-cell} ipython3
Mod(32, 101)^84938493
```

:::{important}

In computations, you should *always* first convert an integer to $\mathbb{Z}/m\mathbb{Z}$ and then compute the power, *never the other way around*!
:::

We will see some reasons for the that below, but here is an illustration:

```{code-cell} ipython3
%%time
Mod(32, 101)^84938493
```

```{code-cell} ipython3
%%time
Mod(32^84938493, 101)
```

The former is about $250$ times faster!

Similarly, remember our computation that

```{math}
5647438438 \cdot 85948594584 - 7548376839 \equiv 3 \pmod{5}.
```

Like doing it by hand, is much better to first reduce modulo $5$ and then perform the operations:

```{code-cell} ipython3
a = 56474384387693274659724356924789347893479865923746592374659273452769469243
b = 8594859458489073409857134650891734560199032397013428957203875028435670248705
c = 754837683987509438750283475024930293023875023485702834570248549840524
m = 4389479349347575649873659287469247
```

```{code-cell} ipython3
%%time
Mod(a * b - c, m)
```

```{code-cell} ipython3
%%time
Mod(a, m) * Mod(b, m) - Mod(c, m)
```

## The Group of Units of $\mathbb{Z}/m\mathbb{Z}$

+++

As we've seen before, if $\gcd(a, m) = 1$, then there is some integer $b$ such that $ab \equiv 1 \pmod{m}$, and this is $b$ is unique *modulo $m$*, meaning that if $ab' \equiv 1 \pmod{m}$ as well, then $b \equiv b' \pmod{m}$.

We can now translate this to $\mathbb{Z}/m\mathbb{Z}$: if $a \in \mathbb{Z}/m\mathbb{Z}$ and $\gcd(a, m)=1$, then there is a *unique* $b$ in $\mathbb{Z}/m\mathbb{Z}$ such that $ab=1$.  (In this case, $ab=ab'=1$ means that $b=b'$.)  In this case, we say that $a$ is *invertible* in $\mathbb{Z}/m\mathbb{Z}$ or a *unit* of $\mathbb{Z}/m\mathbb{Z}$, and $b$ is its inverse.  We denote this inverse of $a$ by $a^{-1}$.

Moreover, if $\gcd(a, m) \neq 1$, then there is no $b \in \mathbb{Z}/m\mathbb{Z}$ such that $ab = 1$.  (In this case, $a$ is *not* a unit.)

We denote the set of all units (or all invertible elements) of $\mathbb{Z}/m\mathbb{Z}$ by $(\mathbb{Z}/m\mathbb{Z})^{\times}$.  So,
```{math}
(\mathbb{Z}/m\mathbb{Z})^{\times} = \{ a \in \mathbb{Z}/m\mathbb{Z} \; : \; \gcd(a, m) = 1 \}.
```

(We read the "$:$" as "such that".  The left part is read as "the set of all elements $a$ in $\mathbb{Z}/m\mathbb{Z}$ such that $\gcd(a, m)=1$".)

:::{note}

The title of this section is "The Group of Units of $\mathbb{Z}/m\mathbb{Z}$" and, again, the term [group](https://en.wikipedia.org/wiki/Group_(mathematics)) comes from Abstract Algebra.  We might talk more about groups later!
:::

+++

:::{prf:property} Properties of Unities
:label: pr-unity
:numbered: true

Here are some basic properties of $(\mathbb{Z}/m\mathbb{Z})^{\times}$ (that in fact show it is a group) of the product:

1) $1 \in (\mathbb{Z}/m\mathbb{Z})^{\times}$;
2) if $a, b \in (\mathbb{Z}/m\mathbb{Z})^{\times}$, then $a \cdot b \in (\mathbb{Z}/m\mathbb{Z})^{\times}$;
3) if $a \in (\mathbb{Z}/m\mathbb{Z})^{\times}$, then $a^{-1}$ exists and is in $(\mathbb{Z}/m\mathbb{Z})^{\times}$ as well;
4) if $a, b, c \in (\mathbb{Z}/m\mathbb{Z})^{\times}$, then $a \cdot (b \cdot c) = (a \cdot b) \cdot c$.
:::

+++

As you'd expect, Sage can find inverses if they exist:

```{code-cell} ipython3
Mod(32, 101)^(-1)
```

And indeed:

```{code-cell} ipython3
Mod(60, 101) * Mod(32, 101)
```

We also have the Sage function `inverse_mod`:

```{code-cell} ipython3
inverse_mod(32, 101)
```

But note that unlike the previous example, which gives us an element of $\mathbb{Z}/101\mathbb{Z}$, the latter gives us an *integer*!

```{code-cell} ipython3
parent(Mod(32, 101)^(-1))
```

```{code-cell} ipython3
parent(inverse_mod(32, 101))
```

If you try to invert an element with no inverse, it gives an error.  For instance, if you try

```python
Mod(2, 6)^(-1)
```

it gives

```
ZeroDivisionError: inverse of Mod(2, 6) does not exist
```

+++

Of course, we can check if an element is a unit with the GCD, but we also have the `.is_unit` method:

```{code-cell} ipython3
a = Mod(2, 6)
a.is_unit()
```

Sage can also give us the whole set of units.  Remembering the `Z5` is `Zmod(5)` meaning $\mathbb{Z}/5\mathbb{Z}$ we have:

```{code-cell} ipython3
Z5.unit_group()
```

That is strange...  Let's look at the elements:

```{code-cell} ipython3
set(Z5.unit_group())
```

What is `f`?

This is a related to some algebraic properties of the group of units, but we can "translate" is back to $\mathbb{Z}/5\mathbb{Z}$:

```{code-cell} ipython3
{Z5(x) for x in Z5.unit_group()}
```

```{code-cell} ipython3
Z24 = Zmod(24)
{Z24(x) for x in Z24.unit_group()}
```
