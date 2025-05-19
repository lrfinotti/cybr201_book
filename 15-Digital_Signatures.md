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

# Digital Signatures

+++

## Introduction

Suppose that Samantha has some (digital) document that she wants to publish.  The readers of this document might want to make sure that the document is indeed the one written by Samantha and was not changed in anyway.  So, the reader needs to verify two things: that Samantha is the author and that the document has not been altered.  This is the goal of [*Digital Signatures*](https://en.wikipedia.org/wiki/Digital_signature).

Our handwritten signatures satisfy a similar purpose (in a considerably less safe way), as our signature is supposed to be unique and difficult to falsify.  Digital signatures go one step further, as each document has its own signature.


### General Process

Here is the general process:

1) Samantha creates a pair of keys: a *private signing key* $K^{\mathrm{pri}}$ and *verification key* $K^{\mathrm{pub}}$.  The former is used to produce signatures and kept secret, while the latter is published and used to verify that the signature (and the corresponding signed document) are from Samantha.
2) Given a document $D$, Samantha uses some algorithm and her signing key $K^{\mathrm{pri}}$ to produce a digital signature $D^{\mathrm{sig}}$ (using both $D$ and $K^{\mathrm{pri}}$).
3) Samantha then publishes both the document and its signature: $(D, K^{\mathrm{pri}})$.
4) Anyone who wants to verify that $D$ is the document signed by Samantha uses the corresponding verification algorithm (entering the public available $D$, $D^{\mathrm{sig}}$, and $K^{\mathrm{pri}}$) to verify its authenticity.

Here are a few important considerations with digital signatures:
1) It should, of course, be difficult to find $K^{\mathrm{pri}}$ from the public data (i.e., $K^{\mathrm{pub}}$, signing algorithm, $D$, and $D^{\mathrm{sig}}$.)
2) Similarly, it should be hard to find another way to produce valid signatures that might not require knowledge of $K^{\mathrm{pri}}$.
3) The signing key $K^{\mathrm{pri}}$ should be hard to find even from *many* signed documents, as the same key is used by Samantha to sign every document (so that the same public key can always be used).
4) The public key must be made available in a secure location that Samantha controls, as if someone can replace Samantha's verification key with their own, they can then sign documents using their own key.

A common application of digital signatures is securing software installations.  For instance, in [Linux](https://en.wikipedia.org/wiki/Linux), [package managers](https://en.wikipedia.org/wiki/Package_manager) are used to download and install software.  It only downloads software from repositories that provide signed files, and when it downloads the software it checks the signatures against the public verification key from the repository.  This guarantees that all software installed has not been altered.

One can also create digital signatures to be used with email, so that the person who receives a message from you can verify that it was not coming from someone else pretending to be you or altered in transmission.

### Size and Hash Functions

Another important consideration is the size of the signature.  Most methods will provide a signature of the same size as the document itself.  Although this might not be a problem for short texts, it can be a problem if $D$ is large, e.g., some large piece of software.  Not only it will require a lot of bandwidth to download both the software and its signature, the verification process is also slow.

Signing only a truncated version of $D$ is also dangerous, as malicious code or text can be added to the non-signed part.  But we still need to sign something related to $D$ smaller than itself.  The usual solution is to use a [hash function](https://en.wikipedia.org/wiki/Hash_function).  A hash function $\mathrm{Hash}$ takes a document (of any size) and produce a "hash value" $\mathrm{Hash}(D)$ of a fixed size of bits.  This size is usually relatively small and in practice, and hence often in practice the hash value $\mathrm{Hash}(D)$, for a published hash function $\mathrm{Hash}$, is signed instead of $D$ itself.  (In other words, Samantha publishes $(D, \mathrm{Hash}(D)^{\mathrm{sig}})$ instead of $(D, D^{\mathrm{sig}})$.)  Then, in the verification process, one first computes $\mathrm{Hash}(D)$ and then verify the signature with this hash value.

But this has some potential problems.  Since the size of $D$ can be considerably larger than the size of its hash value, its mathematically impossible for the hash values to be unique, meaning that there will be different documents, say $D \neq D'$, with the same hash value, i.e., $\mathrm{Hash}(D) = \mathrm{Hash}(D')$.  This might seem problematic at first, if $\mathrm{Hash}(D) = \mathrm{Hash}(D')$, when we verify the signature of $\mathrm{Hash}(D)$, we cannot be $100\%$ sure that signature is for the document $D$, as $D'$ would produce the same hash value, and would be "verified" with this process.  So, if the malicious party, Eve, can produce a document with the same hash value as the original, then it can be verified using the hash function, and it will be believed that this alternative document was signed by Samantha.

The key idea here is that a good hash function has to be random enough that it is very hard to find some other $D'$ that gives $\mathrm{Hash}(D') = \mathrm{Hash}(D)$ and if found, it would be "nonsensical", i.e., it would have no meaning as text or computer code.  In summary, here are the requirements of hash functions:

1) It should be hard to find $D$ from $\mathrm{Hash}(D)$.
2) It should be hard to find $D'$ such that $\mathrm{Hash}(D) = \mathrm{Hash}(D')$.
3) A small change in $D$ should produce a large change in its hash value.
4) It should be highly unlikely that if $D$ is a proper document (or piece of software) and $\mathrm{Hash}(D) = \mathrm{Hash}(D')$, then $D'$ is also a coherent piece of text (or working software).


For the sake of simplicity, in what follows we will simply refer to the signature of the document itself, but in practice we would likely sign the hash value.  In fact, we before, we will take the document to be a *number*, just like with encryption, as any computer file can be made into a number (or sequence of numbers, if too large), as it is a sequence of zeros and ones that can be interpreted as a binary number.

+++

## RSA Digital Signature

We often can use cryptosystems to create a digital signature algorithm.  Basically we "decrypt" the document and publish this version as the signature.  Then, encrypting it will produce the original document, which verifies that the signature is valid.

Here is how it would work using the [RSA Cryptosystem](#sec-rsa):

1) **Setup:**  (Same as the RSA)
    1) Samantha chooses two large primes $p$ and $q$, to be *kept secret*, and computes $N = pq$.
    2) Samantha chooses an *verification key/exponent* $e$ between $2$ and $(p-1)(q-1) - 1$, with $\gcd(e, (p-1)(q-1)) = 1$.
    3) Samantha uses the Extended Euclidean Algorithm to compute and inverse $d$ of $e$ modulo $(p-1)(q-1)$, i.e., she finds $d$ such that $de \equiv 1 \pmod{(p-1)(q-1)}$.  This $d$ is the *signing key/exponent* and is kept secret.
    4) Samantha *publishes* $N$ and $e$.
2) **Signing:** The signature $D^{\mathrm{sig}}$ of $D$, where $D$ is an integer between $1$ and $N-1$, is simply the reduction modulo $N$ of $D^d$.
3) **Verification:** To verify that $D^{\mathrm{sig}}$ is indeed a signature of $D$, one uses the public verification key $e$ to compute the reduction modulo $N$ of $\left( D^{\mathrm{sig}} \right)^e$.  It the result is $D$, the signature is valid.  If not, it is invalid.


This works since
```{math}
\left( D^{\mathrm{sig}} \right)^e \equiv \left( D^d \right)^e = D^{de} \equiv D \pmod{N},
```
just like with the RSA cryptosystem.


Of course, the security of this signing scheme is the same as for the RSA.  In principle, to break it (i.e., for one to be able to falsify Samantha's signature), one needs to find $d$, which means factoring $N$.

+++

### Example

Let's illustrate the process with a simple example.  We will use the primes $p = 977$ and $q = 1283$:

```{code-cell} ipython3
p, q = 977, 1283
is_prime(p), is_prime(q)
```

```{code-cell} ipython3
N = p * q
N
```

Let's use $31$ for the verification key:

```{code-cell} ipython3
e = 31
gcd(e, (p - 1) * (q - 1))
```

We now compute the signing key:

```{code-cell} ipython3
d = xgcd(e, (p - 1) * (q - 1))[1] % N
d
```

Let's use $12345$ for our document.

```{code-cell} ipython3
D = 12345
```

Samantha then uses the signing key to compute the signature:

```{code-cell} ipython3
D_sig = Mod(D, N)^d
D_sig
```

Whenever anyone wants to verify that $D^{\mathrm{sig}}$ is the signature of $D$, they just compute:

```{code-cell} ipython3
D_sig^e
```

Since the result is equal to $D$, the signature is valid.

:::{admonition} Homework
:class: note

You will implement this process in your homework.
:::

+++

## ElGamal Digital Signature

Similarly, one can also adapt the ElGamal Cryptosystem to produce a digital signature:

1) **Set up:**
    1) Samantha chooses (or copies) and publishes a large prime $p$ and a primitive root $g \in \mathbb{F}^{\times}$, i.e., $g$ has order $p-1$.
    2) Samantha chooses a *private* key $a \in \{1, 2, 3, \ldots, p-2\}$ and publishes $A = g^a$ (in $\mathbb{F}_p$).
2) **Signing:** To sign a document $D$ (a numbers between $2$ and $p-1$):
   1) Samantha chooses a *random* *ephemeral* key (i.e., a random key to be discarded after a single use) $k$.
   2) Samantha computes
      - $S_1 = g^k$ in $\mathbb{F}_p$,
      - $S_2=(D - a S_1)k^{-1}$ in $\mathbb{Z}/(p-1)\mathbb{Z}$.
   3) Samantha publishes the signature $D^{\mathrm{sig}} = (S_1, S_2)$.
4) **Verification:** To verify that $(S_1, S_2)$ i a signature for $D$, one checks if
```{math}
A^{S_1} \cdot S_1^{S_2} = g^D \quad \text{(in $\mathbb{F}_p$)}.
```

Let's verify why this works.  We have (in $\mathbb{F}_p$):
```{math}
\begin{align*}
A^{S_1} \cdot S_1^{S_2}
&= (g^a)^{S_1} \cdot S_1^{(D - a S_1)k^{-1}} \\
&= g^{aS_1} \cdot (g^k)^{(D - a S_1)k^{-1}} \\
&= g^{aS_1} \cdot g^{k(D - a S_1)k^{-1}} \\
&= g^{aS_1} \cdot g^{D - a S_1} \\
&= g^{aS_1 + D - a S_1} \\
&= g^D.
\end{align*}
```

Again, the security is based in the *Discrete Log Problem*: if Eve can compute $\log_g(A) = a$, she can fake Samantha's signature.  And, at least so far, this is the only known approach to falsify Samantha's signature when using this method.

But, similar to ElGamal's encryption, the problem with this method is that the key is large: the document has size about $p$, while the signature has size about $p + (p-1)$.

+++

(sec-dsa)=
## Digital Signature Algorithm

One can address the size problem of ElGamal's digital signature by working in a "subgroup" of $\mathbb{F}^{\times}$.  This the [Digital Signature Algorithm](https://en.wikipedia.org/wiki/Digital_Signature_Algorithm):

1) **Setup:**
   1) Samantha chooses (or copies):
      - $p$ and $q$ primes, with $q \mid (p - 1)$;
      - $g \in \mathbb{F}^{\times}$ of order $q$.
   2) Samantha chooses a private signing key $a$ and computes $A = g^a$ (in $\mathbb{F}_p$).
   3) Samantha publishes $(p, q, g, A)$.
2) **Signing:** To sign $D \in \{ 2, 3, \ldots, (q-1) \}$ (note the size!):
   1) Samantha chooses a *random* *ephemeral* key (i.e., a random key to be discarded after a single use) $k$ with $\gcd(k, q) = 1$.
   2) Samantha computes:
      - $S_1$ as the reduction of $g^k$ (in $\mathbb{F}_p$) and reduces it modulo $q$,
      - $S_2 = (D + a S_1)k^{-1}$ in $\mathbb{F}_q$ (and $k^{-1}$ then is the inverse of $k$ in $\mathbb{F}_q$).
   3) Samantha publishes the digital signature $D^{\mathrm{sig}}= (S_1, S_2)$.
3) **Verification:** To verify the signature $(S_1, S_2)$:
   1) One computes:
      - $V_1 = DS_2^{-1}$ (in $\mathbb{F}_q$),
      - $V_2 = S_1 S_2^{-1}$ (in $\mathbb{F}_q$).
  2) One checks if $g^{V_1}A^{V_2}$ (in $F_p$) reduced modulo $q$ is equal to $S_1$.


Let's see why this works.  First remember that since $g$ has order $q$, then if $x \equiv y \pmod{q}$, then $g^x = g^y$.  Then, in $\mathbb{F}_p$, we have
```{math}
g^{V_1} A^{V_2} = g^{DS_2^{-1}} (g^a)^{S_1 S_2^{-1}} = g^{(D + aS_1)S_2^{-1}} = g^{(D + a S_1)(D + a S_1)^{-1} k} = g^k.
```
Thus, reducing $g^{V_1} A^{V_2}$ modulo $q$, we get the reduction of $g^k$ modulo $q$, which is $S_1$.

Note that the security is also bases on the discrete log problem, as that's how one can find $a$ from $A = g^a$.

Here are some remarks about this method:

1) One usually chooses $p$ between $2^{1000}$ and $2^{2000}$ and $q$ between $2^{160}$ and $2^{320}$.  Hence, $q$ is considerably smaller than $p$.
2) If $x \in \mathbb{F}^{\times}$ is a primitive root, then we can take $g = x^{(p-1)/q}$.
3) Since $q \mid (p-1)$, we have that $p \nmid p$.  This means that reducing an integer modulo $q$ is *not* the same as reducing it modulo $p$ and then reducing it modulo $q$.  So, it is essential that we work in $\mathbb{F}_p$ before reducing elements modulo $q$, as in the second step of the verification or computation of $S_1$.
4) Although $q$ is much smaller than $p$ in practice, the discrete log problem is still in $\mathbb{F}^{\times}$, so still hard for large $p$.
5) Note that the signature is still about twice the size of the document (i.e., $2q$ versus $q$), but since the security is bases on $p$, it is a lot safer for the given size!
6) As observed before, one can make it harder to break it by using a different group instead of $\mathbb{F}^{\times}$, since then one cannot use the index calculus to compute $\log_g(A)$.  We will soon do this, by using *elliptic curves*.  In that case, the best attack is a collision algorithm, such as Shank's Babystep-Giantstep, which is less efficient than the index calculus, making it safer.

:::{caution}

The random key $k$ cannot be repeated!
:::

Suppose that Samantha uses the same random key $k$ to sign $D$ and $D'$.  Then, $S_1$ (from the signature of $D$) and $S_1'$ (from the signature of $D'$) are the same, i.e., $S_1 = S_1'$ (in $\mathbb{F}_q$).  Then, the corresponding $S_2$ and $S_2'$ (both in $\mathbb{F}_q$) are the reductions modulo $q$ of $(D - a S_1)k^{-1}$ and $(D' - a S_1)k^{-1}$, respectively.  Then, in $\mathbb{F}_q$, we have
```{math}
\frac{S_2}{S_2'} = \frac{(D - aS_1)k^{-1}}{(D' - aS_1)k^{-1}} = \frac{D - aS_1}{D' - aS_1}.
```
Cross multiplying and solving for $a$, we get
```{math}
a = \frac{D - D' S_2/S_2'}{1 - S_2/S_2'}.
```
Since all terms on the right-side are known (from the documents and their signatures), Eve can get the secret signing key $a$, and hence falsify Samantha's signature.

+++

### Example

```{code-cell} ipython3
p = random_prime(2000, lbound=1000)
q = factor(p - 1)[-1][0]
p, q
```

```{code-cell} ipython3
factor(p - 1)
```

Let's take $p = 1997$ and $q = 499$:

```{code-cell} ipython3
p, q = 1997, 499
is_prime(p), is_prime(q), (p - 1) % q == 0
```

Let's find a primitive root in $\mathbb{F}^{\times}$.  This is simple using Sage's functions:

```{code-cell} ipython3
primitive_root = Zmod(p).multiplicative_generator()
primitive_root
```

```{code-cell} ipython3
primitive_root.multiplicative_order() == p - 1
```

So, we take $g$ to be this primitive root to the power of $(p - 1) / q$:

```{code-cell} ipython3
g = primitive_root^((p - 1) // q)
g
```

```{code-cell} ipython3
g.multiplicative_order() == q
```

Let's take our private signing key to be $a = 571$:

```{code-cell} ipython3
a = 571
```

Then, the public verification key is $A = g^a$:

```{code-cell} ipython3
A = g^a
A
```

And let's take the document to be $D = 1234$:

```{code-cell} ipython3
D = 1234
```

To sign first we take a random key, say $k = 390$:

```{code-cell} ipython3
k = 390
```

Let's compute $S_1$:

```{code-cell} ipython3
S1 = Mod(ZZ(g^k), q)  # note we convert form F_p to integers to F_q
```

Now $S_2$:

```{code-cell} ipython3
S2 = (Mod(D, q) + a * S1) * Mod(k, q)^(-1)
```

So, the signature is $(S_1, S_2)$:

```{code-cell} ipython3
D_sig = (S1, S2)
D_sig
```

Now, one can verify if the signature corresponds to $D$.  We compute $V_1$ and $V_2$, using the document $D$ and its signature $(S_1, S_2)$:

```{code-cell} ipython3
V1 = D * S2^(-1)
V2 = S1 * S2^(-1)
```

Now, using the verification key $A$ (and $V_1$ and $V_2$ above), we check if the signature is valid:

```{code-cell} ipython3
Mod(ZZ(g^ZZ(V1) * A^ZZ(V2)), q) == S1
```

It works!

Let's change $D$ slightly to see if the authentication fails (as it should):

```{code-cell} ipython3
DD = 1235
```

We now try to verify this new document using the signature for the original:

```{code-cell} ipython3
V1 = DD * S2^(-1)  # wrong document
V2 = S1 * S2^(-1)

Mod(ZZ(g^ZZ(V1) * A^ZZ(V2)), q) == S1  # this should fail!
```

Indeed, it fails!
