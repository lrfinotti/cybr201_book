---
jupytext:
  formats: ipynb,sage:percent,md:myst
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



# Modular Arithmetic

+++

## Congruences

+++

*Congruences* are very important in Number Theory in general, and will play a big role in many of our applications in cryptography.  XXX

:::{prf:definition}
Let $a$, $b$, and $m$ be integers, with $m > 1$.  We say that $a$ is *congruent* to $b$ *modulo* $m$ if $m \mid (a - b)$.  We can denote it by:
$$
a \equiv b \pmod{m}.
$$
In this case, $m$ is called the *modulus*.
:::

So, it is very easy to check for congruences!  It is just a question about divisibility.


**Examples:**
1) Is $43$ congruent $11$ modulo $8$?  We just check if $8$ divides $43-11 = 32$.  Since it does, the answer is *yes*:$$43 \equiv 11 \pmod{8}.$$
2) Is $-21$ congruent to $50$ modulo $11$?  We just check if $11$ divides $-21 - 50 = -71$.  Since it doesn't, the answer is *no*: $$-21 \not\equiv 50 \pmod{11}.$$
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

\begin{align*}
\cdots -15 \equiv -10 \equiv -5 \equiv {\color{red} 0} \equiv 5 \equiv 10 \equiv 15 \equiv \cdots \pmod{5}\\
\cdots -14 \equiv -9 \equiv -4 \equiv {\color{red} 1} \equiv 6 \equiv 11 \equiv 16 \equiv \cdots \pmod{5}\\
\cdots -13 \equiv -8 \equiv -3 \equiv {\color{red} 2} \equiv 7 \equiv 12 \equiv 17 \equiv \cdots \pmod{5}\\
\cdots -12 \equiv -7 \equiv -2 \equiv {\color{red} 3} \equiv 8 \equiv 13 \equiv 18 \equiv \cdots \pmod{5}\\
\cdots -11 \equiv -6 \equiv -1 \equiv {\color{red} 4} \equiv 9 \equiv 14 \equiv 19 \equiv \cdots \pmod{5}
\end{align*}

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
$$
a_1 \equiv a_2 \pmod{m} \quad \text{and} \quad b_1 \equiv b_2 \pmod{m}.
$$
Then
\begin{align*}
a_1 + b_1 &\equiv a_2 + b_2 &&\pmod{m}, \\
a_1 - b_1 &\equiv a_2 - b_2 &&\pmod{m}, \\
a_1 \cdot b_1 &\equiv a_2 \cdot b_2 &&\pmod{m}, \\
a_1^k &\equiv a_2^k &&\pmod{m} \quad \text{for any positive integer $k$.}
\end{align*}
:::


So, "$\equiv$" is *similar* to "$=$" in computations.  In congruences with sums, differences, and products, we can replace a number by another that is congurent to it.  Let's see it in action in an example:

+++

:::{prf:example}
What is the remainder of
$$
5647438438 \cdot 85948594584 - 7548376839
$$
when divided by $5$?
:::

We could compute this huge number, then do the long division to find the remainder.  But note that asking for the remainder modulo $5$ is the same to ask for a number between $0$ and $4$ congruent to the number:

$$
5647438438 \cdot 85948594584 - 7548376839 \equiv \, ??? \pmod{5}.
$$

The idea now is that the theorem above allows us to replace each of the three large numbers by smaller numbers congruent to them modulo $5$, making the computation much simpler!  As we've seen above, we can replace them by their residues modulo $5$ (i.e., their remainders when divided by $5$), so numbers between $0$ and $4$.

Of course, we could just ask Sage for their residues, but we can in fact compute residues modulo $5$ quite easily using the Theorem and the fact that $10 \equiv 0 \pmod{5}$.  For example, let's find the residue of the first number modulo $5$:

\begin{align*}
5647438438 &= 5647438430 + 8 \\
&= 564743843 \cdot {\color{red} 10}  + 8 \\
&\equiv 564743843 \cdot {\color{red} 0} + 8 && \text{(since $10 \equiv 0 \pmod{5}$)} \\
&= 8 \\
&= {\color{red} 5} + 3 \\
&\equiv {\color{red} 0} + 3 && \text{(since $5 \equiv 0 \pmod{5}$)} \\
&= 3 \pmod{5}
\end{align*}

The same idea shows that a *positive* number is always congruent to its *last digit* modulo $5$!  So, we have:
\begin{align*}
8594859458{\color{blue} 4} &\equiv {\color{blue} 4} \pmod{5},\\
754837683{\color{blue} 9} & \equiv {\color{blue} 9} = {\color{red} 5} + 4 \equiv {\color{red} 0} + 4 = 4 \pmod{5}.
\end{align*}

So, we have:
\begin{align*}
{\color{red} 5647438438} &\equiv {\color{red} 3} \pmod{5}, \\
{\color{blue} 85948594584} &\equiv {\color{blue} 4} \pmod{5},\\
{\color{green} 7548376839} & \equiv {\color{green} 4} \pmod{5}.
\end{align*}

Now, using the theorem, we can do:

\begin{align*}
{\color{red} 5647438438}  \cdot {\color{blue} 85948594584} - {\color{green} 7548376839}
&\equiv {\color{red} 3} \cdot {\color{blue} 4} - {\color{green} 4} \\
&\equiv 8 = {\color{orange} 5} + 3 \\
&\equiv {\color{orange} 0} + 3 = \boxed{3}  \pmod{5}
\end{align*}

So, the remainder is $3$!

+++

*Example:* What is the remainder of $13^{1{,}000{,}000{,}000}$ when divided by $7$?

We can again think in terms of congruences and we are asking for a number between $0$ and $6$ congruent to $13^{1{,}000{,}000{,}000}$ modulo $7$. And again, by the Theorem, we can replace $13$ by its residue modulo $7$ in a congruence, and clearly $13 = 7 \cdot 1 + 6$, so we have
$$
13^{1{,}000{,}000{,}000} \equiv 6^{1{,}000{,}000{,}000} \pmod{7}.
$$
The problem is that, although much better, the number of the right is still *humongous*, too large even for computers!

```{warning}
We *cannot* replace the *exponent* by its residue modulo $7$!  It is not part of the theorem and it does not work in general.  We will later see how we can reduce the exponent as well, *but with a different modulus*!
```

So, for now, we can use a different trick.  Note that $6 \equiv -1 \pmod{7}$, and so we have:

\begin{align*}
13^{1{,}000{,}000{,}000}
&\equiv 6^{1{,}000{,}000{,}000} \\
&\equiv (-1)^{1{,}000{,}000{,}000} \\
&= \boxed{1} \pmod{7}.
\end{align*}

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
$$
ax \equiv 1 \pmod{m}
$$
has a solution (with $x$ *integer) if, and only if, $\gcd(a, m) = 1$.
:::

This is not hard to see.

First, suppose that $\gcd(a, m) = 1$.  (We want to show that $a$ has an inverse modulo $m$.)  By Bezout's Lemma, we have that there are integers $u$ and $v$ such that
$$
1 = au + mv.
$$
But then, since $m \equiv 0 \pmod{m}$, we have that
$$
1 \equiv au + mv  \equiv au + 0 = au \pmod{m}.
$$
So, the $u$ found by the Extended Euclidean Algorithm is the inverse of $a$!

+++

Now, assume that $a$ has an inverse $b$ modulo $m$.  (We want to show that $\gcd(a, m)=1$.)  This means that
$$
ab \equiv 1 \pmod{m},
$$
which means that there is some integer $k$ such that
$$
ab = 1 + km, \qquad \text{or} \qquad ab - mk = 1.
$$
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
$$
1 = 35 \cdot 15 + 131 (-4)
$$
(careful with the order of the output!), so $15$ is the inverse.  Indeed:

```{code-cell} ipython3
(35 * 15) % 131
```

## The Ring of Integers Modulo $m$

+++

Given an integer $m > 1$, we can create a new set:
$$
\Z / m\Z = \{0, 1, 2, \ldots, (m-1)\}
$$
where *congruences become equalities*!

:::{warning}

***These elements are not integers any more!***  They have different properties!  We will discuss that in more detail below, but it is very important to observe that from the start.
:::

To differentiate these elements from the actual integers, often times authors use an over bar for the elements of this set, as in
$$
\Z / m\Z = \{\bar{0}, \bar{1}, \bar{2}, \ldots, \overline{m-1}\}
$$
But, we will not use the bars here.  We just have to be aware of the context.

So, while in $\Z$ we had

\begin{align*}
\cdots -15 \equiv -10 \equiv -5 \equiv {\color{red} 0} \equiv 5 \equiv 10 \equiv 15 \equiv \cdots \pmod{5}\\
\cdots -14 \equiv -9 \equiv -4 \equiv {\color{red} 1} \equiv 6 \equiv 11 \equiv 16 \equiv \cdots \pmod{5}\\
\cdots -13 \equiv -8 \equiv -3 \equiv {\color{red} 2} \equiv 7 \equiv 12 \equiv 17 \equiv \cdots \pmod{5}\\
\cdots -12 \equiv -7 \equiv -2 \equiv {\color{red} 3} \equiv 8 \equiv 13 \equiv 18 \equiv \cdots \pmod{5}\\
\cdots -11 \equiv -6 \equiv -1 \equiv {\color{red} 4} \equiv 9 \equiv 14 \equiv 19 \equiv \cdots \pmod{5}
\end{align*}

in $\Z/5\Z = \{0, 1, 2, 3, 4\}$, we have:

\begin{align*}
\cdots -15 = -10 = -5 = {\color{red} 0} = 5 = 10 = 15 = \cdots \\
\cdots -14 = -9 = -4 = {\color{red} 1} = 6 = 11 = 16 = \cdots \\
\cdots -13 = -8 = -3 = {\color{red} 2} = 7 = 12 = 17 = \cdots \\
\cdots -12 = -7 = -2 = {\color{red} 3} = 8 = 13 = 18 = \cdots \\
\cdots -11 = -6 = -1 = {\color{red} 4} = 9 = 14 = 19 = \cdots
\end{align*}

So, one can say that $6 \in \Z/5\Z$, but in this new set, we have that $6 = 1$ (since $6 \equiv 1 \pmod{5}$).


In this set, by our previous theorem that allows us to replace elements by elements congruent to it in congruences, we can *add*, *subtract*, and *multiply* elements.  But, again, with congruences becoming equality.  For instance, still in $\Z/5\Z$, we have:

\begin{align*}
3 + 4 &= 7 = \boxed{2}, \\
3 - 4 &= -1 = \boxed{4}, \\
3 \cdot 4 &= 12 = \boxed{2}.
\end{align*}

Although saying that $3 + 4 = 7$ is technically correct, we usually want to give the result in the range $\{0, 1, 2, 3, 4\}$ (when $m=5$), so it is better to say $3 + 4 = 2$.

This last observation makes clear the fact that the elements of $\Z/5\Z$ are *not integers*, as it is not true for integers that $3 + 4 = 2$.

:::{important}

If $m$ and $n$ are two different moduli, then $\Z/m\Z$ and $\Z/n\Z$ are *unrelated*, meaning that they live in different universes and do not relate to each other!
:::

To make this clear, one might think that since $\Z/3\Z = \{0, 1, 2\}$ and $\Z/4\Z = \{0, 1, 2, 3\}$, then $\Z/3\Z$ is contained in $\Z/4\Z$.  But *this is not the case*!  For instance, their $1$'s are not the same.  In $\Z/3\Z$ we have that $1 + 1 + 1 = 3 = 0$, while in $\Z/4\Z$ we have that $1 + 1 + 1 = 3 \neq 0$.

:::{note}

1) The title of this section is "The *Ring* of Integers Modulo $m$".  The world [ring](https://en.wikipedia.org/wiki/Ring_(mathematics)) comes from [Abstract Algebra](https://en.wikipedia.org/wiki/Abstract_algebra) and essentially says that we can add, subtract, and multiply elements of $\Z/m\Z$ with some of the expected properties for these operations.
2) Many texts use $\Z_m$ for $\Z/m\Z$, since it is quicker to write.  But is ambiguous, as $\Z_p$ (for $p$ prime) is often used for [$p$-adic numbers](https://en.wikipedia.org/wiki/P-adic_number).  The notation $\Z/m\Z$ is universally understood.
:::

:::{prf:definition} Notation
:label: def-fp
:numbered: true

If $p$ is a prime number, then we might write $\mathbb{F}_p$ for $\Z/p\Z$.  That is because when $p$ is prime (and only in that case), the ring $\Z/p\Z$ is a [field](https://en.wikipedia.org/wiki/Field_(mathematics)) with $p$ elements.
:::

+++

### $\Z/m\Z$ in Sage

+++

Fortunately, Sage allows us to create and use this set/ring $\Z/m\Z$, with either `Integers(m)`, `IntegerModRing(m)` or `Zmod(m)`.

```{code-cell} ipython3
Zmod?
```

So, let's create $\Z/5\Z$ and save it in `Z5`:

```{code-cell} ipython3
Z5 = Zmod(5)
Z5
```

So, to convert an integer `n` to an element of $\Z/5\Z$, we can do `Z5(n)`.  For example:

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

Note that when we convert an element to $\Z/5\Z$, Sage automatically reduces it modulo $5$ as well:

```{code-cell} ipython3
Z5(12)
```

Another way to create an element of $\Z/5\Z$ without creating the ring first is using `Mod`:

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

## Multiplication by $\Z$

+++

If $k$ is a positive integer and $a$ is an element of $\Z/m\Z$, we can write $k \cdot a$, by which we mean
$$
k \cdot a = \underbrace{a + a + \cdots a}_{\text{$k$ summands of $a$}}.
$$
So, it is simply a shortcut.  (Note that the addition is the addition of $\Z/m\Z$.)

Now, we also define
$$
0 \cdot a = 0
$$
for any $a$ in $\Z/mZ$.  **Note:** The $0$ on left is the one from $\Z$, which the one on the right is the one from $\Z/mZ$.

If $k$ is a positive integer, we further define
$$
(-k) \cdot a = \underbrace{(-a) + (-a) + \cdots + (-a)}_{\text{$k$ summands of $-a$}}.
$$

+++

Sage can handle that:

```{code-cell} ipython3
3 * Mod(5, 7)
```

Indeed, if $3 \in \Z$ and $5 \in \Z/7\Z$, then:
$$
3 \cdot 5 = 5 + 5 + 5 = 15 = 1.
$$

Also:

```{code-cell} ipython3
-3 * Mod(5, 7)
```

Indeed, if $-3 \in \Z$ and $5 \in \Z/7\Z$, then:
$$
(-3) \cdot 5 = (-5) + (-5) + (-5) = 2 + 2 + 2 = 6.
$$

+++

**Note:** In the end, multiplying $a$ and $b$ when $a \in \Z$ and $b \in \Z/m\Z$ is the same as multiplying both elements as if they were in $\Z/mZ$.  So, we don't have to worry about it:

```{code-cell} ipython3
Mod(3, 7) * Mod(5, 7) == 3 * Mod(5, 7)
```

```{code-cell} ipython3
Mod(-3, 7) * Mod(5, 7) == -3 * Mod(5, 7)
```

## Exponents

+++

Similar to how we have shortcut to add an element of $\Z/m\Z$ to itself many times over (as in $k \cdot a$) we also have shortcut to multiplying: for any *positive* integer $k$, we let:
$$
a^k = \underbrace{a \cdot a \cdots a}_{\text{$k$ factors of $a$}}.
$$
Note that this means that $a^1 = a$ (for any $a$) and we extend the definition with
$$
a^0 = 1 \qquad \text{for any $a \in \Z/m\Z$.}
$$

:::{warning}

Unlike with multiplication, *we cannot replace the exponent $k$ with an integer modulo $m$*!
:::

For instance, in $\Z/4\Z$, we have that $4 =0$, but while
$$
2^ 0 = 1,
$$
but
$$
2^4 = 2 \cdot 2 \cdot 2 \cdot 2 = 16 = 4 \cdot 4 = 0 \cdot 0 = 0,
$$
and hence
$$
2^0 \neq 2^4.
$$

The exponents do have familiar properties, though:

:::{prf:property} Properties of Exponents
:label: pr-exp
:numbered: true

Let $m$ be an integer greater than one, $a$ and $b$ be in $\Z/m\Z$ and $x$ and $y$ be *positive* integers.  Then:

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

In computations, you should *always* first convert an integer to $\Z/m\Z$ and then compute the power, *never the other way around*!
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

$$
5647438438 \cdot 85948594584 - 7548376839 \equiv 3 \pmod{5}.
$$

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

## The Group of Units of $\Z/m\Z$

+++

As we've seen before, if $\gcd(a, m) = 1$, then there is some integer $b$ such that $ab \equiv 1 \pmod{m}$, and this is $b$ is unique *modulo $m$*, meaning that if $ab' \equiv 1 \pmod{m}$ as well, then $b \equiv b' \pmod{m}$.

We can now translate this to $\Z/m\Z$: if $a \in \Z/m\Z$ and $\gcd(a, m)=1$, then there is a *unique* $b$ in $\Z/m\Z$ such that $ab=1$.  (In this case, $ab=ab'=1$ means that $b=b'$.)  In this case, we say that $a$ is *invertible* in $\Z/m\Z$ or a *unit* of $\Z/m\Z$, and $b$ is its inverse.  We denote this inverse of $a$ by $a^{-1}$.

Moreover, if $\gcd(a, m) \neq 1$, then there is no $b \in \Z/m\Z$ such that $ab = 1$.  (In this case, $a$ is *not* a unit.)

We denote the set of all units (or all invertible elements) of $\Z/m\Z$ by $(\Z/m\Z)^{\times}$.  So,
$$
(\Z/m\Z)^{\times} = \{ a \in \Z/m\Z \; : \; \gcd(a, m) = 1 \}.
$$

(We read the "$:$" as "such that".  The left part is read as "the set of all elements $a$ in $\Z/m\Z$ such that $\gcd(a, m)=1$".)

:::{note}

The title of this section is "The Group of Units of $\Z/m\Z$" and, again, the term [group](https://en.wikipedia.org/wiki/Group_(mathematics)) comes from Abstract Algebra.  We might talk more about groups later!
:::

+++

:::{prf:property} Properties of Unities
:label: pr-unity
:numbered: true

Here are some basic properties of $(\Z/m\Z)^{\times}$ (that in fact show it is a group) of the product:

1) $1 \in (\Z/m\Z)^{\times}$;
2) if $a, b \in (\Z/m\Z)^{\times}$, then $a \cdot b \in (\Z/m\Z)^{\times}$;
3) if $a \in (\Z/m\Z)^{\times}$, then $a^{-1}$ exists and is in $(\Z/m\Z)^{\times}$ as well;
4) if $a, b, c \in (\Z/m\Z)^{\times}$, then $a \cdot (b \cdot c) = (a \cdot b) \cdot c$.
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

But note that unlike the previous example, which gives us an element of $\Z/101\Z$, the latter gives us an *integer*!

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

Sage can also give us the whole set of units.  Remembering the `Z5` is `Zmod(5)` meaning $\Z/5\Z$ we have:

```{code-cell} ipython3
Z5.unit_group()
```

That is strange...  Let's look at the elements:

```{code-cell} ipython3
set(Z5.unit_group())
```

What is `f`?

This is a related to some algebraic properties of the group of units, but we can "translate" is back to $\Z/5\Z$:

```{code-cell} ipython3
{Z5(x) for x in Z5.unit_group()}
```

```{code-cell} ipython3
Z24 = Zmod(24)
{Z24(x) for x in Z24.unit_group()}
```

### Negative Powers

+++

Now, if $a$ is a *unit* of $\Z/m\Z$, we can define negative powers! If $k$ is a positive integer, then we define
$$
a^0 = 1 \qquad \text{and} \qquad a^{-k} = \underbrace{a^{-1} \cdot a^{-1} \cdots a^{-1}}_{\text{$k$ factors of $a^{-1}$}}.
$$

Moreover, the properties of powers we had before for positive exponents also work for if allow zero or negative exponents

+++

## The Euler $\varphi$-Function

+++

:::{prf:definition} The Euler $\varphi$-Function
:label: def-euler_phi
:numbered: true

 Given a positive integer $m$, we defined the $\varphi(m)$ as the number of elements of $(\Z/m\Z)^{\times}$, in other words
$$
\varphi(m) = \text{number of integers $a$ between $0$ and $m$ with $\gcd(a, m)=1$.}
$$
We also define $\varphi(1)$ as $1$.  This function is called the *Euler $\varphi$ function*.
:::

:::{prf:example}
:numbered: false

1) Since $(\Z/5\Z)^{\times} = \{1, 2, 3, 4\}$, then $\varphi(5) = 4$.
2) Since $(\Z/24\Z)^{\times} = \{1, 5, 7, 11, 13, 17, 19, 23\}$, then $\varphi(24) = 8$.
:::

As we will later see, this function will be important for the RSA Cryptosystem.

One might ask if there is another way to compute $\varphi(m)$, besides just checking for integers relatively prime to $m$, which can be slow if $m$ is large.

We have:

:::{prf:theorem}
:label: th-phi_comp
:numbered: true

Let $m$ be a positive integer greater than one and
$$
m = p_1^{e_1} \cdot p_2^{e_2} \cdots p_k^{e_k}
$$
be its prime decomposition.  Then
$$
\varphi(m) = [(p_1 - 1) \cdot p^{e_1 -1}] \cdot [(p_2 - 1) \cdot p_2^{e_2 - 1}] \cdots [(p_k - 1) \cdot p_k^{e_k - 1}].
$$
:::


:::{prf:example}
:numbered: false

1) Since $5$ is prime, then $\varphi(5) = (5 - 1) \cdot 5^{1-1}  = 4$.
2) More generally, for any prime $p$ we have that $\varphi(p) = p-1$.
3) Since $24 = 2^3 \cdot 3$, we have $\varphi(24) = [(2-1) \cdot 2^{3-1}] \cdot [(3-1) \cdot 3^{1-1} = 4 \cdot 2 = 8$.
:::

Let's check that this formula works using Sage's `euler_phi` implementation of $\varphi$.  First, let's create a function that uses the prime factorization for the computation:

```{code-cell} ipython3
def euler_phi_from_fact(m):
    """
    Given a positive integer m, returns the Euler phi-function of n by
    using the prime factorization of m.

    INPUT:
    m: positive integer.

    OUTPUT:
    The Euler phi-function at m (a positive integer).
    """
    return prod((p - 1) * p^(e - 1) for p, e in factor(m))
```

Now, let's test it:

```{code-cell} ipython3
number_tries = 100
max_number = 10^5

for _ in range(number_tries):
    m = randint(2, max_number + 1)
    if euler_phi(m) != euler_phi_from_fact(m):
        print(f"Failed for {m = }.")
        breal
else:
    print("It seems to work!")
```

The problem with is this method, as we shall see, is that the prime factorization can be slow for very large $m$ with only very large prime factors!

+++

## Powers in $\Z/m\Z$

+++

Remember that we cannot reduce powers in computations in $\Z/m\Z$.  As we've seen, in $\Z/4\Z$ we have that $4 = 0$, but
$$
2^0 = 1 \neq 0 = 2^4.
$$
That is, again, because the exponent must be in $\Z$, and not in $\Z/4\Z$.  But there is something we can do:

:::{prf:proposition}
:label: pr-power_eq_1
:numbered: true

Let $a$ in $\Z/m/Z$ and suppose that $k$ is a *positive* integer such that $a^k = 1$.  Then, if $r \equiv s \pmod{k}$ (so, modulo $k$, *and not $n$*!), then $a^r = a^s$.  Therefore, we can reduce exponents modulo $k$ (and not $m$).
:::

Let's see some examples: we have that in $\Z/7\Z$ that $3^6 = 1$.

```{code-cell} ipython3
Mod(3, 7)^6
```

Then, it should be the case that for any exponent $r$, in $\Z/7\Z$ we should have that $2^r$ is the same as $2^s$ where $s$ is the residue of $r$ module $6$ (and not 7!).  Let's test it:

```{code-cell} ipython3
number_tries = 1000
max_exp = 3000

for _ in range(number_tries):
    r = randint(7, max_exp)
    s = r % 6  # residue module 6
    if Mod(3, 7)^r != Mod(3, 7)^s:
        print(f"Failed for {r = } and {s = }.")
        break
else:
    print("It seems to work!")
```

But, it is not hard to see, in general why this is true.  Suppose $a^k = 1$ in $\Z/m\Z$ and and $r \equiv s \pmod{k}$.  This means that $s = r + nk$ for some integer $n$.  Then, using properties of exponents:
$$
a^s = a^{r + nk} = a^r \cdot a^{nk} = a^r \cdot (a^k)^s = a^r \cdot 1^s = a^r.
$$

+++

Of course, this is all based on the fact that $a^k = 1$ for some $k$, but this is not always going to be true.  If $a^k = 1$, then $a \cdot a^{k-1} = a^k = 1$, and so $a$ must be a *unit*!

But, assuming that $a$ *is* a unit, how would we find such $k$.  The answer is given below:

:::{prf:theorem} Euler's Theorem
:label: th-euler
:numbered: true

Let $a$ be a unit in $\Z/m\Z$ (i.e., $\gcd(a, m) = 1$).  Then $a^{\varphi(m)} = 1$ in $\Z/m\Z$ (i.e., $a^{\varphi(m)} \equiv 1 \pmod{m}$).  (Here $\varphi$ is the Euler $\varphi$ function.)
:::

Again, let's check this with Sage:

```{code-cell} ipython3
number_tries = 1000
max_m = 3000

for _ in range(number_tries):
    m = randint(2, max_m)
    while True:
        a = randint(2, m  - 1)
        if gcd(a, m) == 1:
            break
    if Mod(a, m)^euler_phi(m) != Mod(1, m):
        print(f"Failed for {m = } and {a = }.")
        break
else:
    print("It seems to work!")
```

The particular case when $m$ is a *prime* has a different name:

:::{prf:theorem} Fermat's Little Theorem
:label: th-flt
:numbered: true

If $p$ is prime and $p \not \mid a$, then $a^{p-1} = 1$ in $\Z/p\Z$ (i.e., $a^{p-1} \equiv 1 \pmod{p}$).
:::

This follows from Euler's Theorem since, when $p$ is prime, we have that  $\varphi(p) = p-1$  and $\gcd(a, p) = 1$ if, and only if, $p \not\mid a$.

Let's apply these ideas in an example.

:::{prf:example} title
:numbered: false

What is the remainder of $100324^{657483384}$ when divided by $15$?
:::

First we reduce $100324$ modulo $15$:

```{code-cell} ipython3
100324 % 15
```

So, $100324^{657483384} \equiv 4^{657483384} \pmod{15}$.  Now, observe that $\gcd(4, 15) = 1$ since the only divisors of $4$ are $1$, $2$, and $4$ and, among these, only $1$ divides $15$.  So, combining Euler's Theorem

+++

## Order of Units

+++

Note that although raising a unit of $\Z/m\Z$ to the exponent $\varphi(m)$ *always* yields $1$ (by Euler's Theorem), it might not be the *smallest* positive power that gives $1$.  For instance, in $\Z/7\Z$, we have $\varphi(7) = 6$ and although $6^6 = 1$, we also have that $6^2 = 36 = 1 + 5 \cdot 7 = 1$.

We have the following definition:

:::{prf:definition} Order of an Element
:label: def-ord
:numbered: true

If $a$ is a unit of $\Z/m\Z$, then the *order of $a$*, usually denoted by $|a|$, is the smallest positive power $k$ such that $a^k = 1$.
:::

(So, by Euler's Theorem, in $\Z/m\Z$, for any unit $a$, we have that $|a| \leq \varphi(m)$.)

We have:

:::{prf:proposition}
:label: pr-power_one
:numbered: true

Let $a$ be a unit of $\Z/m\Z$. If $a^k = 1$, for some integer $k$, then $|a| \mid k$.  In particular, we always have that $|a| \mid \varphi(m)$.
:::

This is not too hard to see: suppose that $a^k$ and let's denote $n = |a|$.  We can perform the long division of $k$ by $n$: $k = qn + r$, for integers $q$ and $r$, with $r \in \{0, 1, 2, \ldots, (n-1)\}$.  Then,
$$
1 = a^k = a^{nq + r} = a^{nq} \cdot a^r = (a^n)^q \cdot a^r = 1^q \cdot a^r = a^r.
$$
Therefore $r$ is a power smaller than $n=|a|$ that gives $1$.  But since, by definition of order $n$ is the smallest *positive* power that gives $1$, we must have that $r=0$ (remember $0$ is neither positive, nor negative!), i.e., $n \mid k$.

+++

Combining [](#pr-power_eq_1) and [](#def-ord) we get:

:::{prf:proposition}
:label: pr-exponents
:numbered: true

If $a \in \Z/m\Z$ and $k = |a|$, then we can consider exponents of $a$ as elements of $\Z/k\Z$.
:::

This is should be clear, since $a^k=1$ and exponents congruent to $k$ give the same result.

+++

In your homework you will write a function that takes a unit of $\Z/m\Z$ and computes its order.  One could do it by sheer "brute force", meaning testing if $a^1=1$, if not test if $a^2=1$, if not test if $a^3=1$, etc., until we find the first power that does result in $1$.  (This power is the order.)

For instance, let's find the order of $3$ in $\Z/11\Z$:

```{code-cell} ipython3
Mod(3, 11)^2
```

Not, one, so we continues:

```{code-cell} ipython3
Mod(3, 11)^4
```

No...

```{code-cell} ipython3
Mod(3, 11)^5
```

Ah, so in $\Z/11\Z$ we have that $|3|=5$.

+++

An alternative would be to only test divisors of $\varphi(m)$, using Sage's `divisors` function.  This would work better for most numbers, but $\varphi(m)$ can be hard to compute.  In those cases, the "brute force" method would be better.

In our particular case above in $\Z/11\Z$, we would only to test divisors of $\varphi(11) = 10$, so $\{1, 2, 5, 10\}$.

+++

Of course, Sage can do it native way to compute it using `.multiplicative_order()`:

```{code-cell} ipython3
Mod(3, 11).multiplicative_order()
```

:::{caution}

Sage also has `.order()`, but *it is not what we want*!  (It is an additive order, that does not concern us here.)
:::

For example:

```{code-cell} ipython3
Mod(3, 11).order()
```

### Computing Successive Powers

+++

In many concrete examples, like the "brute force" computation of the order of a unit above, one needs to compute successive powers of an element.  In these cases, if one cares about performance (like *we do here*!), one should not use powers, but single products.  As an example, suppose we need to compute
$$
3^0, 3^1, 3^2, \ldots, 3^{100{,}000}.
$$
Here, as an example, we will not use the powers for anything, but just compute them.  Here is one way:

```{code-cell} ipython3
%%time
max_power = 10**5
base = 3

for i in range(max_power + 1):
    x = base ** i
```

In each iteration, we compute `base ** i`, which involves several multiplications (if `i` is large).

We can do much better!

```{code-cell} ipython3
%%time
max_power = 10**5
base = 3

x = 1
for i in range(max_power):
    x *= base
```

Here, in each iteration, we perform a *single* product: `x * base`!

:::{important}

Please remember this in your homework (and future code!), as it makes a considerable difference in performance!
:::

+++

:::{note} Side Note

If you change the `base` in the code above to $2$, you will see that the former code becomes slightly faster than the second (in Sage).  That's because Sage is smart enough to see this as an operation of binary numbers, which is faster.  In pure *Python*, that is not the case and the former is still a lot faster.
:::

+++

## Primitive Roots

+++

Remember the group of units of $\Z/m\Z$:
$$
(\Z/m\Z)^{\times} = \{a \in \Z/m\Z \; : \; \gcd(a, m) = 1\}.
$$
When the modulus is prime, this set has an interesting (and useful) property:

:::{prf:theorem} Primitive Root Theorem
:label: th-prim_root
:numbered: true

Let $p$ be a prime.  (Remember then that $\mathbb{F}_p$ is just another way to write $\Z/p\Z$.)  Then, there is an element $g \in \mathbb{F}_p^{\times}$ such that every element of $\mathbb{F}_p^{\times}$ is a power of $g$.  In other words:
$$
\mathbb{F}_p^{\times} = \{1, g, g^2, g^3, \ldots, g^{p-2}\}.
$$
:::

:::{prf:definition} Primitive Root
:label: def-prim
:numbered: true

A $g$ as above is called a *primitive root* of $\mathbb{F}_p$ or a *generator* of $\mathbb{F}_p^{\times}$.
:::

:::{note}

We have that $g$ is a primitive root of $\mathbb{F}_p^{\times}$ if, and only if, $|g| = (p-1)$, the total number of elements of $\mathbb{F}_p^{\times}$.  So, to find a primitive root, we just look for elements of order $p-1$.
:::

Here are some observations.  First, this element is not, necessarily, unique.  For instance, let's take $p=11$.  Let's find the primitive roots of $\mathbb{F}_{11}$:

```{code-cell} ipython3
for i in xsrange(1, 11):
    if Mod(i, 11).multiplicative_order() == 10:
        print(f"{i} is a primitive root (modulo 11).")
```

So, $2$, $6$, $7$, and $8$ are *all* primitive roots of $\mathbb{F}_{11}$.

Let's check that powers indeed give us all elements of $\mathbb{F}_{11}^{\times} = \{1, 2, 3, \ldots, 10\}$:

```{code-cell} ipython3
for i in [2, 6, 7, 8]:
    powers = sorted(Mod(i, 11)^x for x in range(10))
    print(f"{i}: {powers}")
```

Although a finding primitive can be difficult, after we find one, it is easy to find others:

:::{prf:proposition}
:label: pr-all_prim_roots
:numbered: true

If $g$ is a primitive root in $\Z/p\Z$, then *all* primitive roots of $\Z/p\Z$ are of the form $a^k$ where $\gcd(k, p-1)=1$.  Moreover, if $k$ and $k$ are both relatively prime to $p-1$ and *not* congruent modulo $p-1$, we have that $a^k$ and $a^l$ give us *distinct* primitive roots.  Therefore, there are $\varphi(p-1)$ distinct primitive roots in $\Z/p\Z$.
:::

Also, note that we need the modulus to be prime!  For instance, $\Z/8\Z$ has no primitive element.  We have that $\varphi(8) = \varphi(2^3) = (2-1) \cdot 2^2  = 4$, and $(\Z/8\Z)^{\times} = \{1, 3, 5, 7\}$, but:

```{code-cell} ipython3
for i in [1, 3, 5, 7]:
    print(f"Order of {i} is {Mod(i, 8).multiplicative_order()}")
```

So, no element of order $4$.

+++

## Bases and Binary Numbers

+++

We work with numbers with *decimal notation* (or, equivalently, in *base $10$*).  This means that we have ten *digits*, $0$ to $9$, and when we run out of digits (i.e., we have a number larger than ten) we add another digit "in front".  Let's express this idea in a more mathematical way.

Remember that
\begin{align*}
10^0 &= 1 \\
10^1 &= 10 \\
10^2 &= 100 \\
10^3 &= 1{,}000 \\
&\;\;\vdots \\
10^n &= 1\underbrace{000\ldots 000}_{\text{$n$ zeros}}
\end{align*}

This allows to write, say, the number $9{,}217$ as
$$
9{,}217 = 9{,}000 + 200 + 10 + 7 = 9 \cdot 10^3 + 2 \cdot 10^2 + 1 \cdot 10 + 9 \cdot 10^0.
$$

So, we can write any number as a sum of powers of $10$ times a digit in $\{0, 1, 2, \ldots , 9\}$.  In practice, *counting from the right*, we multiply the $k$-th digit by $10^{k-1}$ and then add all this products to get the number.  For example:
\begin{align*}
81 &= 8 \cdot 10 + 1 \cdot 10^0, \\
107 &= 1 \cdot 10^2 + 0 \cdot 10 + 7 \cdot 10^0, \\
3{,}445 &= 3 \cdot 10^3 + 4 \cdot 10^2 + 4 \cdot 10 + 5 \cdot 10^0.
\end{align*}

+++

Now, let's say that, for some reason, we want to only use $8$ digits: $\{0, 1, 2, \ldots, 7\}$, for instance, because we might have only $8$ fingers to count on, instead of $10$.  So, the digits $8$ and $9$ *do not exist* for us.  How would we write numbers, then?  Well, we follow the same idea: when we run out of digits, we start adding digits in front!

The problem is that then, our number $9$ would be represented as $10$, since when counting it would go:
$$
1, 2, 3, 4, 5, 6, 7, 10, 11, 12, 13, 14, 15, 16, 17, 20, 21 \ldots
$$

To make this a little less confusing, let's write use an subscript of $8$, as in $10_8$, when we mean that we are using eight digits, on *in base $8$*.  (This representation is also called *octal*.)  So, that is to say that
$$
10_8 = 8, \qquad 11_8 = 9, \qquad 12_8 = 10, \qquad \cdots
$$

Mathematically, this is very similar to numbers base $10$, but now we use powers of $8$, our new *base*.  So,
\begin{align*}
7_8 &= 7 \cdot 8^0 = 7,\\
10_8 &= 1 \cdot 8^1 + 0 \cdot 8^0 = 8, \\
215_8 &= 2 \cdot 2 \cdot 8^2 + 1 \cdot 8 + 5 = 141, \\
1{,}046_8 &= 1 \cdot 8^3 + 0 \cdot 8^2 + 4 \cdot 8 + 6 \cdot 8^0  = 550.
\end{align*}

+++

You might have heard that computers use *binary numbers*, meaning, numbers in *base $2$*.  Therefore, we use only two digits, $0$ and $1$.  The reason is due to how computers work.  Very roughly speaking, primitive computers involved a series of switches, which could be either on, represented by $1$, or off, represented by $0$:

```{figure} switch.jpg
:alt: switch
:align: center
:width: 200px
:name: switch

Power switch
```

So, if you have, say, $5$ switches, you can give on/off instructions to them with a sequence of $5$ zeros and ones, from $00000_2$ (all off) to $11111_2$ (all on), so, a number between $0$ and $1 \cdot 2^4 + 1 \cdot 2^3 + 1 \cdot 2^2 + 1 \cdot 2 + 1 \cdot 2^0 = 31$.  Each individual digit is called a *bit*.

Sometimes in computer science we use *hexadecimal numbers*, meaning numbers in base $16$.  So, we need $16$ digits.  Since we only have $10$, we add letters for the next six:
\begin{align*}
A &= 10, & B &= 11, & C &= 12, \\
D &= 13, & E &= 14, & F &= 15.
\end{align*}

Hence, for instance:
$$
A3D7_{16} = 10 \cdot 16^3 + 3 \cdot 16^2 + 13 \cdot 16 + 7 \cdot 16^0 = 41{,}943.
$$
The advantage is that now each digit corresponds to $4$ bits.

+++

### Converting Bases

+++

It should be clear by now how we can convert a number in some base to base $10$.  But how about the opposite way?

:::{prf:algorithm} Base Change
:label: al-base
:numbered: true

To convert a positive integer $n$ from base $10$ to base $b$, we perform a series of long divisions by $b$: while the quotient $q_i$ is not zero, we do:
\begin{align*}
n &= b \cdot q_0 + r_0, \\
q_0 &= b \cdot q_1 + r_1, \\
q_1 &= b \cdot q_2 + r_2, \\
&\;\; \vdots \\
q_{k-1} &= b \cdot q_k + r_k, \\
q_k &= b \cdot 0 + r_{k+1}.
\end{align*}
Then, we have that
$$
n = r_{k+1} \cdot b^{k+1} + r_k \cdot b^k + \cdots + r_2 \cdot b^2 + r_1 \cdot b + r_0 \cdot b^0,
$$
i.e.,
$$
n = (r_{k+1}r_k\cdots r_2r_1r_0)_b.
$$
:::


:::{note}

Note that the first remainder is the *last* digit!
:::

Let's show it in action.  We've seen that $1{,}046_8 = 550$.  So, let's double check it by converting $550$ to base $8$.

We divide our number by $8$:

```{code-cell} ipython3
divmod(550, 8)
```

The remainder is $6$, so our representation in base $8$ ends with $\boxed{6}$!  So now, we take the quotient and divide by $8$:

```{code-cell} ipython3
divmod(68, 8)
```

The second to the last digit is then $\boxed{4}$.  Since the quotient is not $0$ (it's $8$), we keep dividing, i.e., we divide the last quotient by $8$""

```{code-cell} ipython3
divmod(8, 8)
```

We get a remainder of $0$, so the next digit (to the left) is $\boxed{0}$.  The quotient is $1$, not zero, so we continue:

```{code-cell} ipython3
divmod(1, 8)
```

Now the quotient is $0$, so we are done, and the first digit (or last, from right to left) is $\boxed{1}$.

So, indeed, the digits from left to right were $550 = 1{,}046_8$.

+++

Again, you will implement this algorithm in your homework, but, as usual, Sage can do it for us using the method `.digits`:

```{code-cell} ipython3
550.digits(base=8)
```

Note that the digits are given left to right, as you can see.

If the base is greater than $10$, it gives the corresponding *numbers*, not really digits.  For example, we've see that $A3D7_{16} = 41{,}943$ (where $A=10$ and $D=13$):

```{code-cell} ipython3
41943.digits(base=16)
```

We can specify the digits using the optional argument `digits`:

```{code-cell} ipython3
41943.digits(base=16, digits="0123456789ABCDEF")
```

## Fast Powering

+++

As we will soon see, many encryption methods we will rely on computations of very large powers, so it is important that we have an efficient way to compute them.

The naive way to compute $g^N$ is to perform $N-1$ products:
\begin{align*}
g^2 &= g \cdot g \\
g^3 &= g^2 \cdot g \\
g^4 &= g^3 \cdot g \\
&\;\; \vdots \\
g^N &= g^{N-1} \cdot g.
\end{align*}

But there is a much more efficient way:

:::{prf:algorithm} Fast Powering Algorithm (Successive Squaring)
:label: al-fast_power
:numbered: true

To compute $g^N$, where $g$ is in $\Z/m\Z$:

1) Write $N$ in base $2$, i.e.,
   $$N = N_0 + N_1 \cdot 2 + N_2 \cdot 2^2 + \cdots N_r 2^r$$
   with $N_i \in \{0, 1\}$.  (Note that $r = \lfloor \log_2(N) \rfloor + 1$, where $\lfloor x \rfloor$ is just rounding down $x$ to the largest integer less than or equal to $x$, the so called *floor function*.)
2) Compute all powers, *reducing modulo $m$ at every step!*:
   \begin{align*}
    a_0 &\equiv g && \pmod{m} \\
    a_1 &\equiv a_0^2 \equiv g^2 && \pmod{m} \\
    a_2 &\equiv a_1^2 \equiv g^{2^2} &&\pmod{m} \\
    a_3 &\equiv a_2^2 \equiv g^ {2^3} &&\pmod{m} \\
   &\;\;\vdots \\
   a_r &\equiv a_{r-1}^2 \equiv g^{2^r} &&\pmod{m}.
   \end{align*}
   (Note that this gives a total of $r$ products, one for each squaring
3) Now we have
   \begin{align*}
    g^N &= g^{N_0 + N_1 \cdot 2 + N_2 \cdot 2^2 + \cdots N_r 2^r} \\
    &= g^{N_0} \cdot (g^2)^{N_1} \cdot (g^{2^2})^{N_2} \cdots (g^{2^r})^{N_r} \\
    &= a_0^{N_0} \cdot a_1^{N_1} \cdot a_2^{N_2} \cdots a_r^{N_r}.
   \end{align*}
   (Note that the powers of $N_i$ do not require extra products, since if $N_i$ is $0$, the factor $a^{N_i} = 1$ and can be simply skipped, and if $N_i=1$, then $a_i^{N_i} = a_i$.  Hence, this last step requires *at most* another $r$ products.)
:::

Therefore, with this method, we can compute $g^N$ in at most $2 r = 2 \cdot \lfloor \log_2(N) \rfloor + 2$ products.

```{warning}
In the second step above, it is *very* important the we compute $g^{{2^k}}$ by squaring the previously computer $g^{2^{k-1}}$ (as I do below), and not directly, as in `g^(2^k)`.
```


How does it compare to the previous naive method, that required $N-1$ products?

```{code-cell} ipython3
N = 10^6
floor(log(N, base=2)) + 2
```

So, for $N$ equal to one million, we go from $999{,}999$ products to only $21$!  That's a *huge* improvement!

Let's do a concrete example, with the help from Sage.  Suppose we want to compute $11^{156}$ in $\Z/1237\Z$.

First, we compute $156$ in base 2:

```{code-cell} ipython3
digits_base_2 = 156.digits(base=2)
digits_base_2
```

The length is:

```{code-cell} ipython3
len(digits_base_2)
```

Now, we could create a list with the powers of $11$ modulo $1237$.  But this can take some memory.  So, we will do one step at a time.  We initialize a variable `res` to keep the result as $1$ and a variable `a` as $g$, or $11$ in our case.  Our computations will be *much* faster if we make `g = Mod(11, 1237)`, as Sage then will automatically (and efficiently) reduce the result of each squaring modulo $1237$:

```{code-cell} ipython3
res = 1
a = Mod(11, 1237)
```

Now, at each step we look at the correspond binary digit:

* if the digit is $1$, we replace `res` by its product with `a`;
* if the digit is $0$, we do not change `res`.

Then, we replace `a` by `a^2`.

So, let's look at our first binary digit, remembering that Sage starts at index $0$:

```{code-cell} ipython3
digits_base_2[0]
```

Since it's zero, we only square `a`:

```{code-cell} ipython3
a ^= 2  # same as a = a^2
```

Next digit:

```{code-cell} ipython3
digits_base_2[1]
```

Also zero, so we just square `a` again:

```{code-cell} ipython3
a ^= 2  # same as a = a^2
```

Next:

```{code-cell} ipython3
digits_base_2[2]
```

Now the digit is $1$, so we do two steps:

```{code-cell} ipython3
res *= a  # same as res = res * a
a ^= 2
```

Next digit:

```{code-cell} ipython3
digits_base_2[3]
```

One again:

```{code-cell} ipython3
res *= a
a ^= 2
```

Next:

```{code-cell} ipython3
digits_base_2[4]
```

Two steps:

```{code-cell} ipython3
res *= a
a ^= 2
```

Next:

```{code-cell} ipython3
digits_base_2[5]
```

Since the digit is now $0$, we only square `a`:

```{code-cell} ipython3
a ^= 2
```

Continue:

```{code-cell} ipython3
digits_base_2[6]
```

Squaring only, again:

```{code-cell} ipython3
a ^= 2
```

Next:

```{code-cell} ipython3
digits_base_2[7]
```

Now, in principle we need two steps, since the digit is $1$, but since it is the last digit, there is no need to square, only update `res`:

```{code-cell} ipython3
res *= a
```

Now, `res` should contain our power:

```{code-cell} ipython3
res
```

We can check with Sage:

```{code-cell} ipython3
Mod(11, 1237)^156
```

Note that we only had $11$ products (instead of $155$!) and at each step we kept the numbers we are multiplying relatively small since we reduced the result modulo $1237$ at each step!

As you might expect, you will implement this algorithm in your homework.  Hopefully the steps above give you an idea on how to use a loop (and some if clauses) to automate the process.
