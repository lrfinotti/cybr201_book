# ---
# jupyter:
#   jupytext:
#     formats: ipynb,md:myst,sage:percent
#     text_representation:
#       extension: .sage
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.16.7
#   kernelspec:
#     display_name: SageMath 10.5
#     language: sage
#     name: sage-10.5
# ---

# %% [markdown]
# ---
# math:
#   '\F': '\mathbb{F}'
#   '\Fpt': '\F_p^{\times}'
# ---
#
# # The Diffie-Hellman Key Exchange and the ElGamal Cryptosystem

# %% [markdown]
# ## Cryptosystems
#
# A [Cryptosystem](https://en.wikipedia.org/wiki/Cryptosystem) is a set of algorithms used in the transmission of private messages.
#
# As we've mentioned before, the usual scenario is when Bob wants to send Alice some secret message so that even if their enemy Eve intercepts the message, she will not be able to read its content.
#
# This means that Bob needs a way to *encode* the message and Alice needs a way to decode the message, and the decoding process must difficult enough that, without some secret knowledge, Eve should not be able to discover the decoding method.
#
# Formally, we write that if $m$ is the plain/unencrypted message, then Bob uses some *encoding key*, say $e$, to create a function $E_e$, called the *encryption function*, which depends on the key $e$, so that $E_e(m)$ produces the encrypted message.
#
# Alice then uses a *decoding key* $d$ (which will depend on the encoding key $e$) to produce a *decryption function* $D_d$ that can recover an encrypted message, i.e., such that $D_d(E_d(m)) = m$.
#
# In our example of the Caesar Cipher, the encryption key $e$ was the table that would permute the letters of the alphabet, and the encryption function would use the table $e$ to replace the letters.  The decoding key $d$ was the inverse table of $e$, and the decoding function would use this reversed table to replace the letters based on this new table $d$.

# %% [markdown]
# ## Symmetric versus Asymmetric Cryptosystems
#
# In our Caesar Cipher example, as mentioned before, knowledge of the encryption table/key $e$ would automatically tell Eve what the decryption key $d$ should be.  This is an example of what we call a *symmetric cryptosystem*: the same key allows for both encrypting and decrypting messages.
#
# But again, this raises the problem of how will Alice and Bob exchange the encryption/decryption key.  A better method would be to have an *asymmetric cryptosystem*, i.e., one in which Alice can provide *publicly* an encoding key to Bob (or anyone else who might want to send her a message), but keep secret her decoding key, with the obvious assumption that is hard to obtain the decoding key from the publicly available decoding key.  In this situation the encoding key is called the *public-key* and the decoding key is called the *private key*.  For this reason, these asymmetric cryptosystems are also called *public-key cryptosystems*.
#
# Of course, the real question is how can we create such a system.  Most of the naive methods one can come up with will be symmetric.  But before we do that, let's see if we can find a safe way to exchange a key in a symmetric cryptosystem.

# %% [markdown]
# ## The Diffie-Hellman Key Exchange
#
# If you have a symmetric cryptosystem, you are faced with the problem of sharing the encryption/decryption key.  [Whitfield Diffie](https://en.wikipedia.org/wiki/Whitfield_Diffie) and [Martin Hellman](https://en.wikipedia.org/wiki/Martin_Hellman) proposed in 1976 a clever method to do so, based on the discrete log problem (DLP).  Here is how it goes:
#
# **The Diffie-Hellman Key Exchange:**
#
# 1) A trusted party publishes:
#     - a large prime $p$ and
#     - an element $g$ of $\Fpt$ of large *prime* order $q$.  (The order $q$ is also public.)
# 2) Alice chooses a *secret* integer $a$, and Bob chooses a *secret* integer $b$.
# 3) Alice computes $A = g^a$ and *publicly* sends the result $A$ to Bob.  (So, $A$ is known, but not the exponent $a$ to produce it.)  Similarly, Bob computes $B = g^b$ and *publicly* sends the result $B$ to Alice.
# 4) Alice computes $B^a$ and Bob computes $A^b$.  These values are equal and that is their **shared key**.
#
# Note that $A^b = (g^a)^b = g^{ab}$ and $B^a = (g^b)^a = g^{ba} = g^{ab}$, and that's why they now posses a common secret key.
#
# Eve, Alice and Bob's enemy, will know $p$, $g$, $q$, $A$, and $B$, since these are all public, but will not know $a$ and $b$.  Only Alice knows $a$ and only Bob knows $b$.  Now Alice and Bob can, somehow, use their shared key to produce they key for a symmetric cryptosystem.
#
#
# :::{note}
#
# The numbers involved are very large in general, so one would have to compute very large powers of $g$.  So, you can see how the [Fast Powering Algorithm](./05-Powers.md#fast_powering).
# :::

# %% [markdown]
# ### Finding $q$ and $g$
#
# How would one find the $g$, with large order $q$ in $\Fpt$?  Let's first think about its order, which we called $q$.  We want it to be as large as possible.  As we've seen in [Proposition %s](./05-Powers.md#pr-power_one) in the previous section, we know that $|g| = q \mid \varphi(p)=p-1$.  Since $p$ is odd, being a prime different from $2$, the largest that $q$ could be is if $p-1 = 2q$.  So, to find the *pair* $p$ and $q$, we look for a $p$ of the desired size, and check if $(p-1)/2$ is also prime.  If so, $q = (p-1)/2$ works.
#
# We can do that relatively easy with Sage for primes of reasonable size:

# %%
# %%time

# let's find a 64-bit prime
lower_bound = 2^63
upper_bound = 2^64 - 1

while True:
    p = next_prime(randint(lower_bound, upper_bound))
    q = (p - 1) // 2
    if is_prime(q):
        break

print(f"We can take {p = } and {q = }.")

# %% [markdown]
# Now, how do we find $g$, and element of $\Fpt$ of order $q$?
#
# If we take a random element of $a$ of $\Fpt$, we know that $|a| \mid p-1 = 2q$.  Since $q$ is prime, the only possible orders for $a$ are $1$ (and only the element $1$ of $\Fpt$ has order $1$), $2$ (and one can show that the only $-1 = p - 1$ has order $2$ in $\Fpt$), $q$, or $2q$.
#
# Now, we can compute $a^2$.  If we get $1$, then $a$ is either $1$ or $p-1$, and we try a different random $a$.  But if $a^2 \neq 1$, then, either $|a| = q$ or $|a|=2q$.
#
# If $|a|=q$, then, by [Proposition %s](./05-Powers.md#pr-order_power), we have that
# $$
# |a^2| = \frac{q}{\gcd(q, 2)} = \frac{q}{1} = q,
# $$
# since $q$ is odd.
#
# If $|a|=2q$, then, by the same result, we have that
# $$
# |a^2| = \frac{2q}{\gcd(2q, 2)} = \frac{2q}{2} = q.
# $$
# Hence, in either case $a^2$ gives us an element of order $q$.
#
# So, we have, when $p = 2q$, to find an element of order $q$ we simply take an random element $a$ between $2$ and $p-2$, and square it, i.e., we take $g = a^2$.
#
# In your homework you will generalize his for cases when $q \mid (p-1)$, but not necessarily equal to $(p-1) / 2$, and estimate how long it would take to find it.

# %% [markdown]
# ### Example
#
# As a quick example.  First, last use a prime $p$ between $100{,}000$ and $200{,}000$, such that $(p-1)/2$ is also prime.  (This size is too small for it to safe, but will illustrate the process.)

# %%
while True:
    p = next_prime(randint(10^5, 2*10^5))
    q = (p-1) // 2
    if is_prime(q):
        break

print(f"We have {p = }, and {q = }.")

# %% [markdown]
# We also need some element $g$ in $\Fpt$ of order $q$.

# %%
g = Mod(randint(2, p-2), p)^2
g

# %% [markdown]
# Let's check its order:

# %%
g.multiplicative_order() == q

# %% [markdown]
# Now Alice takes a random $a$ between $2$ and $q - 1$:

# %%
a = randint(2, q - 1)
a

# %% [markdown]
# And Bob takes and random $b$ in the same range:

# %%
b = randint(2, q - 1)
b

# %% [markdown]
# Alice computes $A = g^a$:

# %%
A = g^a
A

# %% [markdown]
# And Bob computes $B = g^b$:

# %%
B = g^b
B

# %% [markdown] user_expressions=[{"expression": "A", "result": {"status": "ok", "data": {"text/plain": "104692"}, "metadata": {}}}, {"expression": "B", "result": {"status": "ok", "data": {"text/plain": "94363"}, "metadata": {}}}]
# So, now Alice sends Bob $A$, i.e., {eval}`A`, and Bob sends Alice $B$, i.e., {eval}`B`, while keeping $a$ and $b$ for themselves.
#
# Then, Alice computes $B^a$, with $B$ from Bob and her private key $a$:

# %%
B^a

# %% [markdown]
# And Bob computes $A^b$, with $A$ from Alice and his private key $b$:

# %%
A^b

# %% [markdown]
# As you can see, it is the same number, the same as $g^{ab}$:

# %%
g^(a * b)

# %% [markdown]
# ### Finding the Shared Key
#
# How could Eve find the shared key $g^{ab}$ without knowing $a$ and $b$?  If she can solve the discrete log problem, then she can: Eve computes $\log_g(A)$, which is just $a$, and then, as Alice does, gets the shared key as $B^a$.  It is not known if there is some clever method for which Eve could computer $g^{ab}$ from $g^a$ and $g^b$ more efficiently then computing $a$ or $b$ from the discrete log.

# %% [markdown]
# ### Security Considerations
#
# Is the Diffie-Hellman Key Exchange secure in general?  If $p$ (from $\Fpt$) and $q = |g|$ are large enough, and $a$ and $b$ are *randomly generated* number between $2$ and $q-1$ (and therefore likely quite large as well), it is *believed* to be secure, because the discrete log problem is *believed* to be difficult.
#
#
# :::{note}
#
# In general we want $p$ to have at least $2048$ bits, i.e., we want $p \geq 2^{2047}$ (noting that $2^{2047}$ has $617$ *digits*), and if possible have the prime $q$ to be simply $(p-1)/2$, the largest possible order of an element in $\Fpt$.  This would mean that $q$ would be a $2047$-bit prime.
# :::
#
# Choosing $a$ and $b$ randomly is also strongly encourage, as to avoid numbers that are easier to guess, like birth dates, phone numbers, addresses, etc.
#
# But why is the discrete log problem or breaking the Diffie-Hellman key exchange *believed* to be safe?  Mostly because those are mathematical problems that mathematicians, including some of the most capable individuals one can expect to find, have been trying to solve for a relatively long time.  Moreover, as researchers, mathematicians would likely publish any solution they find, instead of secretly keeping the solution to themselves to explore it.
#
# But note that we have no guarantee that some very clever individual will come up with an ingenious solution *tomorrow*.  Or that this individual, or nation, will not be tempted to keep the solution secret for personal, financial, or military gains.  **But basing security of cryptosystems in long standing mathematical problems is the best idea we have so far.**

# %% [markdown]
# ### Public Setup
#
# A great advantage of a public setup step, as step 1 of the Diffie-Hellman Key Exchange is that we can copy the setup (i.e., the $p$, $g$, and $q$) from some organization using the depend on its security, like the National Security Agency or some large online retailer, like Amazon, as they have certainly devoted considerable resources to make sure that their setup is secure.

# %% [markdown]
# ## The ElGamal Public-Key Cryptosystem

# %% [markdown]
# The Diffie-Hellman key exchange allows us to have a shared key with each one can set up some *public-key* cryptosystem (based on this key).  But how can one actually do it?  [Taher ElGamal](https://en.wikipedia.org/wiki/Taher_Elgamal) in 1985 introduce the [ElGamal Cryptosystem](https://en.wikipedia.org/wiki/ElGamal_encryption) based on Diffie-Hellman.
#
# :::{note}
#
# The ElGamal cryptosystem was not the first public-key cryptosystem.  The [RSA Cryptosystem](https://en.wikipedia.org/wiki/RSA_cryptosystem) was introduce in 1977, one year after the introduction of the Diffie-Hellman key exchange, but, unlike ElGamal, it does not use it.  We will introduce the RSA cryptosystem in the next chapter.
# :::
#
# We will now describe the cryptosystem, but observe that, for now, we shall assume that the message to be exchanged between Bob and Alice is a *number*, but we shall soon discuss how we can apply this method can be used for text as well.

# %% [markdown]
# ### Steps for ElGamal Encryption
#
# 1) **Set up:** Choose and publish large prime $p$ and element $g \in \F_p$ of large prime order.
# 2) **Key Creation:** Alice chooses a *private* key $a \in \{1, 2, 3, \ldots, p-2\}$ and publishes $A = g^a$ (in $\F_p$).
# 3) **Encryption:** To encrypt the message $m$ (a numbers between $1$ and $p-1$), Bob chooses a *random* *ephemeral* key (i.e., a random key to be discarded after a single use), computes $c_1 = g^k$, and $c_2=mA^k$ (both in $\F_p$), and sends the pair $(c_1, c_2)$ to Alice.  (This pair is the encrypted message.)
# 4) **Decryption:** To decrypt $(c_1, c_2)$ sent by Bob, Alice, using her private key $a$, computes $(c_1^a)^{-1} \cdot c_2$ (in $\F_p$).  This last expression is equal to the message $m$.
#
#
# Let's check that this process works.  We have
# \begin{align*}
#   (c_1^a)^{-1} \cdot c_2 &= {\left({\left(g^k\right)}^a\right)}^{-1} \cdot m A^k && \text{(since $c_1 = g^k$, and $c_2=mA^k$)}\\
#   &= {\left(g^{ak}\right)}^{-1} \cdot m A^k\\
#   &= {\left({\left(g^a\right)}^k\right)}^{-1} \cdot m A^k \\
#   &= {\left(A^k\right)}^{-1} \cdot m A^k && \text{(since $g^a = A$)}\\
#   &= m \cdot (A^k)^{-1} A^k \\
#   &= m.
# \end{align*}

# %% [markdown]
# :::{note}
#
# Note that inside this process we have an Diffie-Hellman key exchange: Alice has $A = g^a$ and Bob has $g^k$, with the shared key being $A^k = g^{ak}$, which Alice uses for decryption when she computes $c_1^a$.
# :::

# %% [markdown]
# ### Example

# %% [markdown]
# #### Set Up
#
# We can use the same $p$ and $g$ we've used for Diffie-Hellman above (or one can repeat the same steps, of copy the set up from a trusted source):

# %%
print(f"We will use {p = } and {g = }.")

# %% [markdown]
# #### Private/Public Keys
#
# Alice can just choose her private key $a$ as a random number:

# %%
a = randint(2, p - 2)
print(f"Alice will use {a = }.")

# %% [markdown]
# Finally, Alice publishes $A=g^a$:

# %%
A = g^a

# %% [markdown]
# #### Encryption
#
# Now, suppose that Bob wants to send Alice the last four digits of his Social Security Number, say $m = 1234$.
#
# :::{note}
#
# Note that the size of $p$, in principle, restricts the size of numbers that Bob can send Alice, as it needs to be between $0$ and $p-1$.  But we will see how to deal with this restriction later.
# :::

# %%
m = Mod(1234, p)

# %% [markdown]
# Now, Bob chooses his random ephemeral key $k$ (to be used only once):

# %%
k = randint(2, p - 1)

# %% [markdown]
# Then, computes $c_1$ and $c_2$ and gets the encrypted message $(c_1, c_2)$:

# %%
c1 = g^k
c2 = m * A^k
encrypted_message = (c1, c2)

encrypted_message

# %% [markdown]
# Bob then sends $(c_1, c_2)$ to Alice.

# %% [markdown]
# #### Decryption
#
# Alice receives $(c_1, c_2)$ and decrypts with the formula $(c_1^a)^{-1} \cdot c_2$ as above.  We should get the original message $m = 1234$ as the result:

# %%
c1, c2 = encrypted_message  # Alice reads c1 and c2 from encrypted message received
(c1^a)^(-1) * c2

# %%
