# ---
# jupyter:
#   jupytext:
#     default_lexer: ipython3
#     formats: ipynb,sage:percent,md:myst
#     text_representation:
#       extension: .sage
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.17.1
#   kernelspec:
#     display_name: SageMath 10.5
#     language: sage
#     name: sage-10.5
# ---

# %% [markdown]
# # Number Theory

# %% [markdown]
# ## What is Number Theory?

# %% [markdown]
# [Number Theory](https://en.wikipedia.org/wiki/Number_theory), to put it very simply, is the study of integers, i.e., the set
# ```{math}
# \mathbb{Z} = \{\ldots -3, -2, -1, 0, 1, 2, 3, \ldots\}.
# ```
# It is one of the oldest branches of mathematics.  In particular, *prime numbers* (as we will discuss below) have a central role in Number Theory.
#
# For a long time it was an area of with little concrete applications.  [G. H. Hardy](https://en.wikipedia.org/wiki/G._H._Hardy), a very famous number theorist, once called Number Theory "useless".
#
# > I have never done anything 'useful'. No discovery of mine has made, or is likely to make, directly or indirectly, for good **or ill**, the least difference to the amenity of the world.
#
# (Emphasis mine.)
#
# But with the advent of computers, Number Theory has found many applications, and one the most notable is cryptography.
#
# We will then spend sometime learning some of the basics of Number Theory (with a very concrete and computational approach) before we start with the applications.

# %% [markdown]
# ## Long Division

# %% [markdown]
# You probably remember long division from school.  You can break an integer as a multiple of another plus some remainder smaller than what you are dividing by.  More precisely:
#
# :::{prf:theorem} Long Division
# :label: th-long_division
#
#
# Given $a,b \in \mathbb{Z}$, with $b \neq 0$, there is a *unique* pair of integers $(q,r)$ such that $a=bq+r$ and $r \in \{0, 1, 2, \ldots, |b|-1\}$.
# :::
#
#
# :::{note}
#
# Note that $|b|$ above is the *absolute value* of $b$, meaning that if $b$ is non-negative, then $|b|=b$, and if it is negative, then $|b| = -b$, i.e., the "positive version" of $b$.)
# :::

# %% [markdown]
# For positive integers, the process is fairly simple: we start subtracting $b$ from $a$ until what we have is less than $b$.  The number of times we subtract $b$ from $a$ is the *quotient* $q$ and what is left (the number less than $b$, perhaps $0$) is the remainder $r$.
#
# So, $b$ goes into $a$ exactly $q$ times, with a left-over of $r$.

# %% [markdown]
# :::{prf:example}  Long Division
# :nonumber:
#
# What are the quotient and remainder of $183$ when divided by $37$?
# :::

# %%
a, b = 182, 37
a - b

# %%
a - 2*b

# %%
a - 3*b

# %%
a - 4*b

# %% [markdown]
# Ah-ha!  Since $34$ is less than $37$, we have that the remainder is $34$ and the quotient is $4$.  So, we have
# ```{math}
# 182 = 37 \cdot \underbrace{4}_{\text{quotient}} + \underbrace{34}_{\text{remainder}}.
# ```

# %% [markdown]
# Let's automate this process:

# %%
def positive_long_div(a, b):
    """
    Given two positive integers a and b, return the quotient and remainder
    of the long division of a by b.

    INPUTS:
    a: the dividend (positive integer)
    b: the divisor (positive integer)

    OUTPUT:
    (q, r): q the quotient and r the remainder of the long division of a by b.
    """
    q = 0  # initialize the quotient as 0
    r = a  # initialize the remainder as a
    while r >= b:
        q += 1
        r -= b
    return (q, r)

# %% [markdown]
# Let's test it!

# %%
positive_long_div(182, 37)

# %% [markdown]
# If the dividend $a$ is already less than the divisor $b$, the quotient should be $0$ and the remainder $a$:

# %%
positive_long_div(5, 7)

# %% [markdown]
# We should also be able to do the same when the dividend $a$ is negative.  Note that we still want the remainder to be between $0$ and $b-1$ (inclusive in both ends).  In this case, instead of subtracting, we need to *add* $b$ until we get a non-negative number.
#
# So, if we were to divide $-182$ by $37$:

# %%
a, b = -182, 37
a + b

# %%
a + 2*b

# %%
a + 3*b

# %%
a + 5*b

# %% [markdown]
# Since $3$ is our first non-negative number, it is the remainder, and $-5$ (note the *negative*) is the quotient:
# ```{math}
# -182 = 37 \cdot \underbrace{(-5)}_{\text{quotient}} + \underbrace{3}_{\text{remainder}}.
# ```

# %% [markdown]
# In principle $b$ could also be negative, but let's not bother with that case, as it is rather unusual.  So, lets automate the process for negative and positive dividends in a single function:

# %%
def long_div(a, b):
    """
    Given an integer a and a positive integer b, return the quotient and remainder
    of the long division of a by b.

    INPUTS:
    a: the dividend (integer)
    b: the divisor (positive integer)

    OUTPUT:
    (q, r): q the quotient and r the remainder of the long division of a by b.
    """
    if a >= 0:
        q = 0  # initialize the quotient as 0
        r = a  # initialize the remainder as a
        while r >= b:
            q += 1
            r -= b
        return (q, r)

    # no need for else, as we only get here when a < 0:
    q = -1  # initialize the quotient as -1
    r = a + b  # initialize the remainder as a + b
    while r < 0:
        q -= 1
        r += b
    return (q, r)

# %% [markdown]
# Testing:

# %%
long_div(182, 37)

# %%
long_div(-182, 37)

# %% [markdown]
# ----

# %% [markdown]
# The work above is a good exercise in thinking [algorithmically](https://en.wikipedia.org/wiki/Algorithm) and writing Sage/Python code, but, as one would expect, we could also have done this directly, as `//` gives the quotient and `%` gives the remainder!

# %%
182 // 37, 182 % 37

# %%
-182 // 37, -182 % 37

# %% [markdown]
# In fact, Sage (but not Python) has the function `divmod`:

# %%
help(divmod)

# %% [markdown]
# So, to make sure our code is OK, let's test our function against Sage's:

# %%
count = 1_000  # number of test
max_int = 1_000_000
for i in range(count):
    a = randint(-max_int, max_int)
    b = randint(1, max_int)  # it cannot be zero!
    mine = long_div(a, b)  # my result
    sages = divmod(a, b)  # Sage's
    if mine != sages:  # check for problems and print data!
        print(f"Failed for {a = } and {b = }.")
        print(f"Sage's result: {sages}.")
        print(f"My result:     {mine}")
        break  # stop!
else:  # runs when for loop ended without break!!!!!
    print("It worked (for all tests)!")

# %% [markdown]
# ----

# %% [markdown]
# We say then that $b$ divides $a$ if the remainder of the long division of $a$ by $b$ is zero.  Another way to say it is:  $b$ divides $a$ if there is an integer $q$ such that $a = bq$.
#
# :::{prf:definition} Notation
#
# We often write $b \mid a$ for "$b$ divides $a$".
#
# Note that $b / a$ is a *number*, meaning $b$ *divided* by $a$.  On the other hand $b \mid a$ is a *boolean* (i.e. `True` or `False`).
#
# Note that instead of "$b$ divides $a$", we can also say:
# * $b$ is a *factor* of $a$, or
# * $a$ is a *multiple* of $b$.
#
# (They all mean the same thing.)
# :::
#
# If we only want to test for divisibility, we can simply use `a % b` in Sage/Python.  If it is zero, then `b` does divide `a`, and if not zero, then `b` does not divide `a`.

# %% [markdown]
# ## Primes

# %% [markdown]
# :::{prf:definition} Prime
# :nonumber:
#
# A positive integer $p$ is *prime* if it is not $1$ and the only positive divisors are $1$ and $p$ itself.  Integers greater than $1$ that are not prime are called *composite*.
# :::
#
# :::{note}
# Note that $1$ is *neither* prime nor composite!
# :::
#
# Examples are $2$, $3$, $5$, $7$, and $11$, the first five primes.  The number $4$ is composite, since $2$ is a positive divisor different from $1$ and $4$.
#
# Testing if a positive integer is prime is a very important problem in Number Theory.  Let's write a very naive function to test if a number is prime, by looking for all possible divisors:

# %%
def prime_test(n):
    """
    Given an integer n >= 1, returns True if n is prime and False
    if it is not.

    INPUT:
    n: number to be test for primality (integer >= 1).

    OUTPUT:
    boolean for whether or not n is prime.
    """
    # we do n = 2 separate
    if n == 2:
        return True
    # now, test for divisors
    for div in xsrange(2, n):  # stops at n-1
        if n % div == 0:  # found divisor
            return False
    return True

# %% [markdown]
# Let's test for some small numbers that we know to be prime:

# %%
for n in xsrange(2, 20):
    if prime_test(n):
        print(f"{n = } is prime!")
    else:
        print(f"{n = } is composite.")

# %% [markdown]
# It seems to work, but it is *relatively* very slow.  For instance, $30{,}000{,}001$ is prime, but it takes us a little while to get there:

# %%
# %%time
prime_test(3 * 10^7 + 1)

# %% [markdown]
# But here is a simple mathematical idea that can speed up this quite a bit!
#
# If $n = a \cdot b$, with $a$ and $b$ integers greater than $1$ (and hence also smaller than $n$), what can we say about the size of the *smallest* factor, say $a$?  (Note that we allow $a = b$.)
#
# If $a > \sqrt{n}$, then also $b > \sqrt{n}$, and so
# ```{math}
# n = a \cdot b < \sqrt{n} \cdot \sqrt{n} = n,
# ```
#
# i.e., $n < n$, which is impossible!  Therefore, we must have that, if $n$ is composite, then the smallest divisor *must be* less than or equal to $\sqrt{n}$!
#
# Therefore, we only need to test for divisors up to $\sqrt{n}$.  If none is found up to there, then $n$ must be prime.
#
# So, in our original function, the worst case scenario was that we performed $n-2$ divisions (looking for factors), but with this idea we perform at most $\sqrt{n} - 2$ divisions.
#
# That is a *huge* difference for large numbers.  For instance, for $n = 30{,}000{,}001$, we had to perform $20{,}999{,}999$ divisions, since it was prime.  With this idea, we perform only $5{,}475$!
#
# Let's implement and compare!

# %%
def prime_test_2(n):
    """
    Given an integer n >= 1, returns True if n is prime and False
    if it is not.

    INPUT:
    n: number to be test for primality (integer >= 1).

    OUTPUT:
    boolean for whether or not n is prime.
    """
    # we do n = 2 separate
    if n == 2:
        return True
    # now, test for divisors
    for div in xsrange(2, floor(sqrt(n)) + 1):  # stops at sqrt(n)  (NOTE the "+1")
        if n % div == 0:  # found divisor
            return False
    return True

# %%
# %%time
prime_test_2(3 * 10^7 + 1)

# %% [markdown]
# This very simple idea gave a huge improvement, but required some mathematical knowledge (and maturity).  That is often the case: no matter how good a coder you are, or what language and computing tricks, knowing some math can have a much greater impact in your code!

# %% [markdown]
# ## The Sieve of Eratosthenes

# %% [markdown]
# Let's see if we can improve the previous algorithm.  A very natural idea, which we would likely do when checking for primality by hand, is to only check divisibility by $2$ and then skip all other even numbers.  After all if $2$ does not divide a number, no other even number will.  This would cut the time (in worst case scenarios, i.e., when the number *is* prime) in *half*!
#
# But them, similarly, after we check if the number is divisible by $3$, we do not need to check any other multiples of $3$, further cutting the time in *one third*!
#
# And then we do the same for $5$.  (No need for $4$, since it is even.)  Then $7$.  (Six is also even.)  Then $11$. (Eight and $10$ are even and $9$ is divisible by $3$.)  And so on...
#
# We then see that we only need to check divisibility by *primes*!
#
# But wait, we don't know which numbers are prime.  (That's exactly what we are trying to do here.)

# %% [markdown]
# The [Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes) offers a solution to this natural idea!  It is a bit more memory intensive, since we have store (more or less) all numbers up to the one we want to test in memory.  But, at the end, it does not only check if the number itself is prime: it gives us *all* primes *up to* that number!
#
# Let's see how it works.

# %% [markdown]
# Suppose we want to know if $101$ is prime.  We start with a list of all integer between $2$ and $101$ both inclusive:
#
# ```{math}
# \begin{array}{rrrrrrrrrr}
# 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 \\
# 12 & 13 & 14 & 15 & 16 & 17 & 18 & 19 & 20 & 21 \\
# 22 & 23 & 24 & 25 & 26 & 27 & 28 & 29 & 30 & 31 \\
# 32 & 33 & 34 & 35 & 36 & 37 & 38 & 39 & 40 & 41 \\
# 42 & 43 & 44 & 45 & 46 & 47 & 48 & 49 & 50 & 51 \\
# 52 & 53 & 54 & 55 & 56 & 57 & 58 & 59 & 60 & 61 \\
# 62 & 63 & 64 & 65 & 66 & 67 & 68 & 69 & 70 & 71 \\
# 72 & 73 & 74 & 75 & 76 & 77 & 78 & 79 & 80 & 81 \\
# 82 & 83 & 84 & 85 & 86 & 87 & 88 & 89 & 90 & 91 \\
# 92 & 93 & 94 & 95 & 96 & 97 & 98 & 99 & 100 & 101
# \end{array}
# ```

# %% [markdown]
# We know that $2$ is prime and we can then cross all multiples of $2$ from the list, which we can do without division, by just crossing every other element:
#
# ```{math}
# \begin{array}{rrrrrrrrrr}
# {\color{red} 2} & 3 & {\color{gray} \cancel{4}} & 5 & {\color{gray} \cancel{6}} & 7 & {\color{gray} \cancel{8}} & 9 & {\color{gray} \cancel{10}} & 11 \\
# {\color{gray} \cancel{12}} & 13 & {\color{gray} \cancel{14}} & 15 & {\color{gray} \cancel{16}} & 17 & {\color{gray} \cancel{18}} & 19 & {\color{gray} \cancel{20}} & 21 \\
# {\color{gray} \cancel{22}} & 23 & {\color{gray} \cancel{24}} & 25 & {\color{gray} \cancel{26}} & 27 & {\color{gray} \cancel{28}} & 29 & {\color{gray} \cancel{30}} & 31 \\
# {\color{gray} \cancel{32}} & 33 & {\color{gray} \cancel{34}} & 35 & {\color{gray} \cancel{36}} & 37 & {\color{gray} \cancel{38}} & 39 & {\color{gray} \cancel{40}} & 41 \\
# {\color{gray} \cancel{42}} & 43 & {\color{gray} \cancel{44}} & 45 & {\color{gray} \cancel{46}} & 47 & {\color{gray} \cancel{48}} & 49 & {\color{gray} \cancel{50}} & 51 \\
# {\color{gray} \cancel{52}} & 53 & {\color{gray} \cancel{54}} & 55 & {\color{gray} \cancel{56}} & 57 & {\color{gray} \cancel{58}} & 59 & {\color{gray} \cancel{60}} & 61 \\
# {\color{gray} \cancel{62}} & 63 & {\color{gray} \cancel{64}} & 65 & {\color{gray} \cancel{66}} & 67 & {\color{gray} \cancel{68}} & 69 & {\color{gray} \cancel{70}} & 71 \\
# {\color{gray} \cancel{72}} & 73 & {\color{gray} \cancel{74}} & 75 & {\color{gray} \cancel{76}} & 77 & {\color{gray} \cancel{78}} & 79 & {\color{gray} \cancel{80}} & 81 \\
# {\color{gray} \cancel{82}} & 83 & {\color{gray} \cancel{84}} & 85 & {\color{gray} \cancel{86}} & 87 & {\color{gray} \cancel{88}} & 89 & {\color{gray} \cancel{90}} & 91 \\
# {\color{gray} \cancel{92}} & 93 & {\color{gray} \cancel{94}} & 95 & {\color{gray} \cancel{96}} & 97 & {\color{gray} \cancel{98}} & 99 & {\color{gray} \cancel{100}} & 101
# \end{array}
# ```

# %% [markdown]
# Then, we are sure that the next non-crossed out element is also prime, in this case, $3$.  And again, we can cross out all its multiples, by jumping with a step size of $3$:
#
# ```{math}
# \begin{array}{rrrrrrrrrr}
# {\color{red} 2} & {\color{red}3 } & {\color{gray} \cancel{4}} & 5 & {\color{gray} \cancel{6}} & 7 & {\color{gray} \cancel{8}} & {\color{gray} \cancel{9}} & {\color{gray} \cancel{10}} & 11 \\
# {\color{gray} \cancel{12}} & 13 & {\color{gray} \cancel{14}} & {\color{gray} \cancel{15}} & {\color{gray} \cancel{16}} & 17 & {\color{gray} \cancel{18}} & 19 & {\color{gray} \cancel{20}} & {\color{gray} \cancel{21}} \\
# {\color{gray} \cancel{22}} & 23 & {\color{gray} \cancel{24}} & 25 & {\color{gray} \cancel{26}} & {\color{gray} \cancel{27}} & {\color{gray} \cancel{28}} & 29 & {\color{gray} \cancel{30}} & 31 \\
# {\color{gray} \cancel{32}} & {\color{gray} \cancel{33}} & {\color{gray} \cancel{34}} & 35 & {\color{gray} \cancel{36}} & 37 & {\color{gray} \cancel{38}} & {\color{gray} \cancel{39}} & {\color{gray} \cancel{40}} & 41 \\
# {\color{gray} \cancel{42}} & 43 & {\color{gray} \cancel{44}} & {\color{gray} \cancel{45}} & {\color{gray} \cancel{46}} & 47 & {\color{gray} \cancel{48}} & 49 & {\color{gray} \cancel{50}} & {\color{gray} \cancel{51}} \\
# {\color{gray} \cancel{52}} & 53 & {\color{gray} \cancel{54}} & 55 & {\color{gray} \cancel{56}} & {\color{gray} \cancel{57}} & {\color{gray} \cancel{58}} & 59 & {\color{gray} \cancel{60}} & 61 \\
# {\color{gray} \cancel{62}} & {\color{gray} \cancel{63}} & {\color{gray} \cancel{64}} & 65 & {\color{gray} \cancel{66}} & 67 & {\color{gray} \cancel{68}} & {\color{gray} \cancel{69}} & {\color{gray} \cancel{70}} & 71 \\
# {\color{gray} \cancel{72}} & 73 & {\color{gray} \cancel{74}} & {\color{gray} \cancel{75}} & {\color{gray} \cancel{76}} & 77 & {\color{gray} \cancel{78}} & 79 & {\color{gray} \cancel{80}} & {\color{gray} \cancel{81}} \\
# {\color{gray} \cancel{82}} & 83 & {\color{gray} \cancel{84}} & 85 & {\color{gray} \cancel{86}} & {\color{gray} \cancel{87}} & {\color{gray} \cancel{88}} & 89 & {\color{gray} \cancel{90}} & 91 \\
# {\color{gray} \cancel{92}} & {\color{gray} \cancel{93}} & {\color{gray} \cancel{94}} & 95 & {\color{gray} \cancel{96}} & 97 & {\color{gray} \cancel{98}} & {\color{gray} \cancel{99}} & {\color{gray} \cancel{100}} & 101
# \end{array}
# ```

# %% [markdown]
# Now we repeat!  The next non-crossed out element, namely $5$ is prime, and we cross out all its multiples:
#
# ```{math}
# \begin{array}{rrrrrrrrrr}
# {\color{red} 2} & {\color{red}3 } & {\color{gray} \cancel{4}} & {\color{red} 5} & {\color{gray} \cancel{6}} & 7 & {\color{gray} \cancel{8}} & {\color{gray} \cancel{9}} & {\color{gray} \cancel{10}} & 11 \\
# {\color{gray} \cancel{12}} & 13 & {\color{gray} \cancel{14}} & {\color{gray} \cancel{15}} & {\color{gray} \cancel{16}} & 17 & {\color{gray} \cancel{18}} & 19 & {\color{gray} \cancel{20}} & {\color{gray} \cancel{21}} \\
# {\color{gray} \cancel{22}} & 23 & {\color{gray} \cancel{24}} & {\color{gray} \cancel{25}} & {\color{gray} \cancel{26}} & {\color{gray} \cancel{27}} & {\color{gray} \cancel{28}} & 29 & {\color{gray} \cancel{30}} & 31 \\
# {\color{gray} \cancel{32}} & {\color{gray} \cancel{33}} & {\color{gray} \cancel{34}} & {\color{gray} \cancel{35}} & {\color{gray} \cancel{36}} & 37 & {\color{gray} \cancel{38}} & {\color{gray} \cancel{39}} & {\color{gray} \cancel{40}} & 41 \\
# {\color{gray} \cancel{42}} & 43 & {\color{gray} \cancel{44}} & {\color{gray} \cancel{45}} & {\color{gray} \cancel{46}} & 47 & {\color{gray} \cancel{48}} & 49 & {\color{gray} \cancel{50}} & {\color{gray} \cancel{51}} \\
# {\color{gray} \cancel{52}} & 53 & {\color{gray} \cancel{54}} & {\color{gray} \cancel{55}} & {\color{gray} \cancel{56}} & {\color{gray} \cancel{57}} & {\color{gray} \cancel{58}} & 59 & {\color{gray} \cancel{60}} & 61 \\
# {\color{gray} \cancel{62}} & {\color{gray} \cancel{63}} & {\color{gray} \cancel{64}} & {\color{gray} \cancel{65}} & {\color{gray} \cancel{66}} & 67 & {\color{gray} \cancel{68}} & {\color{gray} \cancel{69}} & {\color{gray} \cancel{70}} & 71 \\
# {\color{gray} \cancel{72}} & 73 & {\color{gray} \cancel{74}} & {\color{gray} \cancel{75}} & {\color{gray} \cancel{76}} & 77 & {\color{gray} \cancel{78}} & 79 & {\color{gray} \cancel{80}} & {\color{gray} \cancel{81}} \\
# {\color{gray} \cancel{82}} & 83 & {\color{gray} \cancel{84}} & {\color{gray} \cancel{85}} & {\color{gray} \cancel{86}} & {\color{gray} \cancel{87}} & {\color{gray} \cancel{88}} & 89 & {\color{gray} \cancel{90}} & 91 \\
# {\color{gray} \cancel{92}} & {\color{gray} \cancel{93}} & {\color{gray} \cancel{94}} & {\color{gray} \cancel{95}} & {\color{gray} \cancel{96}} & 97 & {\color{gray} \cancel{98}} & {\color{gray} \cancel{99}} & {\color{gray} \cancel{100}} & 101
# \end{array}
# ```

# %% [markdown]
# Then repeat for $7$:
#
# ```{math}
# \begin{array}{rrrrrrrrrr}
# {\color{red} 2} & {\color{red}3 } & {\color{gray} \cancel{4}} & {\color{red} 5} & {\color{gray} \cancel{6}} & {\color{red} 7} & {\color{gray} \cancel{8}} & {\color{gray} \cancel{9}} & {\color{gray} \cancel{10}} & 11 \\
# {\color{gray} \cancel{12}} & 13 & {\color{gray} \cancel{14}} & {\color{gray} \cancel{15}} & {\color{gray} \cancel{16}} & 17 & {\color{gray} \cancel{18}} & 19 & {\color{gray} \cancel{20}} & {\color{gray} \cancel{21}} \\
# {\color{gray} \cancel{22}} & 23 & {\color{gray} \cancel{24}} & {\color{gray} \cancel{25}} & {\color{gray} \cancel{26}} & {\color{gray} \cancel{27}} & {\color{gray} \cancel{28}} & 29 & {\color{gray} \cancel{30}} & 31 \\
# {\color{gray} \cancel{32}} & {\color{gray} \cancel{33}} & {\color{gray} \cancel{34}} & {\color{gray} \cancel{35}} & {\color{gray} \cancel{36}} & 37 & {\color{gray} \cancel{38}} & {\color{gray} \cancel{39}} & {\color{gray} \cancel{40}} & 41 \\
# {\color{gray} \cancel{42}} & 43 & {\color{gray} \cancel{44}} & {\color{gray} \cancel{45}} & {\color{gray} \cancel{46}} & 47 & {\color{gray} \cancel{48}} & {\color{gray} \cancel{49}} & {\color{gray} \cancel{50}} & {\color{gray} \cancel{51}} \\
# {\color{gray} \cancel{52}} & 53 & {\color{gray} \cancel{54}} & {\color{gray} \cancel{55}} & {\color{gray} \cancel{56}} & {\color{gray} \cancel{57}} & {\color{gray} \cancel{58}} & 59 & {\color{gray} \cancel{60}} & 61 \\
# {\color{gray} \cancel{62}} & {\color{gray} \cancel{63}} & {\color{gray} \cancel{64}} & {\color{gray} \cancel{65}} & {\color{gray} \cancel{66}} & 67 & {\color{gray} \cancel{68}} & {\color{gray} \cancel{69}} & {\color{gray} \cancel{70}} & 71 \\
# {\color{gray} \cancel{72}} & 73 & {\color{gray} \cancel{74}} & {\color{gray} \cancel{75}} & {\color{gray} \cancel{76}} & {\color{gray} \cancel{77}} & {\color{gray} \cancel{78}} & 79 & {\color{gray} \cancel{80}} & {\color{gray} \cancel{81}} \\
# {\color{gray} \cancel{82}} & 83 & {\color{gray} \cancel{84}} & {\color{gray} \cancel{85}} & {\color{gray} \cancel{86}} & {\color{gray} \cancel{87}} & {\color{gray} \cancel{88}} & 89 & {\color{gray} \cancel{90}} & {\color{gray} \cancel{91}} \\
# {\color{gray} \cancel{92}} & {\color{gray} \cancel{93}} & {\color{gray} \cancel{94}} & {\color{gray} \cancel{95}} & {\color{gray} \cancel{96}} & 97 & {\color{gray} \cancel{98}} & {\color{gray} \cancel{99}} & {\color{gray} \cancel{100}} & 101
# \end{array}
# ```

# %% [markdown]
# But now, the next non-crossed out number is $11$ which is larger than $\sqrt{101}$ and we can stop!  *Every* non-crossed out element is actually prime:
#
# ```{math}
# \begin{array}{rrrrrrrrrr}
# {\color{red} 2} & {\color{red}3 } & {\color{gray} \cancel{4}} & {\color{red} 5} & {\color{gray} \cancel{6}} & {\color{red} 7} & {\color{gray} \cancel{8}} & {\color{gray} \cancel{9}} & {\color{gray} \cancel{10}} & {\color{red} 11} \\
# {\color{gray} \cancel{12}} & {\color{red} 13} & {\color{gray} \cancel{14}} & {\color{gray} \cancel{15}} & {\color{gray} \cancel{16}} & {\color{red} 17} & {\color{gray} \cancel{18}} & {\color{red} 19} & {\color{gray} \cancel{20}} & {\color{gray} \cancel{21}} \\
# {\color{gray} \cancel{22}} & {\color{red} 23} & {\color{gray} \cancel{24}} & {\color{gray} \cancel{25}} & {\color{gray} \cancel{26}} & {\color{gray} \cancel{27}} & {\color{gray} \cancel{28}} & {\color{red} 29} & {\color{gray} \cancel{30}} & {\color{red} 31} \\
# {\color{gray} \cancel{32}} & {\color{gray} \cancel{33}} & {\color{gray} \cancel{34}} & {\color{gray} \cancel{35}} & {\color{gray} \cancel{36}} & {\color{red} 37} & {\color{gray} \cancel{38}} & {\color{gray} \cancel{39}} & {\color{gray} \cancel{40}} & {\color{red} 41} \\
# {\color{gray} \cancel{42}} & {\color{red} 43} & {\color{gray} \cancel{44}} & {\color{gray} \cancel{45}} & {\color{gray} \cancel{46}} & {\color{red} 47} & {\color{gray} \cancel{48}} & {\color{gray} \cancel{49}} & {\color{gray} \cancel{50}} & {\color{gray} \cancel{51}} \\
# {\color{gray} \cancel{52}} & {\color{red} 53} & {\color{gray} \cancel{54}} & {\color{gray} \cancel{55}} & {\color{gray} \cancel{56}} & {\color{gray} \cancel{57}} & {\color{gray} \cancel{58}} & {\color{red} 59} & {\color{gray} \cancel{60}} & {\color{red} 61} \\
# {\color{gray} \cancel{62}} & {\color{gray} \cancel{63}} & {\color{gray} \cancel{64}} & {\color{gray} \cancel{65}} & {\color{gray} \cancel{66}} & {\color{red} 67} & {\color{gray} \cancel{68}} & {\color{gray} \cancel{69}} & {\color{gray} \cancel{70}} & {\color{red} 71} \\
# {\color{gray} \cancel{72}} & {\color{red} 73} & {\color{gray} \cancel{74}} & {\color{gray} \cancel{75}} & {\color{gray} \cancel{76}} & {\color{gray} \cancel{77}} & {\color{gray} \cancel{78}} & {\color{red} 79} & {\color{gray} \cancel{80}} & {\color{gray} \cancel{81}} \\
# {\color{gray} \cancel{82}} & {\color{red} 83} & {\color{gray} \cancel{84}} & {\color{gray} \cancel{85}} & {\color{gray} \cancel{86}} & {\color{gray} \cancel{87}} & {\color{gray} \cancel{88}} & {\color{red} 89} & {\color{gray} \cancel{90}} & {\color{gray} \cancel{91}} \\
# {\color{gray} \cancel{92}} & {\color{gray} \cancel{93}} & {\color{gray} \cancel{94}} & {\color{gray} \cancel{95}} & {\color{gray} \cancel{96}} & {\color{red} 97} & {\color{gray} \cancel{98}} & {\color{gray} \cancel{99}} & {\color{gray} \cancel{100}} & {\color{red} 101}
# \end{array}
# ```

# %% [markdown]
# So, the list of primes less than or equal to $101$ is: $2$, $3$, $5$, $7$, $11$, $13$, $17$, ...  Let's check with Sage's `prime_range`:

# %%
prime_range(102)

# %% [markdown]
# Note that our interest was only whether or not $101$ was prime, we could stop any point if it was crossed out.

# %% [markdown]
# Now, let's implement it:

# %%
def prime_sieve(maxn):
    """
    Given an integer maxn, returns a list of all primes up to (and possibly including) maxn.

    INPUT:
    maxn: the uppder bound for our list of primes.

    OUTPUT:
    A list of all primes up to (and possibly including) maxn.
    """
    # dictionary for primes: key = number, value: is it prime?
    primes = {i: True for i in range(2, maxn + 1)}
    last_to_try = floor(sqrt(maxn))  # we can stop here
    p = 2  # we start with 2
    while p <= last_to_try:
        # mark multiples of p as not prime
        for j in range(2 * p, maxn + 1, p):
            primes[j] = False
        # move on to the next prime
        p += 1
        while (p <= last_to_try) and (not primes[p]):
            p += 1
    return [x for x in primes if primes[x]]

# %% [markdown]
# Let's test it:

# %%
prime_sieve(101) == prime_range(102)

# %% [markdown]
# To be sure, let's test for a large integer:

# %%
prime_sieve(10^6) == prime_range(10^6 + 1)

# %% [markdown]
# Let's see how efficient it is:

# %%
# %%time
n = 3*10^7 + 1
n in prime_sieve(n)

# %% [markdown]
# A lot slower, but gives a list of primes.  Let's see how long our previous method would take to give the same list:

# %%
# %%time
n = 10^5
test_1 = [p for p in range(2, n + 1) if prime_test_2(p)]

# %%
# %%time
test_2 = prime_sieve(n)

# %%
test_1 == test_2

# %% [markdown]
# ## The Greatest Common Divisor

# %% [markdown]
# Given two integers $a$, $b$, the *greatest common divisor (GCD)* of $a$ and $b$, denoted by either $\gcd(a, b)$ or simply $(a, b)$ (when it is clear that is not simply an ordered pair) is the greatest positive integer that divides both $a$ and $b$.
#
# :::{prf:property} Properties of the GCD
# :label: pr-gcd
#
#
# 1) Since $1$ divides any integer $a$ (since $a = 1 \cdot a$, and $a$ is an integer), we have that $\boxed{\gcd(1, a) = 1}$ for any integer $a$.
# 2) Any integer $a$ divides $0$, since $0 = a \cdot 0$ (and $0$ is an integer).  So, if $a$ is a **positive** integer, then $\boxed{\gcd(a, 0)=a}$.
# 3) Signs do not affect divisibility: if $a \mid b$, then $-a \mid b$, $a \mid -b$ and $-a \mid -b$, and so $\boxed{\gcd(a, b) = \gcd(|a|, |b|)}$.
# 4) If $a$ and $b$ are **positive**, and $a \mid b$, then $\gcd(a, b) = a$.
# :::
#
# :::{prf:definition} Relatively Prime
# :nonumber:
#
# We say that two integers are *relatively prime* if their GCD is $1$.
# :::
#
# <br >
#
# A first naive method to compute the GCD is to find the divisors of both numbers and take the largest common one.  For instance, say we want $\gcd(12, 15)$.  We have
#
# ```{math}
# \begin{align*}
# \text{positive divisors of $12$} &= \{1, 2, 3, 4, 6, 12\},\\
# \text{positive divisors of $15$} &= \{1, 3, 5, 15\},\\
# \text{common divisors} &= \{1, \boxed{3}\}
# \end{align*}
# ```
#
#
# But the process of finding all these divisors might take a while.  Here is a second (still naive) approach.  We can simply start testing:
#
# 1) Does $1$ divide both $12$ and $15$?  *Yes!*  So, so far the GCD is $1$.
# 2) Does $2$ divide both $12$ and $15$?  No.  So, so far the GCD is still $1$.
# 3) Does $3$ divide both $12$ and $15$?  *Yes!*  So, so far the GCD is $3$.
# 4) Does $4$ divide both $12$ and $15$?  No.  So, so far the GCD is still $3$.
#
# When do we stop?  We stop when we reach the smallest of the two numbers, namely, $12$.  The last common divisor will be the GCD.  (In this case, it is $3$.)
#
# But we can greatly improve it! Since we are interested in the *largest* common divisor, we start with the largest it could possibly be, namely, the smallest of the two numbers ($12$ in our case).  So, we do:
#
# 1) Does $12$ divide both $12$ and $15$?  No, so we go to the next number.
# 2) Does $11$ divide both $12$ and $15$?  No, so we go to the next number.
# 3) Does $10$ divide both $12$ and $15$?  No, so we go to the next number.
#
# When do we stop?  When we find a common divisor!  This will automatically be the GCD.  So, in this case, we perform $18$ divisions instead of $22$.  In some other cases, we can perform a single one.  For instance, in computing $\gcd(1{,}000{,}000, 2{,}000{,}000)$ we perform a single division, instead of $999{,}999$!

# %% [markdown]
# But, there is a much more efficient way of doing it!

# %% [markdown]
# ## The Euclidean Algorithm

# %% [markdown]
# We have the following:
#
# **Theorem:** We have that $d$ divides both $a$ and $b$ *if, and only if*, $d$ also divides both $a$ and $b - a$.  This implies that
# ```{math}
# \{\text{common divisors of $a$ and $b$}\} = \{\text{common divisors of $a$ and $b - a$}\},
# ```
# and hence $\boxed{\gcd(a, b) = \gcd(a, b-a)}$.
#
# <br>
#
# Here is a quick idea of why that is true: say $d \mid a, b$.  Then $a/d$ and $b/d$ are integers.  So,
#
# ```{math}
# \frac{b - a}{d} = \frac{b}{d} - \frac{a}{d},
# ```
#
# a difference of integers, and so an integers as well, and hence $d \mid (b -a)$.
#
# And, if $d \mid a, (b-a)$, then $a/d$ and $(b-a)/d$ are both integers, and thus
#
# ```{math}
# \frac{b}{d} = \frac{(b-a) + a}{d} = \frac{b-a}{d} + \frac{a}{d},
# ```
#
# a sum of integers, and so an integer too, and therefore $d \mid b$.

# %% [markdown]
# If you are not convinced by the argument above, let's do some tests using random numbers and Sage's `gcd`:

# %%
number_of_tests = 100
maxn = 1_000_000

for i in range(number_of_tests):
    # a, b as two random integers from 1 to maxn
    a = randint(1, maxn)
    b = randint(1, maxn)
    if gcd(a, b) != gcd(a, b-a):
        print(f"Failed for {a = } and {b = }!")
        break  # get out of the loop!
else:  # no break
    print("It worked for all tests!")

# %% [markdown]
# But how does that help?  Say that we need to compute the $\gcd(12, 15)$ again.  Well, we have
# ```{math}
# \gcd(12, 15) = \gcd(12, 15-12) = \gcd(12, 3).
# ```
# Here, since we know $3 \mid 12$, we could already see that $\gcd(12, 15) = \gcd(12, 3) = 3$!  But, let's pretend we did not notice that.  *We can repeat the idea!*  Replace the larger number by its difference with the smaller.
#
# So, we can do:
# ```{math}
# \begin{align*}
# \gcd(12, 15) &= \gcd(12, 3)\\
# &= \gcd(9, 3) \\
# &= \gcd(6, 3)\\
# &= \gcd(3, 3)\\
# &= \gcd(0, 3) = \boxed{3}.
# \end{align*}
# ```
#
# This last line follows from $\gcd(a, 0) = a$ when $a>0$.  *We did not perform a single division*, only subtractions.

# %% [markdown]
# Let's do a larger example, say $\gcd(159, 48)$:
# ```{math}
# \begin{align*}
# \gcd(159, 48) & = \gcd(159 - 48, 48) = \gcd(111, 48) \\
# &= \gcd(111 - 48, 48) = \gcd(63, 48) \\
# &= \gcd(63 - 48, 48) = \gcd(15, 48) \\
# &= \gcd(15, 48 - 15) = \gcd(15, 33) \\
# &= \gcd(15, 33 - 15) = \gcd(15, 18) \\
# &= \gcd(15, 18 - 15) = \gcd(15, 3) \\
# &= \gcd(12, 3) \\
# &= \gcd(9, 3) \\
# &= \gcd(6, 3) \\
# &= \gcd(3, 3) \\
# &= \gcd(0, 3) = \boxed{3}.
# \end{align*}
# ```

# %% [markdown]
# This already works well, but note that by repeating the idea:
# ```{math}
# \gcd(a, b) = \gcd(a, b-a) = \gcd(a, b - 2a) = \gcd(a, b - 3a) = \cdots
# ```
# Hence, when we had $\gcd(12, 3)$ we could subract $4 \cdot 3 = 12$ form $12$ to get $\gcd(0, 3) = 3$ above.
#
# More generally, if we do the long division $a = bq + r$ (with $0 \leq r \leq b$), then
# ```{math}
# \gcd(a, b) = \gcd(a - qb, b) = \gcd(r, b)  \quad \text{and $r < b$}.
# ```

# %% [markdown]
# Let's apply this same idea to the steps above:
#
# ```{math}
# \begin{align*}
# \gcd(159, 48) & = \gcd(159 - 3 \cdot 48, 48) = \gcd(15, 48) && \text{[since $159 = 48 \cdot 3 + 15$]}\\
# &= \gcd(15, 48 - 3 \cdot 15) = \gcd(15, 3) && \text{[since $48 = 15 \cdot 3 + 3$]}\\
# &= \gcd(15 - 3 \cdot 5, 3) = \gcd(0, 3) = \boxed{3}.   && \text{[since $15 = 3 \cdot 5 + 0$]}
# \end{align*}
# ```

# %% [markdown]
# This is more efficient!  This process above it called the **Euclidean Algorithm**.  Here are the steps.
#
# ```{prf:algorithm} Euclidean Algorithm
# :label: alg-ea
#
# To compute $\gcd(a, b)$:
#
# 1) Perform the long division of the larger by the smaller and replace the larger by the remainder.  (This remainder now is smaller than the previous smallest element!)
# 2) Repeat until you get a remainder of $0$.
# 3) The GCD is the last divisor (meaning, the last non-zero smallest element).
# ```
#
# So, we have a series of long divisions, until we get a remainder of $0$:
# ```{math}
# \begin{align*}
# \gcd(a,b): && a &= b \cdot q_1 + r_1 && (0< r_1 < b) \\
# \gcd(b,r_1): && b &= r_1 \cdot q_2 + r_2 && (0< r_2 < r_1) \\
# \gcd(r_1,r_2): && r_1 &= r_2 \cdot q_3 + r_3 && (0 < r_3 < r_2) \\
# \gcd(r_3,r_3): && r_2 &= r_3 \cdot q_4 + r_4 && (0 < r_4 < r_3) \\
#  && &\;\; \vdots \\
# \gcd(r_{n-2},r_{n-1}): && r_{n-2} &= r_{n-1} \cdot q_n + \boxed{r_n} \leftarrow \text{GCD} && (0 < r_n < r_2) \\
# \gcd(r_{n-1}, r_n): &&  r_{n-1} &= r_n \cdot q_{n+1} + {\color{red} 0}
# \end{align*}
# ```

# %% [markdown]
# So, let's do another example: $\gcd(1{,}027, 349)$:

# %%
1027 % 349  # remember that '%' gives the remainder

# %% [markdown]
# So, the remainder is $329$.  The next divide the smaller number ($349$) by this remainder:

# %%
349 % 329

# %% [markdown]
# Now, repeat: get the remainder of the smaller of the two numbers by the new remainder:

# %%
329 % 20

# %% [markdown]
# And keep going until we get a remainder equal to $0$:

# %%
20 % 9

# %%
9 % 2

# %%
2 % 1

# %% [markdown]
# The last divisor (or the last non-zero remainder) is the GCD, so $\gcd(1{,}027, 349) = 1$.  We can check with Sage's own `gcd` function:

# %%
gcd(1027, 349)

# %% [markdown]
# :::{admonition} Homework
# :class: note
#
# In your homework you will automate this process, i.e., implement the Euclidean Algorithm as a function.
# :::

# %% [markdown]
# ## How Fast Is the Euclidean Algorithm

# %% [markdown]
# Is the Euclidean Algorithm efficient?  It is clear is much better than our naive approaches above.  But how many long divisions do we need to perform?  Let's think of the worst case scenario.  The faster the numbers get smaller, the better.
#
# With some (relatively simple math), one can prove that if the  sequence of remainder is $r_1$, $r_2$, $r_3$, ..., then
# ```{math}
# r_{i+2} < \frac{r_i}{2}, \quad \text{for $i=0,1,2, \ldots$}
# ```
# This means that after two long divisions, the remainder is *at most* half the size.
#
# Hence, we get:
#
# ```{math}
# \begin{align*}
# r_2 &< r_0/2\\
# r_4 &< r_2/2  < r_0/4\\
# r_6 &< r_4/2 < r_2/4 < r_0/8 \\
# r_8 &< r_6/2 < r_4/4 < r_2/ 8 < r_0 / 16\\
# & \;\; \vdots
# \end{align*}
# ```
#
# This means that $r_{2k} < \dfrac{r_0}{2^k}$.  Since $2^k$ grows very fast as $k$ increases, $r_{2k}$ gets small very fast.  With a little more math, one can show that
# ```{math}
# \text{number of long divisions} < 2 \log_2(b) + 2,
# ```
# where, again, $b$ is the smallest between $a$ and $b$.

# %% [markdown]
# To illustrate that this is not much at all, if $b = 1{,}000{,}000$, we need to perform at most $2 \log_2(1{,}000{,}000) + 2$ long divisions:

# %%
2 * floor(log(10^6, 2)) + 2

# %% [markdown]
# So, at most $40$!  And, most of the time, it will be considerably less!  To illustrate, using Sage's own function, which does use the Euclidean Algorithm:

# %%
# %%time
gcd(76497326597236475295264957264957246971641974697326592743619743, 89435098282058743250982430584059850982437095214350820)

# %% [markdown]
# ## The Extended Euclidean Algorithm

# %% [markdown]
# Here is a result that will be quite important to us:
#
# :::{prf:lemma} Bezout's Lemma
# :label: lm-bezout
#
#
# Let $a$ and $b$ be positive integers.  Then, there are integers $u$ and $v$ (maybe negative), such that:
# ```{math}
# \gcd(a, b) = au + bv.
# ```
# :::
#
#
# Let's illustrate it with same examples.
#
# We had the $\gcd(12, 15) = 3$, and
# ```{math}
# 3 = 12 \cdot (-1) + 15 \cdot 1  \quad \text{so, $u=-1$ and $v=1$.}
# ```
#
# We had the $\gcd(159, 48) = 3$, and
# ```{math}
# 3 = 159 \cdot (-3) + 48 \cdot 10  \quad \text{so, $u=-3$ and $v=10$.}
# ```

# %%
159 * (-3) + 48 * 10

# %% [markdown]
# We have that $\gcd(1{,}027, 349) = 1$, and
# ```{math}
# 1  = 1{,}027 \cdot 157 + 349 \cdot (-462), \quad \text{so, $u = 157$ and $v=-462$.}
# ```

# %%
1027 * 157 + 349 * (-462)

# %% [markdown]
# :::{note}
#
#
# Note that these $u$ and $v$ are not unique!
# :::
#
# For example:
# ```{math}
# \begin{align*}
# 3 &= 12 \cdot (-1) + 15 \cdot 1 && \text{($u=-1$, $v=1$)} \\
# &= 12 \cdot 4 + 15 \cdot (-3) && \text{($u=4$, $v=-3$)} \\
# &= 12 \cdot -6 + 15 \cdot 5 && \text{($u=-6$, $v=5$)}.
# \end{align*}
# ```
#
# In fact, there are *infinitely many* possibilities: let $t$ be any integer.  Then
# ```{math}
# 12 \cdot (-1 + 5t) + 15 \cdot (1 - 4t) = -12 + 60t + 15 - 60t = 15 - 12 = 3.
# ```
#
# So,
# ```{math}
# \begin{align*}
# u &= -1 + 5t, \\
# v &= 1 + 4t,
# \end{align*}
# ```
# work (for $a=15$ and $b=12$) for *any* integer $t$!

# %% [markdown]
# But let's now focus on how to find *one* possible pair.

# %% [markdown]
# Suppose we want to find (some pair of) integers $u$ and $v$ such that
# ```{math}
# \gcd(159, 48) = 159 \cdot {\color{red} u} + 48 \cdot {\color{blue} v}.
# ```
# We will not even assume that we know $\gcd(159, 48)$: we will compute it *at the same time* we find $u$ and $v$.
#
# Here is how we can do it: start with the trivial equalities:

# %% [markdown]
# ```{math}
# \begin{array}{rcrclcrcl}
# 159 & = & 159 & \cdot & {\color{red} 1} & + & 48 & \cdot & {\color{blue} 0} \\
# 48 & = & 159 & \cdot & {\color{red} 0} & + & 48 & \cdot & {\color{blue} 1}
# \end{array}
# ```

# %% [markdown]
# Now, we will perform the Euclidean Algorithm described above: we do the long division $149 = 58 \cdot 3 + 15$.  Then we subtract $149 - 3 \cdot 48$, but we will do it with *the whole equations* above:

# %% [markdown]
# ```{math}
# \begin{align*}
# 15 & = 159 - 3 \cdot 48\\
# &= (159 \cdot 1 + 48 \cdot 0) - 3 \cdot (159 \cdot 0 + 48 \cdot 1) \\
# &=(159 \cdot 1 + 48 \cdot 0) - (3 \cdot 159 \cdot 0 +  3 \cdot 48 \cdot 1) \\
# &=(159 \cdot 1 + 48 \cdot 0) - (159 \cdot (3 \cdot 0) + 48 \cdot (3 \cdot 1)) \\
# &= 159 \cdot (1 - 3 \cdot 0) + 48 \cdot (0 - 3 \cdot 1) \\
# & 159 \cdot \boxed{1} + 48 \cdot \boxed{-3}
# \end{align*}
# ```

# %% [markdown]
# The key idea is that when we multiply $149 \cdot 0 +  58 \cdot 1$ by $3$, we simply multiply the $0$ and $1$ by $3$ (by the *distributive*, *commutative*, and *associative* laws).  Let's write this more directly as:
#
# ```{math}
# \begin{array}{rcrclcrcl}
# 159 & = & 159 & \cdot & {\color{red} 1} & + & 48 & \cdot & {\color{blue} 0} \\
# (-3) \cdot 58 & = & 159 & \cdot & {\color{red} (-3) \cdot 0} & + & 48 & \cdot & {\color{blue} (-3) \cdot 1} \\[1ex]
# \hline
# 15 & = & 159 &\cdot & {\color{red} 1} & +  & 48 & \cdot & {\color{blue} (-3)}
# \end{array}
# ```
#
# So, now we have the two equations:
#
# ```{math}
# \begin{array}{rcrclcrcl}
# 48 & = & 159 & \cdot & {\color{red} 0} & + & 48 & \cdot & {\color{blue} 1} \\[1ex]
# 15 & = & 159 &\cdot & {\color{red} 1} & +  & 48 & \cdot & {\color{blue} (-3)}
# \end{array}
# ```
#
# And we can repeat, as with the Euclidean Algorithm: we divide $48 = 15 \cdot 3 + 3$:
#
# ```{math}
# \begin{array}{rcrclcrcl}
# 48 & = & 159 & \cdot & {\color{red} 0} & + & 48 & \cdot & {\color{blue} 1} \\
# (-3) \cdot 15 & = & 159 &\cdot & {\color{red} (-3) \cdot 1} & +  & 48 & \cdot & {\color{blue} (-3) \cdot (-3)} \\[1ex]
# \hline
# 3 & = & 159 &\cdot & {\color{red} (-3)} & +  & 48 & \cdot & {\color{blue} 10}
# \end{array}
# ```
#
# So, now our two equations are:
#
# ```{math}
# \begin{array}{rcrclcrcl}
# 15 & = & 159 &\cdot & {\color{red} 1} & +  & 48 & \cdot & {\color{blue} (-3)} \\
# 3 & = & 159 &\cdot & {\color{red} (-3)} & +  & 48 & \cdot & {\color{blue} 10}
# \end{array}
# ```
#
# The next step is $15 = 3 \cdot 5 + 0$, so we know that $\gcd(149, 49) = 3$ and our last equation gives us $u$ and $v$:
#
# ```{math}
# \underbrace{3}_{=\gcd(159, 48)} = 159 \cdot  {\color{red} \underbrace{(-3)}_{=u}} +  48 \cdot {\color{blue} \underbrace{10}_{=v}}.
# ```
#
# These are the same $u$ and $v$ we've checked above!

# %% [markdown]
# Let's do this now with the help of Sage for our computations.  Let's try to find $u$ and $v$ so that $\gcd(1{,}027, 349) = 1{,}027 \cdot u + 349 \cdot v$.
#
# Now, we always deal with two equations, so we will use `x` and `y` for the numbers on the left side, and `u1` and `v1` for the first equation and `u2` and `v2` for the second.  When we start, we always have `u1 = 1` and `v1 = 0` and `u2 = 0` and `v2 = 1`:
#
# ```{math}
# \begin{array}{rcrclcrcl}
# \underbrace{1{,}037}_{x} & = & 1{,}037 & \cdot & {\color{red} \underbrace{1}_{u_1}} & + & 349 & \cdot & {\color{blue} \underbrace{0}_{v_1}} \\
# \underbrace{349}_{y} & = & 1{,}037 & \cdot & {\color{red} \underbrace{0}_{u_2}} & + & 349 & \cdot & {\color{blue} \underbrace{1}_{v_2}}
# \end{array}
# ```

# %%
a, b = 1037, 349

# initial values
x, y = a, b
u1, v1 = 1, 0
u2, v2 = 0, 1

# %% [markdown]
# Now, long division:

# %%
q, r = divmod(x, y)  # quotient and remainder

# %% [markdown]
# Now, the "new" `x` is the old `y` and the new `y` is the remainder `r`:

# %%
x, y = y, r
x, y

# %% [markdown]
# :::{important}
#
# Here is very important that we use the "double assignment", or we would need an intermediate variable!
# :::

# %% [markdown]
# We also need the new `u`'s' and `v`'s.  But the new `u1` and `v1` are just the old `u2` and `v2` and the new `u2` and `v2` are simply the `u1 - q * u_2` and `v1 - q * v_2`:

# %%
u1, v1, u2, v2 = u2, v2, (u1 - q * u2), (v1 - q * v2)
u1, v1, u2, v2

# %% [markdown]
# (Again, it is *very important* to keep this as a multiple assignment!)
#
# So, we have:
#
# ```{math}
# \begin{array}{rcrclcrcl}
# \underbrace{349}_{x} & = & 1{,}037 & \cdot & {\color{red} \underbrace{0}_{u_1}} & + & 349 & \cdot & {\color{blue} \underbrace{1}_{v_1}} \\
# \underbrace{339}_y & = & 1{,}037 & \cdot & {\color{red} \underbrace{1}_{u_2}} & + & 349 & \cdot & {\color{blue} \underbrace{(-2)}_{v_2}}
# \end{array}
# ```

# %% [markdown]
# Now, we repeat until we get a remainder of zero:

# %%
q, r = divmod(x, y)
x, y = y, r
u1, v1, u2, v2 = u2, v2, (u1 - q * u2), (v1 - q * v2)
print(f"{r = }, {x = }, {u1 = }, {v1 = }, {y = }, {u2 = }, {v2 = }")

# %% [markdown]
# So:
#
# ```{math}
# \begin{array}{rcrclcrcl}
# \underbrace{339}_x & = & 1{,}037 & \cdot & {\color{red} \underbrace{1}_{u_1}} & + & 349 & \cdot & {\color{blue} \underbrace{(-2)}_{v_1}} \\
# \underbrace{10}_y & = & 1{,}037 & \cdot & {\color{red} \underbrace{(-1)}_{u_2}} & + & 349 & \cdot & {\color{blue} \underbrace{3}_{v_2}}
# \end{array}
# ```

# %% [markdown]
# Repeat, since the remainder was not zero:

# %%
q, r = divmod(x, y)
x, y = y, r
u1, v1, u2, v2 = u2, v2, (u1 - q * u2), (v1 - q * v2)
print(f"{r = }, {x = }, {u1 = }, {v1 = }, {y = }, {u2 = }, {v2 = }")

# %% [markdown]
# Now:
#
# ```{math}
# \begin{array}{rcrclcrcl}
# \underbrace{10}_x & = & 1{,}037 & \cdot & {\color{red} \underbrace{(-1)}_{u_1}} & + & 349 & \cdot & {\color{blue} \underbrace{3}_{v_1}} \\
# \underbrace{9}_y & = & 1{,}037 & \cdot & {\color{red} \underbrace{34}_{u_2}} & + & 349 & \cdot & {\color{blue} \underbrace{(-101)}_{v_2}}
# \end{array}
# ```

# %% [markdown]
# Repeat, since the remainder was not zero:

# %%
q, r = divmod(x, y)
x, y = y, r
u1, v1, u2, v2 = u2, v2, (u1 - q * u2), (v1 - q * v2)
print(f"{r = }, {x = }, {u1 = }, {v1 = }, {y = }, {u2 = }, {v2 = }")

# %% [markdown]
# We have:
#
# ```{math}
# \begin{array}{rcrclcrcl}
# \underbrace{9}_x & = & 1{,}037 & \cdot & {\color{red} \underbrace{34}_{u_1}} & + & 349 & \cdot & {\color{blue} \underbrace{(-101)}_{v_1}} \\
# \underbrace{1}_y & = & 1{,}037 & \cdot & {\color{red} \underbrace{(-35)}_{u_1}} & + & 349 & \cdot & {\color{blue} \underbrace{104}_{v_1}}
# \end{array}
# ```

# %% [markdown]
# Repeat:

# %%
q, r = divmod(x, y)
x, y = y, r
u1, v1, u2, v2 = u2, v2, (u1 - q * u2), (v1 - q * v2)
print(f"{r = }, {x = }, {u1 = }, {v1 = }, {y = }, {u2 = }, {v2 = }")

# %% [markdown]
# Ah-ha!  Now the remainder is zero and the $\gcd(1{,}037, 349)$ is `x` and $u$ and $v$ are `u1` and `v1` respectively:

# %%
x, u1, v1

# %% [markdown]
# Let's check:

# %%
1 == 1037 * (-35) + 349 * 104

# %% [markdown]
# Success!

# %% [markdown]
# There is one small improvement we can make, to avoid some unnecessary computations.  (This will only make any noticeable difference for *very* large numbers, but we will deal with very large numbers soon, so we might as well think about it.)
#
# We can skip computing the `v`'s and only focus on the `u`'s.  At the end, we can compute `v` from what we have.
#
# Here is how it would go:

# %%
a, b = 1037, 349

# initial values
x, y = a, b
u1 = 1
u2 = 0

q, r = divmod(x, y)
x, y = y, r
u1, u2 = u2, (u1 - q * u2)
print(f"{r = }, {x = }, {u1 = }, {y = }, {u2 = }")

# %% [markdown]
# Remainder is not zero, so continue:

# %%
q, r = divmod(x, y)
x, y = y, r
u1, u2 = u2, (u1 - q * u2)
print(f"{r = }, {x = }, {u1 = }, {y = }, {u2 = }")

# %% [markdown]
# Repeat:

# %%
q, r = divmod(x, y)
x, y = y, r
u1, u2 = u2, (u1 - q * u2)
print(f"{r = }, {x = }, {u1 = }, {y = }, {u2 = }")

# %% [markdown]
# Repeat:

# %%
q, r = divmod(x, y)
x, y = y, r
u1, u2 = u2, (u1 - q * u2)
print(f"{r = }, {x = }, {u1 = }, {y = }, {u2 = }")

# %% [markdown]
# Repeat:

# %%
q, r = divmod(x, y)
x, y = y, r
u1, u2 = u2, (u1 - q * u2)
print(f"{r = }, {x = }, {u1 = }, {y = }, {u2 = }")

# %% [markdown]
# Remainder is $0$, so $\gcd(1{,}037, 349) = 1$ and $u = -35$.  But what is $v$?  Well
#
# ```{math}
# \gcd(1{,}037, 349) = 1{,}037 u + 349 v,
# ```
#
# so, solving for $v$:
#
# ```{math}
# v = \frac{\gcd(1{,}037, 349) - 1{,}037 u }{349}.
# ```
#
# So, we get:

# %%
v = (x - a * u1) // b
v

# %% [markdown]
# This indeed gives us the same $u$ and $v$ as above!

# %% [markdown]
# ### Summary (Algorithm)

# %% [markdown]
# Here is the actual extended Euclidean Algorithm:
#
# :::{prf:algorithm} Extended Euclidean Algorithm
# :label: al-eea
#
#
# To compute the GCD of `a` and `b` and `u` and `v` such that `gcd(a, b) = a * u + b * v`:
#
# 1) Initialize
#    ```python
#     x, y, u1, u2 = a, b, 1, 0
#     r = x % y
#    ```
# 2) While `r` is not zero, repeat the steps
#    ```python
#     q, r = divmod(x, y)
#     x, y, u1, u2  = y, r, u2, (u1 - q * u2)
#    ```
# 3) When `r` is zero, we have that:
#     * `x` is the GCD of `a` and `b`;
#     * `u1` is the required `u`;
#     * `(x - a * u1) // b` is the required `v`.
# :::
#
# :::{admonition} Homework
# :class: note
#
# You will implement this algorithm in your homework.
# :::

# %% [markdown]
# Of course, Sage has its own function for this, `xgcd`:

# %%
xgcd(1037, 349)

# %% [markdown]
# This tells us that the GCD is $1$, $u=-35$, and $v=104$, the same we've found above.

# %% [markdown]
# ## Other Solutions

# %% [markdown]
# As we've seen above, the $u$ and $v$ from Bezout's Lemma are not unique.  But, we actually know how to find *all* solutions!
#
# :::{prf:theorem}
# :label: pr-bezout_mult_sol
#
#
# Let $a$ and $b$ be positive integers, $d$ be their GCD, and $u_0$ and $v_0$ be *some* pair of integers such that
# ```{math}
# d = a u_0 + b v_0.
# ```
# Then, $u$ and $v$ are integers such that
# ```{math}
# d = au + bv
# ```
# if, and only if,
# ```{math}
# \begin{align*}
# u &= u_0 + k \cdot \frac{b}{d} \\
# v &= v_0 - k \cdot \frac{a}{d}
# \end{align*}
# ```
# for some integer $k$.
# :::
#
# :::{note}
#
# 1) The same integer $k$ must be use for both $u$ and $v$.
# 2) Note that $b/d$ and $a/d$ are both *integers* since $d$ is a common divisor.
# 3) Note that the signs are different for $u$ and $v$.
# :::

# %% [markdown]
# Let's understand what this is saying.  Remember that we've found:
#
# ```{math}
# \underbrace{3}_{\gcd(159, 48)} = \underbrace{159}_a \cdot  {\color{red} \underbrace{(-3)}_{u_0}} +  \underbrace{48}_b \cdot {\color{blue} \underbrace{10}_{v_0}}.
# ```
#
#
# According to the theorem we can produce infinitely many other solutions.  For instance, using $k=1$, we get
# ```{math}
# \begin{align*}
# u &= -3 + 1 \cdot \frac{48}{3} = 13 \\
# v &= 10 - 1 \cdot \frac{159}{3} = -43.
# \end{align*}
# ```
#
# Let's check that they also work:

# %%
159 * 13 + 48 * (-43)

# %% [markdown]
# Let's make Sage check for us:

# %%
bound = 100

a, b, u0, v0 = 159, 48, -3, 10
d = gcd(a, b)

for k in range(-bound, bound + 1):
    u = u0 + k * (b // d)
    v = v0 - k * (a // d)
    if a * u + b * v != d:  # fail!
        print(f"Formula fails for {k = }.")
        break
else:  # no break
    print("It seems to work!")

# %% [markdown]
# It is actually easy to see why.  If
# ```{math}
# a u_0 + b v_0 = d,
# ```
# and
# ```{math}
# \begin{align*}
# u &= u_0 + k \cdot \frac{b}{d}, \\
# v &= v_0 - k \cdot \frac{a}{d},
# \end{align*}
# ```
# then
# ```{math}
# \begin{align*}
# a u + b v &= a \left(u_0 +  k \cdot \frac{b}{d}\right) + b \left( v_0 - k \cdot \frac{a}{d}\right) \\[1ex]
# &= a u_0 +  ak \cdot \frac{b}{d} + bv_0 - bk \cdot \frac{a}{d} \\[1ex]
# &= \underbrace{\left(au_0 + bv_0 \right)}_{d} + k \underbrace{\left( \frac{ab}{d} - \frac{ba}{d} \right)}_{0} \\[1ex]
# &= d + k \cdot 0 = d.
# \end{align*}
# ```

# %% [markdown]
# On the other hand, the theorems tells us more!  We've just checked that if $u_0$ and $v_0$ give us the GCD, then so do
#
# ```{math}
# \begin{align*}
# u &= u_0 + k \cdot \frac{b}{d} \\
# v &= v_0 - k \cdot \frac{a}{d}
# \end{align*}
# ```
#
# But the theorem tells us that those are *all* the solutions, i.e., every single solution can be obtained by choosing some integer $k$ for the formula.
#
# It is not too hard the check that this is true with some algebra, but let's just do a computer check instead.  Note that if $au + bv = d$ with $u$ and $v$ integers, then
# ```{math}
# v = \frac{d - au}{b} \in \Z,
# ```
# so $b \mid (d - au)$.  So, to search for solutions, we try integers $u$ in some range, and if $b \mid (d-au)$, then the formula above would gives us $v$.

# %%
max_number = 10^4  # max size of a and b
repetitions = 100  # number of tries
max_k = 30  # maximum k from the formula; go from -max_k to max_k

for _ in range(repetitions):
    # random a and b in the range
    a = randint(2, max_number)
    b = randint(2, max_number)

    # get GCD and initial u and v
    d, u0, v0 = xgcd(a, b)

    # solutions from the formula
    formula_solutions = {(u0 + k * (b // d), v0 - k * (a // d)) for k in range(-max_k, max_k + 1)}

    # initialize found solutions as empty set
    found_solutions = set()

    # find solutions with u in the same range used by the formula
    for u in range(u0 + (-max_k) * (b // d), u0 + max_k * (b // d) + 1):
        # if the division is exact, then the quotient is v
        v, r = divmod(d - a * u, b)
        if r == 0:
            # add solution found ones!
            found_solutions.add((u, v))

    # check if the sets match!
    if found_solutions != formula_solutions:
        print("Failed!")
        # give information of example for which it failed
        print(f"{a = }, {b = }, {d = }, {u0 = }, {v0 = }.")

        # does the formula miss solutions?
        print(f"Solutions found, but not with the in formula:\n {found_solutions - formula_solutions}\n\n")

        # does the formula gives solutions we did not found?
        print(f"Solutions from the formula, but not found:\n {formula_solutions - found_solutions}")
        break
else:  # no break
    print("It seems to work!")

# %% [markdown]
# ### Finding a Specific Solution

# %% [markdown]
# Often we want a specific solution $u$ and $v$.  Say that want the *smallest* positive $u$.
#
# For instance, $\gcd(293, 58) = 1$ and
#
# ```{math}
# 1 = 293 \cdot \underbrace{(-135)}_{u_0} + 58 \cdot \underbrace{682}_{v_0}
# ```

# %%
a, b = 293, 58
u0, v0 = -135, 682
d = gcd(a, b)
d

# %%
d == a * u0 + b * v0

# %% [markdown]
# The previous theorem tells us that we if *add* (since $u_0$ is negative) $b/d = 58$ (an *integer*!) to $u_0$ and subtract $a/d = 293$ to $v_0$, we will have another solution!  (Here we are assuming that $a$ and $b$ are *positive*!)

# %%
# initialize
u, v = u0, v0

# replace
u = u + b // d
v = v - a // d
print(u)

# %% [markdown]
# But it is still negative.  So, we repeat until `u` becomes positive.  At that point it will be the smallest one!

# %%
u = u + b // d
v = v - a // d
print(u)

# %% [markdown]
# Still negative...

# %%
u = u + b // d
v = v - a // d
print(u)

# %% [markdown]
# Ah-ha!  It is positive!  The corresponding `v` is:

# %%
v

# %% [markdown]
# So, $\boxed{u=39, \; v = -197}$ is the solution (of $\gcd(293, 58) = 293 u + 58 v$) with the least positive $u$.

# %% [markdown]
# What if we start with an already positive $u_0$, say $u_0 = 155$ and $v_0 = -783$:

# %%
u0, v0 = 155, -783

# check:
d == a * u0 + b * v0

# %% [markdown]
# In this case we *subtract* $b / d$ from $u_0$ and *add* $a / d$ to $v_0$ until we get a negative $u$.  At that point we went one step to far.  So, we add $b / d$ from $u_0$ and subtract $a / d$ to $v_0$ to get our solution.  Let's see it in practice:

# %%
# initialize
u, v = u0, v0

# replace: note the signs!
u = u - b // d
v = v + a // d
print(u)

# %% [markdown]
# Still positive, so repeat:

# %%
u = u - b // d
v = v + a // d
print(u)

# %% [markdown]
# Repeat:

# %%
u = u - b // d
v = v + a // d
print(u)

# %% [markdown]
# Negative!  So, our previous solution was the one we needed.  We can get it back:

# %%
# switch addition/subtraction
u = u + b // d
v = v - a // d

u, v

# %% [markdown]
# Of course, it is the same solution we found before.  (We just started at a different initial solution.)

# %% [markdown]
# :::{admonition} Homework
# :class: note
#
# In your homework, you will automate this process: you will write a function that given a particular solution $(u_0, v_0)$, it finds the one with the least positive $u$.
# :::
#
# You can do it as above: have two cases, depending on whether $u_0$ is positive or negative.  But there is a clever way to find this smallest positive $u$ directly using *long division*!  Can you find it?
#
# **Hint:**  What happens if you divide $u_0$ by $b/d$?

# %% [markdown]
# ## The Fundamental Theorem of Arithmetic

# %% [markdown]
# Here is an important fact about primes you might remember from school:
#
# :::{prf:theorem} Fundamental Theorem of Arithmetic (Prime Factorization)
# :label: th-fta
#
#
# Let $n$ be an integers greater than or equal to $2$.  Then, there are primes $p_1 < p_2 < \cdots < p_k$, for some $k \geq 1$ and *positive* integers $e_1, e_2, \ldots, e_k$ such that
# ```{math}
# n = p_1^{e_1} \cdot  p_2^{e_2} \cdots  \cdot p_k^{e_k}.
# ```
# Moreover, this representation is *unique*!
# :::
#
#
# For example,
# ```{math}
# \begin{align*}
# 2{,}024 &= 2^3 \cdot 11 \cdot 23, \\
# 2{,}025 &= 3^4 \cdot 5^2, \\
# 2{,}026 &= 2 \cdot 1{,}013.
# \end{align*}
# ```
#
# Hence, these primes are the *building blocks* for integers.
#
# Although you will write your own function for prime factorization, of course, Sage has its own:

# %%
for year in range(2024, 2027):
    print(f"{year} = {factor(year)}")

# %% [markdown]
# You might remember from school how to compute GCDs using prime factorization.  Although it works well for small numbers, the Euclidean Algorithm is a lot more efficient in practice!

# %% [markdown]
# ## Integers vs Real Numbers

# %% [markdown]
# At first glance, it seems that since the integers are simpler than real numbers, problems involving integers should be easier than problems involving real numbers, but in fact, the opposite is true.  In fact, the real numbers were created to "make things easier", e.g., to add solutions to equations that do not have solutions with integers (or rational numbers), like $x^2 = 2$.
#
# As another example, consider finding all *real* solutions of
# ```{math}
# x^2 + y^2 = z^2.
# ```
# That is relatively easy: if $z=0$, we only have the solution $(0,0,0)$.  If not, can divide by $z^2$ and get
# ```{math}
# \left(\frac{x}{z}\right)^2 + \left(\frac{y}{z}\right)^2 = 1,
# ```
# a point in the unit circle.  So, there is some $\theta \in [0, 2 \pi)$ such that
# ```{math}
# \frac{x}{z} = \cos(\theta), \qquad \frac{y}{z} = \sin(\theta).
# ```
# Therefore, all solutions are then $(z \cos(\theta), z \sin(\theta), z)$ for all pairs of $\theta \in [0, 2\pi)$ and real number $z$.

# %% [markdown]
# But how about if we want $x$, $y$, and $z$ be integers?  We can still solve this problem, but it is a lot harder!  We can spot some easy ones, like $(3k, 4k, 5k)$ for all integers $k$, but it requires some clear ideas to find them all, like we easily did for real numbers.
#
# Below, we illustrate other problems involving integers that are easy to state and understand but that are still quite difficult.

# %% [markdown]
# ## Some Open Problems

# %% [markdown]
# ### The Goldbach Conjecture

# %% [markdown]
# A conjecture is a statement believed to be true, but not proven to be true.  In general, this means we have a lot of numerical evidence, but no mathematical proof.  Here is a famous conjecture in Number Theory:
#
# :::{prf:conjecture} Goldbach Conjecture
# :label: cj-goldbach
# :nonumber:
#
# Every *even* integer greater than or equal to four is a sum of two prime numbers.
# :::
#
# For instance, $18 = 3 + 5$, or $60 = 7 + 53$.
#
# Let's write a function that given an integer $n \geq 4$, outputs two primes that add to it, or if there is no such pair, prints a message saying that such pair does not exist.

# %%
def goldbach(n):
    """
    Given an even integer n >= 4, finds a pair of primes that add to n.

    INPUT:
    n: an even integer greater than or equal to 4.

    OUTPUT:
    Two primes that add to n.
    """
    p = 2
    while not is_prime(n - p) and p <= n / 2:  # NOTE THE n / 2!
        p = next_prime(p)
    if p > n / 2:
        print(f"{n} is a counter example!")  # not going to happen!!!
        return None

    # print(f"{n} = {p} + {n - p}")
    return p, n - p

# %% [markdown]
# Let's test it for integers between $4$ and $100$:

# %%
for n in range(4, 101, 2):
    p, q = goldbach(n)
    print(f"{n:>3} = {p:>3} + {q:>3}")

# %% [markdown]
# This has been tested up to really huge numbers, so it is believed to be true, but no one has *proved* it yet.

# %% [markdown]
# ### The Twin Primes Conjecture

# %% [markdown]
# :::{prf:definition} Twin Primes
# :label: def-twin_primes
# :nonumber:
#
# Two primes are called *twin primes* if they differ by $2$.  This means that, apart from $2$ and $3$, they are as close as possible, since they will both be odd.
# :::
#
# For example, $11$ and $13$ are twin primes, and $101$ and $103$ are as well.
#
# :::{prf:conjecture} Twin Primes Conjecture
#
# There are infinitely many pairs of twin primes.  In other words, given any integer $N$ (no matter how large), there is a prime $p \geq N$ such that $p + 2$ is also prime.
# :::
#
# So, let's write a function that, given $N$, finds a pair of twin primes with the smaller at least $N$.  Here we use the Sage's handy function `next_prime`.

# %%
def twin_test(N):
    """
    Given N, finds a pair of twin primes larger than n.
    """
    p = next_prime(N)
    while not is_prime(p + 2):
        p = next_prime(p)
    return p, p + 2

# %% [markdown]
# Let's test it:

# %%
N = 10^12  # very large
twin_test(N)
