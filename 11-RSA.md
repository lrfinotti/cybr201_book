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

# The RSA Cryptosystem

+++

## Euler's Formula

Before we introduce a new and important public-key cryptosystem, we need some theory.  We start by reviewing some facts about $\mathbb{Z}/m\mathbb{Z}$ from [](#05-Powers.md):

:::{prf:definition} The Euler $\varphi$-Function
:label: def-euler_phi-2


 Given a positive integer $m$, we defined the $\varphi(m)$ as the number of elements of $(\mathbb{Z}/m\mathbb{Z})^{\times}$, in other words
```{math}
\varphi(m) = \text{number of integers $a$ between $0$ and $m$ with $\gcd(a, m)=1$.}
```
We also define $\varphi(1)$ as $1$.  This function is called the *Euler $\varphi$ function*.
:::


:::{prf:theorem}
:label: th-phi_comp-2


Let $m$ be a positive integer greater than one and
```{math}
m = p_1^{e_1} \cdot p_2^{e_2} \cdots p_k^{e_k}
```
be its prime decomposition.  Then
```{math}
\varphi(m) = [(p_1 - 1) \cdot p^{e_1 -1}] \cdot [(p_2 - 1) \cdot p_2^{e_2 - 1}] \cdots [(p_k - 1) \cdot p_k^{e_k - 1}].
```
:::


:::{prf:theorem} Euler's Theorem
:label: th-euler-2


Let $a$ be a unit in $\mathbb{Z}/m\mathbb{Z}$ (i.e., $\gcd(a, m) = 1$).  Then $a^{\varphi(m)} = 1$ in $\mathbb{Z}/m\mathbb{Z}$ (i.e., $a^{\varphi(m)} \equiv 1 \pmod{m}$).  (Here $\varphi$ is the Euler $\varphi$ function.)
:::

:::{prf:proposition}
:label: pr-power_eq_1-2


Let $a$ in $\mathbb{Z}/m\mathbb{Z}$ and suppose that $k$ is a *positive* integer such that $a^k = 1$.  Then, if $r \equiv s \pmod{k}$ (so, modulo $k$, *and not $n$*!), then $a^r = a^s$.  Therefore, we can reduce exponents modulo $k$ (and not $m$).
:::



In this chapter we will deal with a modulus $N = pq$, where $p$ and $q$ are two distinct (*very* large) primes.  So, we have that $\varphi(N)=(p-1)(q-1)$.  Then, by [{name}](#th-euler), we have that if $\gcd(a, N) = 1$, then $a^{(p-1)(q-1)} = 1$ in $\mathbb{Z}/N\mathbb{Z}$.  But we can do better:

:::{prf:theorem} Euler's Formula
:label: th-order_pq


Let $p$ and $q$ be distinct primes, $N = pq$, and $g = \gcd((p-1), (q-1))$, and $a \in (\mathbb{Z}/N\mathbb{Z})^{\times}$.  Then, $a^{(p-1)(q-1)/g} = 1$ (in $\mathbb{Z}/N\mathbb{Z}$).  In particular, if both $p$ and $q$ are odd, we have that $a^{(p-1)(q-1)/2} = 1$.
:::

:::{prf:proof}
:nonumber:

Since $\gcd(a, pq) = 1$ (as $a$ is a unit in $\mathbb{Z}/N\mathbb{Z}$), we have that $\gcd(a, p) = \gcd(a, q) = 1$, so $a$ (as an integer) is also a unit ins $\mathbb{Z}/p\mathbb{Z}$ and $\mathbb{Z}/q\mathbb{Z}$.  Then, by [{name}](#th-eule), and noting the $(p-1)/g$ and $(q-1)/g$ are both *integers*, we have that
```{math}
\begin{align*}
a^{((p-1)(q-1)/g} & = \left( a^{p-1} \right)^{(q-1)/g} \equiv 1^{(q-1)/g} = 1 \pmod{p} \qquad \Longrightarrow \qquad &p \mid a^{(p-1)(q-1)/g}, \\[1.7ex]
a^{((p-1)(q-1)/g} & = \left( a^{q-1} \right)^{(p-1)/g} \equiv 1^{(p-1)/g} = 1 \pmod{q} \qquad \Longrightarrow \qquad &q \mid a^{(p-1)(q-1)/g}.
\end{align*}
```

Since $\gcd(p, q) = 1$, this means that $pq \mid a^{(p-1)(q-1)/g}$, i.e., $a^{(p-1)(q-1)/g} = 1$ in $\mathbb{Z}/N\mathbb{Z}$.

Note that if $p$ and $q$ are odd, then $2 \mid \gcd(p, q) = g$, and so $g/2$ is an integer and hence
```{math}
 a^{(p-1)(q-1)/2} = a^{(p-1)(q-1)(g/2)/g} = \left( a^{(p-1)(q-1)/g} \right)^{g/2} = 1^{g/2} = 1.
```
:::


## Roots Module $N = pq$

The security of ElGamal's cryptosystem is based on the difficulty of solving the discrete log problem.  The security of our next cryptosystem will depend on the difficulty of taking roots modulo $N = pq$, where $p$ and $q$ are distinct large primes.

:::{admonition} Question
:class: note

Given $p$ and $q$ two distinct and large problems, $c \in \mathbb{Z}/N\mathbb{Z}$, and a positive integer $e$, how can we find $x$ such that $x^e = c$ (in $\mathbb{Z}/N\mathbb{Z}$), i.e., find the $e$-th root of $c$ (in $\mathbb{Z}/N\mathbb{Z}$)?
:::

We start approaching a simpler problem, when the modulus is *prime*:

:::{prf:proposition} Roots in $\mathbb{Z}/p\mathbb{Z}$
:label: prop-root_mod_p


Let $p$ be prime, $c \in \mathbb{Z}/p\mathbb{Z}$, and $e$ a positive integer with $\gcd(e, p-1) = 1$.  Then, let $d$ be the inverse of $e$ modulo $p-1$ (i.e., $ed \equiv 1 \pmod{p-1}$).  Then
```{math}
x^e = c \quad \text{if and only if} \quad x = c^d.
```
(So, $x$ is an $e$-th root of $c$ in $\mathbb{Z}/p\mathbb{Z}$.)
:::

:::{prf:proof}
:nonumber:

If $c=0$, then $x^e=0$ if and only if $x=0$ if and only if $x^d=0$.

So, assume that $x \neq 0$ (in $\mathbb{Z}/p\mathbb{Z}$), i.e., $x \in (\mathbb{Z}/p\mathbb{Z})^{\times}$.  Since $\varphi(p) = p-1$, by [{name}](#th-euler-2) we have that $x^{p-1} = 1$.  Since $(p-1) \mid (de - 1)$, we have that $x^{de-1} = 1$, i.e., $x^{de} = x$.  Since $c$ is also a unit, the same argument tells us that $c^{de} = c$.

So, if $x^e = c$, then raising both sides to the $d$-th power, we have that
```{math}
x = x^de = c^d.
```

And if $x=c^d$, then raising both sides to the $e$-th power, we have that
```{math}
x^e = c^de = c.
```
:::


We can apply this to case we actually need:

:::{prf:proposition} Roots in $\mathbb{Z}/pq\mathbb{Z}$
:label: prop-root_mod_pq


Let $p$ and $q$ be dissecting primes, $N=pq$, $c \in \mathbb{Z}/N\mathbb{Z}$, and $e$ a positive integer with $\gcd(e, \varphi(N)) = 1$.  Then, let $d$ be the inverse of $e$ modulo $\varphi(N)$ (i.e., $ed \equiv 1 \pmod{\varphi(N)}$).  Then
```{math}
x^e = c \quad \text{if and only if} \quad x = c^d.
```
(So, $x$ is an $e$-th root of $c$ in $\mathbb{Z}/N\mathbb{Z}$.)
:::


:::{prf:proof}
:nonumber:

First note that since $\gcd(e, \varphi(N)) = \gcd(e, (p-1)(q-1)) = 1$, then $\gcd(e, (p-1)) = \gcd(e, (q-1)) = 1$.  Also, since $ed \equiv 1 \pmod{(p-1)(q-1)}$, then $ed \equiv 1 \pmod{p-1}$ and $ed \equiv 1 \pmod{q-1}$.

So, if $x^e = c$ (in $\mathbb{Z}/N\mathbb{Z}$), by [](#prop-root_mod_p), we have
```{math}
\begin{align*}
x^e \equiv c \pmod{pq} \quad &\Longrightarrow \quad x^e \equiv c \pmod{p} \quad &\Longrightarrow \quad x \equiv c^d \pmod{p}, \\
x^e \equiv c \pmod{pq} \quad &\Longrightarrow \quad x^e \equiv c \pmod{q} \quad &\Longrightarrow \quad x \equiv c^d \pmod{q}, \\
\end{align*}
```
which together, since $\gcd(p, q) = 1$, tell us that $x \equiv c^d \pmod{N}$ (as $N=pq$), i.e., $x = c^d$ in $\mathbb{Z}/N\mathbb{Z}$.

Conversely, if $x=c^d$, then raising to the $e$-th power and since $ed \equiv 1 \pmod{\varphi(N)}$, we get by [{name}](#th-euler-2) and [](pr-power_eq_1-2) that $x^e = (c^d)^e = c^{de} = c$ in $\mathbb{Z}/N\mathbb{Z}$.
:::


The following proposition, gives a faster way to find roots in $\mathbb{Z}/N\mathbb{Z}$:

:::{prf:proposition}
:label: pr-root


Let $p$ and $q$ be distinct primes, $N = pq$, $g = \gcd(p-1, q-1)$, $e$ a positive integer, and $d$ and inverse of $e$ modulo $(p-1)(q-1)/g$.  Then, for all $c \in $(\mathbb{Z}/N\mathbb{Z})^{\times}$, we have that $x = c^d$ is such that $x^e = c$, i.e., $c^d$ is an $e$-th root of $c$ in $\mathbb{Z}/N\mathbb{Z}$.
:::

:::{important}

This means that when finding $d$ to find the $e$-th root of $c$ (as in [](#prop-root_mod_pq)), we can find an inverse in modulo $(p-1)(q-1)/g$ instead of modulo $(p-1)(g-1)$, which is likely faster (if $g>1$).
:::

:::{prf:proof}
:nonumber:

By [](th-order_pq), we have that $c^{(p-1)(q-1)/q} = 1$, so by [](#pr-power_eq_1-2), we have that $c^{ed} = c$.  Hence, if $x = c^d$, then $x^e = c^{de} = c$.
:::


So, if we have $N = pq$ as above, $e$ a positive integer, and $c \in (\mathbb{Z}/N\mathbb{Z})^{\times}$, and we want to solve $x^e = c$, we simply need to find and inverse of $e$ modulo $\varphi(N)$ (or modulo $(p-1)(q-1)/g$, where $g = \gcd(p-1, q-1)$).  So, we need to find $p$ and $q$ for the given $N$.

+++

## How to compute $\varphi(N)$?

:::{admonition} Question
:class: important

How can we find $p$ and $q$ from $N = pq$, i.e., how can we computer $\varphi(N)$ or factor $N$?  How hard is it to solve either problem?
:::

We first note that the two questions are equivalent.  If we know how to factor $N = pq$ to find $p$ and $q$, the we can compute $\varphi(N)$ as $(p-1)(q-1)$.

But suppose we have a method to find $\varphi(N)$ without using the prime factorization of $N$, i.e., without the formula of [](#th-phi_comp-2).  What we get is some number, but we know that $\varphi(N)=(p-1)(q-1) = pq - p - q + 1 = N - p - q + 1$.  So, we get $p+q = N - \varphi(N) + 1$, where we know all numbers on the left, so we know the result of $p+q$.  We also know the product $N =  pq$.  With those two in hand, we can find $p$ and $q$ themselves!

We have that
```{math}
(x - p)(x - q) = x^2 -(p+q)x + pq = x^2 - (N - \varphi(N) + 1)x + N.
```
Finding the two roots of this quadratic equation (e.g., by using the [quadratic formula](https://en.wikipedia.org/wiki/Quadratic_formula)), we find $p$ and $q$.

Therefore, the two problems are *equivalent*: if we know how to factor $N=pq$, we know how to compute $\varphi(N)$ and if we know how to compute $\varphi(N)$ (for $N=pq$), then we know how to factor $N$.

### Example

Suppose we have $N = 28{,}651{,}547$, a number we know that is product of two primes, say $N = pq$, and somehow we also know that $\varphi(N) = 28{,}640{,}496$.  Let's find $p$ and $q$ as described above.  Make a polynomial
```{math}
x^2 - (N - \varphi(N) + 1)x + N = x^2 - (28{,}651{,}547 - 28{,}640{,}496 + 1 )x + 28{,}651{,}547 = x^2 - 11{,}052 x +  28{,}651{,}547= 0.
```

```{code-cell} ipython3
solve(x^2 - 11052*x + 28651547 == 0, x)
```

The two solutions, $4{,}153$ and $6{,}899$ are $p$ and $q$!

```{code-cell} ipython3
is_prime(4153) and is_prime(6899)
```

(sec-rsa)=
## The RSA Cryptosystem

In 1977 [Ron Rivest](https://en.wikipedia.org/wiki/Ron_Rivest), [Adi Shamir](https://en.wikipedia.org/wiki/Adi_Shamir), and [Leonard Adleman](https://en.wikipedia.org/wiki/Leonard_Adleman) published the public-key cryptosystem that become known as the [RSA Cryptosystem](https://en.wikipedia.org/wiki/RSA_cryptosystem).  It was the first public available public-key cryptosystem (earlier than ElGamal's), although, according to Wikipedia:

> An equivalent system was developed secretly in 1973 at Government Communications Headquarters (GCHQ), the British signals intelligence agency, by the English mathematician Clifford Cocks. That system was declassified in 1997.[2**


While the security of ElGamal's is based on the difficulty of computing discrete logs, RSA's security is based on the difficulty of taking $e$-th roots in $\mathbb{Z}/N\mathbb{Z}$, where $N$ is a product of very large primes, i.e., it's based on how hard it is to factor $N$.

**The RSA Cryptosystem:** In order for Bob (or anyone else) to send encrypted messages to Alice:

1) **Set up:**
    1) Alice chooses two large primes $p$ and $q$, to be *kept secret*, and computes $N = pq$.
    2) Alice chooses an *encryption exponent* $e$ between $2$ and $(p-1)(q-1) - 1$, with $\gcd(e, (p-1)(q-1)) = 1$.
    3) Alice uses the Extended Euclidean Algorithm to compute and inverse $d$ of $e$ modulo $(p-1)(q-1)$, i.e., she finds $d$ such that $de \equiv 1 \pmod{(p-1)(q-1)}$.  This $d$ is the *decryption exponent* and is kept secret.
    4) Alice *publishes* $N$ and $e$.
2) **Encryption:** To send a message $m$ (a number in $\{2, 3, \ldots, N-1\}$) to Alice, Bob computes $c=m^e$ in $\mathbb{Z}/N/Z$, and sends $c$ to Alice.
3) **Decryption:**  Alice decodes the encrypted message $c$ by computing $c^d$ in $\mathbb{Z}/N\mathbb{Z}$.

Note that we know that the decryption works, since $de \equiv 1 \pmod{(p-1)(q-1)}$ implies that
```{math}
c^d = \left( m^e \right) ^d = m^{de} = m \quad \text{(in $\mathbb{Z}/N\mathbb{Z}$).}
```


:::{warning}

As we will see in [Chapter 13](./13-Factorization.md), it is crucial to choose the primes $p$ and $q$ such that both $p-1$ and $q-1$ have large prime factors!
:::

:::{note}

1) Unlike ElGamal's cryptosystem, one cannot use someone else's setup, as $p$ and $q$ must be kept secret.
2) Encrypting and decrypting are done by computing powers in $\mathbb{Z}/N\mathbb{Z}$, so [Fast Powering](./05-Powers.md#fast-powering) comes handy!
3) It is important to have fast encryption, so using a small $e$ helps.  Of course we cannot use $e=1$ and $2$ is not relatively prime to $(p-1)(q-1)$, so it is also out.  So, one can use $e=3$.  It *seems* to be safe, but there are some concerns.  An option is to use $e = 2^{16} + 1$ (a prime!), as computing $m^e$ then takes only five products!
4) One should be careful once $d$ is found, that it is not too small.  We need $d > \sqrt[4]{N}$.  If that is not the case, when should choose another $e$ or $p$ and $q$.
5) Although we only know how to compute roots in $\mathbb{Z}/N\mathbb{Z}$ if we know how to factor $N$, it is possible that there might be a yet unknown, novel way without it.  Therefore, strictly speaking, the security of the RSA relies in the difficulty in computing roots in $\mathbb{Z}/N\mathbb{Z}$ (quickly enough), and not (necessarily) of the difficulty of factoring $N$.
:::


:::{admonition} Homework
:class: note

In your homework you will write functions to generate keys, and to encrypt and decrypt messages with the RSA cryptosystem.
:::

+++

## Implementation and Security Issues

### Man in the Middle

Solving the math problem that define cryptosystems are usually unfeasible to attackers.  Thus, they have to find other ways to break the security of the communication.

Suppose that Eve not only can see messages being exchanged between Bob and Alice, but can actually *intercept* them and replace the originals with different ones.  This is what is called a [man-in-the-middle attack](https://en.wikipedia.org/wiki/Man-in-the-middle_attack).  She then might be able to find a way to read the messages without being able to solve the underlying mathematical problem.

Let's illustrate how this could be done with the [Diffie-Hellman key exchange](./07-DH_and_ElGamal.md#DH_key_exchange):  Eve knows the prime $p$, $g \in \mathbb{F}^{\times}$, and its order $N$, as they are publicly available.
1) Alice chooses a secret key $a$, and sends $A = g^a$ (computed in $\mathbb{F}_p$) to Bob.
2) Eve intercepts $A$, chooses her own secret key $e$, and sends Bob $E = g^e$, who believes it came from Alice.
3) Bob chooses a secret key $b$, and sends $B = g^b$ to Alice.
4) Eve intercepts $B$, and send the *same* $E$ as above to Alice as well, who believes it came from Bob.
5) The secret, shared key between Alice and Bob, was supposed to be $B^a = A^b = g^{ab}$.  But instead, Alice has $E^a = g^{ea}$ and what Bob has is $E^b = g^{eb}$.  So, Alice and Bob actually share individual keys with *Eve*, while thinking that they share a key with each other.

To further illustrate the point, suppose that Alice and Bob wants to exchange secrete message by encoding them using their shared key, similar to ElGamal.  So, if Bob wants to send the message $m$ to Alice, he would send $m' = A^b m$ to Alice, $A^b$ being the shared key.  (So, Alice would be able to decrypt it by computing $(B^a)^{-1} m' = m$.)  But, in this situation, he would send $m' = E^bm$ to Eve (intercepting it on the way to Alice).  Eve then is capable of decrypting it, as she has $B^e = E^b$, and can invert it to recover $m$.

Then, Eve sends $m'' = A^e m$ to Alice, who believes is coming from Bob.  When she deciphers is, she will use the key $E^a$.  Since $E^a = A^e$, she *can* decrypt it and obtain Bob's original message $m$.  So, Alice believes that their communication was successful, but *Eve was able to read the message as well*.

+++

### Oracle

Suppose that Eve contacts Alice and asks her to verify that Alice is really "Alice", i.e., the party that can decode messages encrypted with the public-keys $d$ and $N$.  She may say that she will send some random message and asks Alice to decrypt it and send back the original message to Eve, so that Eve can see that Alice can indeed decode it.

Alice, in this case, would be called an *oracle*.

Alice might think that this would be OK.  If she sees that the message is not random (say, maybe it looks like some message that Bob would send her, or a credit card number, or social security number, etc.) or suspicious, she can just not send the decrypted message back to Eve.

But imagine that Eve intercepts some message encrypted message $c = m^e \in \mathbb{Z}/N\mathbb{Z}$, using RSA with encrypting exponent $e$, from Bob to Alice.  Eve can make it look random by choosing an element $k \in (\mathbb{Z}/N\mathbb{Z})^{\times}$ different from $0$ and $1$, and sending $c' = k^e c$, where $e$ is the public encrypting exponent.  She can then send it to Alice to verify she can decrypt it.  When she does, she computes
```{math}
(c')^d = (k^e c)^d = (k^e m^e)^d = (km)^{ed} = km.
```
To Alice, this will look random (since it is $km$, and not $m$) and she might feel confident that she can send $km$ back to Eve, proving she can decrypt messages encoded with the public method.

But, when Eve received $km$, she can multiply it by $k^{-1}$ (the inverse in $\mathbb{Z}/N\mathbb{Z}$) and obtain $m$ back: $k^{-1} \cdot (km) = (k^{-1}k) \cdot m = 1 \cdot m = m$.  Then, Eve is capable of reading Bob's secrete message $m$, without really computing an $e$-th root in $\mathbb{Z}/N\mathbb{Z}$.

This makes it clear that *Alice should not decipher any message to anyone*!

+++

### Multiple Encrypting Exponents

Suppose that Alice publishes two different encrypting exponents, say $e_1$ and $e_2$, for the same modulus $N$.  If somehow Eve can read the *same message from Bob*, say $c_1 = m^{e_1}$ and $c_2 = m^{e_2}$ (in $\mathbb{Z}/N\mathbb{Z}$), using the different exponents and $\gcd(e_1, e_3) = 1$, then Even can recover $m$: using the Extended Euclidean Algorithm, Eve finds integer $u$ and $v$ such that
```{math}
ue_1 + ve_2 = 1.
```
Then, she simply computes:
```{math}
c_1^u \cdot c_2^v = (m^{e_1})^u \cdot (m^{e_2})^v = m^{ue_1} \cdot m^{ve_2} = m^{ue_1 + ve_2} = m^1 = m,
```
recovering the secrete message $m$.

This situation is not too far fetched: imagine that Alice is an online retailer and Bob had the send his credit card number twice, for different transactions, and Alice had to change the encryption scheme for some reason (e.g., security concerns with the former encrypting exponent) in between transactions.

The bottom line is that if Alice needs to change the encryption method, *she should change the modulus $N$, and not only the encrypting exponent*.
