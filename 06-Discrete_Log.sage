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
# # The Discrete Log Problem

# %% [markdown]
# ## Logarithms

# %% [markdown]
# Remember how logarithms work: if you are asked was is $\log_{\color{red} 2}({\color{blue} 4})$, what you are being asked is *what power of ${\color{red} 2}$ gives us ${\color{blue} 4}$*?   In other words, the answer is the value of $x$ such that ${\color{red} 2}^x = {\color{blue} 4}$.  In this case, the answer is easy: since ${\color{red} 2}^2 = {\color{blue} 4}$, we have that $\boxed{\log_2(4) = 2}$.
#
# That is essentially all that there is to logs.  On the other hand, it clearly is harder than computing powers.  If I asked you what is $5^3$, you simply compute it directly: $5^3 = 5 \cdot 5 \cdot 5 = 125$.  But if I ask you what is $\log_5(125)$, you do not compute it directly: you solve $5^x = 125$ for $x$.  (And this solution is $\log_5(125)$, which is $3$ in this case.)  This is similar to how to compute $\sqrt{9}$ we do not do (in general) a direct computation, but solve the equation $x^2 = 9$, which the *non-negative* solution being the answer.

# %% [markdown]
# ## Discrete Logs

# %% [markdown]
# Now suppose we have some elements $a, g \in \mathbb{Z}/m\mathbb{Z}$.  One might ask if there is some power $k$ such that $a = g^k$.  Note that is the same question that the logarithm asks: what is the power of $g$ that gives us $a$.  Hence, if $g^k = a$, we write, similar to real numbers, that $k = \log_g(a)$.
#
# For real numbers we know that if the base $b$ of the log is positive and different from $1$, and $a$ is positive, then $\log_b(a)$ exists, meaning, there is indeed some power of $b$ that gives $a$.  This questions is a bit harder to answer for logs in $\mathbb{Z}/m\mathbb{Z}$.  For instance, in $\mathbb{Z}/8\mathbb{Z}$, no power of $2$ can give you $3$.  There are few ways to check that this is indeed true, but let's do it computationally with Sage.
#
# First, how many times do we have to compute these powers?
#
# If we get a repetition, that means that we will start to get the same results as from the first occurrence.  So, let's check our example

# %%
Mod(2, 8)^2

# %%
Mod(2, 8)^3

# %%
Mod(2, 8)^4

# %% [markdown]
# Ah, since we got $0$ again, we know that from now on you we will only get zeros, as we can stop.  No power of $2$ will ever give us $3$ in $\mathbb{Z}/8\mathbb{Z}$.  The powers can only give us $1$ (power $0$), $2$ (power $1$), $4$ (power $2$), and $0$ (any power $3$ or larger).  So, in this case we say that $\log_2(3)$ (in $\mathbb{Z}/8\mathbb{Z}$) *does not exist*.
#
# As another example, we can see, still in $\mathbb{Z}/8\mathbb{Z}$, that $\log_3(5)$ does not exist, i.e., there is no power of $3$ that gives $5$:

# %%
Mod(3, 8)^2

# %% [markdown]
# Ah, we already have a repetition since $3^0 = 1$, $3^1=3$, and $3^2 = 1$.  So, we know that the powers will just repeat, giving $1$, $3$, $1$, $3$, ...  In fact, if $n$ is even, we get $3^n = 1$, and if odd we get $3^n = 3$, due to this pattern.

# %% [markdown]
# On the other hand, sometimes the discrete log does exist!  A simple one, still in $\mathbb{Z}/8\mathbb{Z}$, is $\log_3(1)$: we have that $3^0 = 1$, so $\log_3(1) = 0$.
#
# But wait!  We also have that $3^2 = 1$.  In fact, any positive *even* integer power of $3$ would give $1$, as we've just seen.  So, which one of these powers is $\log_3(1)$?  Let's postpone the answer for a little while, but we will comme back to this issue.

# %% [markdown]
# ### Terminology

# %% [markdown]
# We can a log in $\mathbb{Z}/m\mathbb{Z}$ a *discrete log*, as the result is a subset of the *integers*, not the real numbers.  The integers are called *discrete* because its separated from each other by gaps in the real line.  Conversely, the real numbers are *continuous*, since there are not gaps between real numbers (in the real line) that is not filled by real numbers.
#
# More generally, a discrete log is any kind of log (meaning, situations where we are asking for powers) where the results are integers.  We will mostly work for discrete logs in $\mathbb{Z}/m\mathbb{Z}$, although later we will talk about discrete logs in finite fields and elliptic curves.

# %% [markdown]
# ### Properties
#
# The discrete log has similar properties to the regular log:
#
# :::{prf:property} Discrete Log Properties
# :label: pr-dl
#
#
# 1) If $\log_g(a)$ and $\log_g(b)$ both exist, then $\log_g(ab)$ also exists and $\boxed{\log_g(ab) = \log_g(a) + \log_g(b)}$.
#
# 2) If $\log_g(a)$ exists and $k$ is a positive integer, then $\log_g(a^k)$ also exists and $\boxed{\log_g(a^k) = k \cdot \log_g(a)}$.
# :::

# %% [markdown]
# ## Computing the Discrete Log

# %% [markdown]
# Again, when trying to compute a discrete log, we are not sure in principle, if it exists or not.  But, there is one case when are sure that it does.  If $g$ is a primitive root of $\mathbb{Z}/m\mathbb{Z}$ and $a$ is a *unit*, then we know that $\log_g(a)$ exists, since every unit is a power of $g$.
#
# Moreover, in this case, the question of how we properly define the discrete log, since multiple powers of $g$ can give $a$, is to think of the exponent, and so the values of the discrete log, in $\mathbb{Z}/\varphi(m)\mathbb{Z}$.  This works, since, as we've seen before, we have that $|g| = \varphi(m)$ and hence we can consider the exponents of $g$ modulo $m$.  (More generally, if $g$ is not primitive root, we consider exponents, and so the values of the discrete log, in $/Z/|g|\mathbb{Z}$.)
#
# The only method we know (at least so far) to compute the discrete log is *brute force*: to compute $\log_g(a)$, we start computing powers of $g$, i.e., $g^0$, $g^1$, $g^2$, etc., until we either get $a$ or get a repeated power, in which case the log does not exist.  This make this computation extremely time consuming if $|g|$ is a really large number, and as we will soon see, we can use this difficulty to create a cryptosystem that is difficult to break.

# %% [markdown]
# Note that with the usual log (with real numbers), we have numerical methods that allow us to compute these logs fairly quickly.  But discrete log, although similar in concept, is very different.  If you look at consecutive powers of a single primitive root $g$ in $\mathbb{Z}/m\mathbb{Z}$, they seem to just bounce randomly, making it difficult to predict the value, and hence solve difficult to compute discrete logs.
#
# For instance, in $\mathbb{Z}/31\mathbb{Z}$, we have that $17$ is a primitive root.  Here are the powers of $17$, in order:
#
# :::{table} Powers of $17$ in $\mathbb{Z}/31\mathbb{Z}$
# :widths: grid
#
# | $k$ |  $7^k$ |   | $k$ | $17^k$ |   | $k$ | $17^k$ |
# |----:|:-------|---|----:|:-------|---|----:|:-------|
# |   0 | 1      |   |  10 | 25     |   |  20 | 5      |
# |   1 | 17     |   |  11 | 22     |   |  21 | 23     |
# |   2 | 10     |   |  12 | 2      |   |  22 | 19     |
# |   3 | 15     |   |  13 | 3      |   |  23 | 13     |
# |   4 | 7      |   |  14 | 20     |   |  24 | 4      |
# |   5 | 26     |   |  15 | 30     |   |  25 | 6      |
# |   6 | 8      |   |  16 | 14     |   |  26 | 9      |
# |   7 | 12     |   |  17 | 21     |   |  27 | 29     |
# |   8 | 18     |   |  18 | 16     |   |  28 | 28     |
# |   9 | 27     |   |  19 | 24     |   |  29 | 11     |
# :::
#
# As you can see, the powers do not seem to follow any pattern.

# %%
list_plot([power_mod(17, x, 31) for x in range(30)])

# %% [markdown]
# :::{prf:definition} The Discrete Log Problem
# :label: def-dlp
#
#
# We call the (computationally intensive) problem of computing a discrete log $\log_g(a)$, i.e., finding a power $x$ (in $\mathbb{Z}/|a|\mathbb{Z}$) such that $g^x = a$ in $\mathbb{Z}/m\mathbb{Z}$, the *discrete log problem (DLP)*.
# :::
