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

# Powers in $\mathbb{Z}/m\mathbb{Z}$

+++

## Negative Powers

+++

Now, if $a$ is a *unit* of $\mathbb{Z}/m\mathbb{Z}$, we can define negative powers! If $k$ is a positive integer, then we define
```{math}
a^0 = 1 \qquad \text{and} \qquad a^{-k} = \underbrace{a^{-1} \cdot a^{-1} \cdots a^{-1}}_{\text{$k$ factors of $a^{-1}$}}.
```

Moreover, the properties of powers we had before for positive exponents also work for if allow zero or negative exponents

+++

## The Euler $\varphi$-Function

+++

:::{prf:definition} The Euler $\varphi$-Function
:label: def-euler_phi


 Given a positive integer $m$, we defined the $\varphi(m)$ as the number of elements of $(\mathbb{Z}/m\mathbb{Z})^{\times}$, in other words
```{math}
\varphi(m) = \text{number of integers $a$ between $0$ and $m$ with $\gcd(a, m)=1$.}
```
We also define $\varphi(1)$ as $1$.  This function is called the *Euler $\varphi$ function*.
:::

:::{prf:example}
:nonumber:

1) Since $(\mathbb{Z}/5\mathbb{Z})^{\times} = \{1, 2, 3, 4\}$, then $\varphi(5) = 4$.
2) Since $(\mathbb{Z}/24\mathbb{Z})^{\times} = \{1, 5, 7, 11, 13, 17, 19, 23\}$, then $\varphi(24) = 8$.
:::

As we will later see, this function will be important for the RSA Cryptosystem.

One might ask if there is another way to compute $\varphi(m)$, besides just checking for integers relatively prime to $m$, which can be slow if $m$ is large.

We have:

:::{prf:theorem}
:label: th-phi_comp


Let $m$ be a positive integer greater than one and
```{math}
m = p_1^{e_1} \cdot p_2^{e_2} \cdots p_k^{e_k}
```
be its prime decomposition.  Then
```{math}
\varphi(m) = [(p_1 - 1) \cdot p^{e_1 -1}] \cdot [(p_2 - 1) \cdot p_2^{e_2 - 1}] \cdots [(p_k - 1) \cdot p_k^{e_k - 1}].
```
:::


:::{prf:example}
:nonumber:

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

## Reducing Powers

+++

Remember that we cannot reduce powers in computations in $\mathbb{Z}/m\mathbb{Z}$.  As we've seen, in $\mathbb{Z}/4\mathbb{Z}$ we have that $4 = 0$, but
```{math}
2^0 = 1 \neq 0 = 2^4.
```
That is, again, because the exponent must be in $\mathbb{Z}$, and not in $\mathbb{Z}/4\mathbb{Z}$.  But there is something we can do:

:::{prf:proposition}
:label: pr-power_eq_1


Let $a$ in $\mathbb{Z}/m\mathbb{Z}$ and suppose that $k$ is a *positive* integer such that $a^k = 1$.  Then, if $r \equiv s \pmod{k}$ (so, modulo $k$, *and not $n$*!), then $a^r = a^s$.  Therefore, we can reduce exponents modulo $k$ (and not $m$).
:::

Let's see some examples: we have that in $\mathbb{Z}/7\mathbb{Z}$ that $3^6 = 1$.

```{code-cell} ipython3
Mod(3, 7)^6
```

Then, it should be the case that for any exponent $r$, in $\mathbb{Z}/7\mathbb{Z}$ we should have that $2^r$ is the same as $2^s$ where $s$ is the residue of $r$ module $6$ (and not 7!).  Let's test it:

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

But, it is not hard to see, in general why this is true.  Suppose $a^k = 1$ in $\mathbb{Z}/m\mathbb{Z}$ and and $r \equiv s \pmod{k}$.  This means that $s = r + nk$ for some integer $n$.  Then, using properties of exponents:
```{math}
a^s = a^{r + nk} = a^r \cdot a^{nk} = a^r \cdot (a^k)^s = a^r \cdot 1^s = a^r.
```

+++

Of course, this is all based on the fact that $a^k = 1$ for some $k$, but this is not always going to be true.  If $a^k = 1$, then $a \cdot a^{k-1} = a^k = 1$, and so $a$ must be a *unit*!

But, assuming that $a$ *is* a unit, how would we find such $k$.  The answer is given below:

:::{prf:theorem} Euler's Theorem
:label: th-euler


Let $a$ be a unit in $\mathbb{Z}/m\mathbb{Z}$ (i.e., $\gcd(a, m) = 1$).  Then $a^{\varphi(m)} = 1$ in $\mathbb{Z}/m\mathbb{Z}$ (i.e., $a^{\varphi(m)} \equiv 1 \pmod{m}$).  (Here $\varphi$ is the Euler $\varphi$ function.)
:::

Again, let's check this with Sage:

```{code-cell} ipython3
number_tries = 1000
max_m = 3000

for _ in range(number_tries):
    m = randint(4, max_m)
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


If $p$ is prime and $p \nmid a$, then $a^{p-1} = 1$ in $\mathbb{Z}/p\mathbb{Z}$ (i.e., $a^{p-1} \equiv 1 \pmod{p}$).
:::

This follows from Euler's Theorem since, when $p$ is prime, we have that  $\varphi(p) = p-1$  and $\gcd(a, p) = 1$ if, and only if, $p \not\mid a$.

Let's apply these ideas in an example.

:::{prf:example} title
:nonumber:

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

Note that although raising a unit of $\mathbb{Z}/m\mathbb{Z}$ to the exponent $\varphi(m)$ *always* yields $1$ (by Euler's Theorem), it might not be the *smallest* positive power that gives $1$.  For instance, in $\mathbb{Z}/7\mathbb{Z}$, we have $\varphi(7) = 6$ and although $6^6 = 1$, we also have that $6^2 = 36 = 1 + 5 \cdot 7 = 1$.

We have the following definition:

:::{prf:definition} Order of an Element
:label: def-ord


If $a$ is a unit of $\mathbb{Z}/m\mathbb{Z}$, then the *order of $a$*, usually denoted by $|a|$, is the smallest positive power $k$ such that $a^k = 1$.
:::

(So, by Euler's Theorem, in $\mathbb{Z}/m\mathbb{Z}$, for any unit $a$, we have that $|a| \leq \varphi(m)$.)

We have:

:::{prf:proposition}
:label: pr-power_one


Let $a$ be a unit of $\mathbb{Z}/m\mathbb{Z}$. If $a^k = 1$, for some integer $k$, then $|a| \mid k$.  In particular, we always have that $|a| \mid \varphi(m)$.
:::

This is not too hard to see: suppose that $a^k$ and let's denote $n = |a|$.  We can perform the long division of $k$ by $n$: $k = qn + r$, for integers $q$ and $r$, with $r \in \{0, 1, 2, \ldots, (n-1)\}$.  Then,
```{math}
1 = a^k = a^{nq + r} = a^{nq} \cdot a^r = (a^n)^q \cdot a^r = 1^q \cdot a^r = a^r.
```
Therefore $r$ is a power smaller than $n=|a|$ that gives $1$.  But since, by definition of order $n$ is the smallest *positive* power that gives $1$, we must have that $r=0$ (remember $0$ is neither positive, nor negative!), i.e., $n \mid k$.

+++

:::{admonition} Homework
:class: note

In your homework you will write a function that takes a unit of $\mathbb{Z}/m\mathbb{Z}$ and computes its order.  One could do it by sheer "brute force", meaning testing if $a^1=1$, if not test if $a^2=1$, if not test if $a^3=1$, etc., until we find the first power that does result in $1$.  (This power is the order.)
:::

For instance, let's find the order of $3$ in $\mathbb{Z}/11\mathbb{Z}$:

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

Ah, so in $\mathbb{Z}/11\mathbb{Z}$ we have that $|3|=5$.

+++

An alternative would be to only test divisors of $\varphi(m)$, using Sage's `divisors` function.  This would work better for most numbers, but $\varphi(m)$ can be hard to compute.  In those cases, the "brute force" method would be better.

In our particular case above in $\mathbb{Z}/11\mathbb{Z}$, we would only to test divisors of $\varphi(11) = 10$, so $\{1, 2, 5, 10\}$.

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

### Orders of Powers

Remember that if $g$ is a primitive root of $\mathbb{F}_p$, then all elements of $\mathbb{F}_p^{\times}$ are powers of $g$.  We already know that $|g| = p-1$, being a primitive roots, so it is often useful to know what is the order of a power of $g$.  Or, more generally:

:::{prf:proposition} Order of a Power
:label: pr-order_power


Let $a \in (\mathbb{Z}/m\mathbb{Z})^{\times}$ with $|a| = n$.  Then, we have that
```{math}
|a^k| = \frac{n}{\gcd(n, k)}.
```
:::

It is not too hard to give a mathematical proof of this fact.  Note that if $d = \gcd(n, k)$, the $d$ divides both $n$ and $k$, so both $n/d$ and $k/d$ are *integers*.  So, we have that
```{math}
\begin{align*}
  (a^k)^{n/d} &= a^{(kn)/d} && \text{[properties of exponents]} \\
  &= a^{n \cdot k/d} \\
  &= (a^n)^{k/d} && \text{[since $k/d$ is an integer!]} \\
  &= 1^{k/d} && \text{[since $n=|a|$]} \\
  &= 1.
\end{align*}
```
Then, by {prf:ref}`pr-power_one`, we have that $|a^k|$ *divides* $n/d$.  But we are still left to prove that this power, $n/d$, is the *smallest* power of $a^k$ that gives $1$.

This is not too hard either, but for the sake of brevity, let's just check it with many random tests in Sage:

```{code-cell} ipython3
# bounds for the modulus
min_m = 30
max_m = 10^6

# number of tests
number_tries = 10^4

for _ in range(number_tries):
    # find random m
    m = randint(min_m, max_m)

    # find random *unit* a
    a = randint(2, m - 1)
    while gcd(a, m) != 1:
        # if not unit, try again!
        a = randint(2, m - 1)

    n = Mod(a, m).multiplicative_order()
    k = randint(1, euler_phi(m) - 1)
    d = gcd(n, k)

    # check!
    if (Mod(a, m)^k).multiplicative_order() != n // d:
        print(f"Fails for {m = }, {a = }, and {k = }.")
        break
else:
    print("It seems to work!")
```

(successive_powers)=
### Computing Successive Powers

+++

In many concrete examples, like the "brute force" computation of the order of a unit above, one needs to compute successive powers of an element.  In these cases, if one cares about performance (like *we do here*!), one should not use powers, but single products.  As an example, suppose we need to compute
```{math}
3^0, 3^1, 3^2, \ldots, 3^{100{,}000}.
```
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

## Primitive Elements

+++

Remember the group of units of $\mathbb{Z}/m\mathbb{Z}$:
```{math}
(\mathbb{Z}/m\mathbb{Z})^{\times} = \{a \in \mathbb{Z}/m\mathbb{Z} \; : \; \gcd(a, m) = 1\}.
```
When the modulus is prime, this set has an interesting (and useful) property:

:::{prf:theorem} Primitive Root Theorem
:label: th-prim_root


Let $p$ be a prime.  (Remember then that $\mathbb{F}_p$ is just another way to write $\mathbb{Z}/p\mathbb{Z}$.)  Then, there is an element $g \in \mathbb{F}_p^{\times}$ such that every element of $\mathbb{F}_p^{\times}$ is a power of $g$.  In other words:
```{math}
\mathbb{F}_p^{\times} = \{1, g, g^2, g^3, \ldots, g^{p-2}\}.
```
:::

:::{prf:definition} Primitive Root
:label: def-prim


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

Also, note that we need the modulus to be prime!  For instance, $\mathbb{Z}/8\mathbb{Z}$ has no primitive element.  We have that $\varphi(8) = \varphi(2^3) = (2-1) \cdot 2^2  = 4$, and $(\mathbb{Z}/8\mathbb{Z})^{\times} = \{1, 3, 5, 7\}$, but:

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
```{math}
\begin{align*}
10^0 &= 1 \\
10^1 &= 10 \\
10^2 &= 100 \\
10^3 &= 1{,}000 \\
&\;\;\vdots \\
10^n &= 1\underbrace{000\ldots 000}_{\text{$n$ zeros}}
\end{align*}
```

This allows to write, say, the number $9{,}217$ as
```{math}
9{,}217 = 9{,}000 + 200 + 10 + 7 = 9 \cdot 10^3 + 2 \cdot 10^2 + 1 \cdot 10 + 9 \cdot 10^0.
```

So, we can write any number as a sum of powers of $10$ times a digit in $\{0, 1, 2, \ldots , 9\}$.  In practice, *counting from the right*, we multiply the $k$-th digit by $10^{k-1}$ and then add all this products to get the number.  For example:
```{math}
\begin{align*}
81 &= 8 \cdot 10 + 1 \cdot 10^0, \\
107 &= 1 \cdot 10^2 + 0 \cdot 10 + 7 \cdot 10^0, \\
3{,}445 &= 3 \cdot 10^3 + 4 \cdot 10^2 + 4 \cdot 10 + 5 \cdot 10^0.
\end{align*}
```

+++

Now, let's say that, for some reason, we want to only use $8$ digits: $\{0, 1, 2, \ldots, 7\}$, for instance, because we might have only $8$ fingers to count on, instead of $10$.  So, the digits $8$ and $9$ *do not exist* for us.  How would we write numbers, then?  Well, we follow the same idea: when we run out of digits, we start adding digits in front!

The problem is that then, our number $9$ would be represented as $10$, since when counting it would go:
```{math}
1, 2, 3, 4, 5, 6, 7, 10, 11, 12, 13, 14, 15, 16, 17, 20, 21 \ldots
```

To make this a little less confusing, let's write use an subscript of $8$, as in $10_8$, when we mean that we are using eight digits, on *in base $8$*.  (This representation is also called *octal*.)  So, that is to say that
```{math}
10_8 = 8, \qquad 11_8 = 9, \qquad 12_8 = 10, \qquad \cdots
```

Mathematically, this is very similar to numbers base $10$, but now we use powers of $8$, our new *base*.  So,
```{math}
\begin{align*}
7_8 &= 7 \cdot 8^0 = 7,\\
10_8 &= 1 \cdot 8^1 + 0 \cdot 8^0 = 8, \\
215_8 &= 2 \cdot 2 \cdot 8^2 + 1 \cdot 8 + 5 = 141, \\
1{,}046_8 &= 1 \cdot 8^3 + 0 \cdot 8^2 + 4 \cdot 8 + 6 \cdot 8^0  = 550.
\end{align*}
```

+++

You might have heard that computers use *binary numbers*, meaning, numbers in *base $2$*.  Therefore, we use only two digits, $0$ and $1$.  The reason is due to how computers work.  Very roughly speaking, primitive computers involved a series of switches, which could be either on, represented by $1$, or off, represented by $0$:

```{figure} ./images/switch.jpg
:alt: switch
:align: center
:width: 200px
:name: switch

Power switch
```

So, if you have, say, $5$ switches, you can give on/off instructions to them with a sequence of $5$ zeros and ones, from $00000_2$ (all off) to $11111_2$ (all on), so, a number between $0$ and $1 \cdot 2^4 + 1 \cdot 2^3 + 1 \cdot 2^2 + 1 \cdot 2 + 1 \cdot 2^0 = 31$.  Each individual digit is called a *bit*.

Sometimes in computer science we use *hexadecimal numbers*, meaning numbers in base $16$.  So, we need $16$ digits.  Since we only have $10$, we add letters for the next six:
```{math}
\begin{align*}
A &= 10, & B &= 11, & C &= 12, \\
D &= 13, & E &= 14, & F &= 15.
\end{align*}
```

Hence, for instance:
```{math}
A3D7_{16} = 10 \cdot 16^3 + 3 \cdot 16^2 + 13 \cdot 16 + 7 \cdot 16^0 = 41{,}943.
```
The advantage is that now each digit corresponds to $4$ bits.

+++

### Converting Bases

+++

It should be clear by now how we can convert a number in some base to base $10$.  But how about the opposite way?

:::{prf:algorithm} Base Change
:label: al-base


To convert a positive integer $n$ from base $10$ to base $b$, we perform a series of long divisions by $b$: while the quotient $q_i$ is not zero, we do:
```{math}
\begin{align*}
n &= b \cdot q_0 + r_0, \\
q_0 &= b \cdot q_1 + r_1, \\
q_1 &= b \cdot q_2 + r_2, \\
&\;\; \vdots \\
q_{k-1} &= b \cdot q_k + r_k, \\
q_k &= b \cdot 0 + r_{k+1}.
\end{align*}
```
Then, we have that
```{math}
n = r_{k+1} \cdot b^{k+1} + r_k \cdot b^k + \cdots + r_2 \cdot b^2 + r_1 \cdot b + r_0 \cdot b^0,
```
i.e.,
```{math}
n = (r_{k+1}r_k\cdots r_2r_1r_0)_b.
```
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

:::{admonition} Homework
:class: note

Again, you will implement this algorithm in your homework.
:::

But, as usual, Sage can do it for us using the method `.digits`:

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

(fast_powering)=
## Fast Powering

+++

As we will soon see, many encryption methods we will rely on computations of very large powers, so it is important that we have an efficient way to compute them.

The naive way to compute $g^N$ is to perform $N-1$ products:
```{math}
\begin{align*}
g^2 &= g \cdot g \\
g^3 &= g^2 \cdot g \\
g^4 &= g^3 \cdot g \\
&\;\; \vdots \\
g^N &= g^{N-1} \cdot g.
\end{align*}
```

But there is a much more efficient way:

:::{prf:algorithm} Fast Powering Algorithm (Successive Squaring)
:label: al-fast_power


To compute $g^N$, where $g$ is in $\mathbb{Z}/m\mathbb{Z}$:

1) Write $N$ in base $2$, i.e.,
   ```{math}
   N = N_0 + N_1 \cdot 2 + N_2 \cdot 2^2 + \cdots N_r 2^r
   ```
   with $N_i \in \{0, 1\}$.  (Note that $r = \lfloor \log_2(N) \rfloor$, where $\lfloor x \rfloor$ is just rounding down $x$ to the largest integer less than or equal to $x$, the so called *floor function*.)
2) Compute all powers, *reducing modulo $m$ at every step!*:
```{math}
\begin{align*}
    a_0 &\equiv g && \pmod{m} \\
    a_1 &\equiv a_0^2 \equiv g^2 && \pmod{m} \\
    a_2 &\equiv a_1^2 \equiv g^{2^2} &&\pmod{m} \\
    a_3 &\equiv a_2^2 \equiv g^ {2^3} &&\pmod{m} \\
   &\;\;\vdots \\
   a_r &\equiv a_{r-1}^2 \equiv g^{2^r} &&\pmod{m}.
   \end{align*}
```

   (Note that this gives a total of $r$ products, one for each squaring.)
3) Now we have
```{math}
\begin{align*}
    g^N &= g^{N_0 + N_1 \cdot 2 + N_2 \cdot 2^2 + \cdots N_r 2^r} \\
    &= g^{N_0} \cdot (g^2)^{N_1} \cdot (g^{2^2})^{N_2} \cdots (g^{2^r})^{N_r} \\
    &= a_0^{N_0} \cdot a_1^{N_1} \cdot a_2^{N_2} \cdots a_r^{N_r}.
   \end{align*}
```

   (Note that the powers of $N_i$ do not require extra products, since if $N_i$ is $0$, the factor $a^{N_i} = 1$ and can be simply skipped, and if $N_i=1$, then $a_i^{N_i} = a_i$.  Hence, this last step requires *at most* another $r$ products.)
:::

Therefore, with this method, we can compute $g^N$ in at most $2 r = 2 \cdot \lfloor \log_2(N) \rfloor$ products.

```{warning}
In the second step above, it is *very* important the we compute $g^{{2^k}}$ by squaring the previously computer $g^{2^{k-1}}$ (as I do below), and not directly, as in `g^(2^k)`.
```


How does it compare to the previous naive method, that required $N-1$ products?

```{code-cell} ipython3
N = 10^6
floor(log(N, base=2)) + 2
```

So, for $N$ equal to one million, we go from $999{,}999$ products to only $21$!  That's a *huge* improvement!

Let's do a concrete example, with the help from Sage.  Suppose we want to compute $11^{156}$ in $\mathbb{Z}/1237\mathbb{Z}$.

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

Square ony again:

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
