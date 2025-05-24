---
jupytext:
  formats: ipynb,md:myst
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

(hw)=
# Homework

+++

There are ten homework sets written for this book.  Each one is a [Jupyter notebook](https://jupyter.org/) that should run with a [Sage](https://www.sagemath.org/) kernel.

Each problem contains four to five problems where the reader can implement and test some of the concepts introduced in the text.  In most of the problems the reader is required to write functions to perform some task or computation.  In most cases there are tests for each function to try to validate the code, although it should be observed that these tests have limitations and incorrect or incomplete code might still pass all tests.  In some cases comparisons of different methods are also present.

These start relatively easy, but do get a little more involved towards the end.

:::{note}

It should be observed that in many examples the reader will implement functions that are already available in Sage, e.g., computations of the greatest common divisor, Legendre symbol, different primality tests, etc.  Of course, our goal is to reinforce the ideas behind the algorithms, and not create new tools and we hope that the ones attempting these problems will keep that in mind.
:::


Below is a description of each set.  Each section will contain a link for the corresponding assignment, but here is a link for [all homework sets (ZIP file)](http://luisfinotti.org/pcimc-hw/hw.zip).

+++

(sec-hw1)=
## Homework 1

**Download Link:** [Homework 1](http://luisfinotti.org/pcimc-hw/hw01.ipynb)

This set contains five problems:

1) *Naive GCD:* Compute the [GCD (greates common divisor)](#sec-gcd) by testing divisors (using no "advanced" Sage function).
2) *GCD Using `divisors`:* Compute the GCD using Sage's `divisors` function.
3) *Euclidean Algorithm:* Implement the {prf:ref}`Euclidean Algorithm <alg-ea>` for computations of the GCD.
4) *Extended Euclidean Algorithm:* Implement the {prf:ref}`Extended Euclidean Algorithm <al-eea>`.
5) *Selecting a Solution for the Extended Euclidean Algorithm:* Given integers $u$ and $v$ such that $au + bv = \gcd(a, b)$, find integers $u_0$, $v_0$ such that $u_0$ is the smallest positive integer such that $au_0 + bv_0 = \gcd(a, b)$.  (This done using {prf:ref}`pr-bezout_mult_sol`.)

+++

(sec-hw2)=
## Homework 2

**Download Link:** [Homework 2](http://luisfinotti.org/pcimc-hw/hw02.ipynb)

This set contains four problems:

1) *Factorization of Integers:* Give the {prf:ref}`prime factorization <th-fta>` of an integer $n$.
2) *Euler Phi Function:* Compute the $\varphi(n)$, where $\varphi$ is the {prf:ref}`Euler Phi Function <def-euler_phi>`.
3) *Representation in Base $b$:* Given an integer $n$, {prf:ref}`compute its representation in a given base<al-base>`.
4) *Fast Exponentiation Modulo $m$:* Compute powers modulo $m$ quickly using the {prf:ref}`Fast Powering Algorithm <al-fast_power>`.

+++

(sec-hw3)=
## Homework 3

**Download Link:** [Homework 3](http://luisfinotti.org/pcimc-hw/hw03.ipynb)

This set contains five problems:

1) *Computer Order of an Element:* Given an unit in $\mathbb{Z}/m\mathbb{Z}$, compute its {prf:ref}`order <def-ord>`.
2) *Find all Primitive Roots:* Given a prime $p$, find all {prf:ref}`primitive roots <def-prim>` of $\mathbb{Z}/p\mathbb{Z}$.
3) *Proportion of Elements of Order $q$:* Given primes $p$ and $q$, with $q \mid (p-1)$, compute the proportion of elements of order $q$ in $\mathbb{F}_p^{\times}$.
4) *Find Random Element of Order $q$:* Given primes $p$ and $q$, with $q \mid (p-1)$, find a random element of order $q$ in $\mathbb{F}_p^{\times}$.
5) *Find Primitive Roots (Special Case):* Given a prime $p$ such that $q = (p-1)/2$ is also prime, find a primitive root of $\mathbb{F}_p^{\times}$.

+++

(sec-hw4)=
## Homework 4

**Download Link:** [Homework 4](http://luisfinotti.org/pcimc-hw/hw04.ipynb)

This set contains four problems:

1) *Random $k$-bit Prime:* Given a positive integer $k$, find a *random* $k$-bit prime.
2) *Naive Discrete Log:* Given $g$ and $h$ in $\mathbb{F}_p^{\times}$, find, if possible, the [discrete log](#sec-dl) $\log_g(h)$ by "brute force".
3) *ElGamal Cryptosystem:* Write functions to encrypt and decrypt messages using the [ElGamal Cryptosystem](#sec-elgamal).
4) *Babystep-Giantstep Algorithm:* Implement the {prf:ref}`Babystep-Giantstep Algorithm <al-bs_gs>` for computations of discrete logs.

+++

(sec-hw5)=
## Homework 5

**Download Link:** [Homework 5](http://luisfinotti.org/pcimc-hw/hw05.ipynb)

This set contains four problems:

1) *Chinese Remainder Theorem:* Use the {prf:ref}`Chinese Remainder Theorem (CRT) <th-crt>` to find solutions of systems of congruences.
2) *Extended Euclidean Algorithm for Many Integers:* Use the {prf:ref}`Generalized Extended Euclidean Algorithm <al-geea>` to write the GCD of an arbitrary number of integers as a linear combination of those integers.
3) *Pohlig-Hellman Algorithm:* Implement the {prf:ref}`Pohlig-Hellman Algorithm <al-ph>` for computations of discrete logs, by reducing the computations to discrete logs whose bases are powers of a prime.
4) *Reduce the DLP to Order Prime Only:* Given some $g$ of order power of prime $p^n$, {prf:ref}`compute discrete logs <al-dl-power>` base $b$ by computing discrete logs with bases of order $p$.

+++

(sec-hw6)=
## Homework 6

**Download Link:** [Homework 6](http://luisfinotti.org/pcimc-hw/hw06.ipynb)

This set contains five problems:

1) *RSA Encryption/Decryption:* Write functions for encryption, decryption, and key generation for the [RSA Cryptosystem](#sec-rsa).
2) *Carmichael Numbers:* Given an integer $n \geq 2$, decide if it is composite or either {prf:ref}`Carmichael Number <def-carmichael>` or prime.
3) *Miller-Rabin Test:* Given integers $a$ and $n$, use the {prf:ref}`Miller-Rabin Test <al-mr>` to see if $a$ is a witness for the compositeness of $n$.
4) *Miller-Rabin Witness:* Given some integer $n$, compute how many {prf:ref}`Miller-Rabin witnesses <def-mr_witness>` it has.
5) *Probabilistic Primality Test:* Use the Miller-Rabin test to produce a *probabilistic* primality test.

+++

(sec-hw7)=
## Homework 7

**Download Link:** [Homework 7](http://luisfinotti.org/pcimc-hw/hw07.ipynb)

This set contains four problems:

1) *Finding Random Primes:* Use the method [described earlier](#sec-find_random_prime) to find a random prime of given number of bits.
2) *Pollard's $p-1$ Factorization:* Implement {prf:ref}`Pollard's factorization algorithm <al-pollard>`.
3) *Relation Building for Difference of Squares Factorization:* Implement the second part of the *Relation Building* step for the [Difference of Squares Factorization Algorithm](#sec-diff-squares).
4) *Elimination for Difference of Squares Factorization:* Implement the *Elimination* step for the [Difference of Squares Factorization Algorithm](#sec-diff-squares).

+++

(sec-hw8)=
## Homework 8

**Download Link:** [Homework 8](http://luisfinotti.org/pcimc-hw/hw08.ipynb)

This set contains four problems:

1) *Square Roots Modulo $p$:* Given some integer $a$ and prime $p$, compute the square root of $a$ modulo $p$ if it exists.
2) *Square Roots Modulo $p^n$:* Given some integer $a$, prime $p$, some power $n$, and $b$ a square root modulo $p$, compute the square root of $a$ modulo $p^n$.
3) *Quadratic Reciprocity:* Given some integer $a$ and prime $p$, use {prf:ref}`Quadratic Reciprocity <th-qr>` to {prf:ref}`decide <al-sqr-qr>` if $a$ is a square modulo $p$.
4) *Quadratic Sieve (Relation Building):* Use the {prf:ref}`Quadratic Sieve <al-rel-build>` to implement the first part of the *Relation Building* step for the [Difference of Squares Factorization Algorithm](#sec-diff-squares).

+++

(sec-hw9)=
## Homework 9

**Download Link:** [Homework 9](http://luisfinotti.org/pcimc-hw/hw09.ipynb)

This set contains four problems:

1) *Index Calculus:* Implement (parts of) the [Index Calculus](#sec-index-calc) method for computations of the discrete log (in $\mathbb{F}_p^{\times}$).
2) *RSA Digital Signature:* Implement functions for signing and verifying documents using the [RSA Digital Signature](#sec-rsa-ds).
3) *ElGamal Digital Signature:* Implement functions for generating keys and for signing and verifying  documents using the [ElGamal Digital Signature](#sec-elgamal-ds).
4) *Digital Signature Algorithm (DSA):* Implement functions for generating keys and for signing and verifying  documents using the [Digital Signature Algorithm (DSA)](#sec-dsa).

+++

(sec-hw10)=
## Homework 10

**Download Link:** [Homework 10](http://luisfinotti.org/pcimc-hw/hw10.ipynb)

This set contains four problems:

1) *Adding Points on Elliptic Curves:* Given an elliptic curve and two of its points, give the {prf:ref}`sum of these two points <al-sum>`.
2) *Ternary Expansion:* Given a positive integer $n$, give its {prf:ref}`ternary expansion <al:ternary>`.
3) *Menezes-Vanstone Elliptic Curve ElGamal:* Write function for encryption and decryption using the [Menezes-Vanstone Elliptic Curve ElGamal Cryptosystem](#sec-ec-mve-crypto).
4) *Elliptic Curve DSA (ECDSA):* Write functions for singing and verifying documents using the [Elliptic Curve DSA (ECDSA)](#sec-ec_DSA)
