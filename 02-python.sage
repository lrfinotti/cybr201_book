# ---
# jupyter:
#   jupytext:
#     formats: ipynb,sage:percent,md:myst
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
# # Introduction to Python, Sage, and Jupyter Notebooks

# %% [markdown]
# We will use some computer tools to learn and deal with cryptography in this course.  Our main software will be [Sage](https://www.sagemath.org/).  On the other hand, Sage is built on top of [Python](https://www.python.org/) (and other math software), with which it shares its syntax.  In fact, you can use virtually any Python tool within Sage.
#
# But before we start our discussion of Sage and Python, we need to talk about *Jupyter Notebooks*.

# %% [markdown]
# ## Jupyter Notebooks

# %% [markdown]
# We will use [Jupyter Notebooks](https://jupyter.org/) in this course for our classes, computations, and homework.  In fact, this is a Jupyter notebook!
#
# Jupyter notebooks allow us to have formatted text, math formulas, images, and code together in a single document.

# %% [markdown]
# ### Cells

# %% [markdown]
# A notebook is made of cells, which can be a text/Markdown cell, like this one you are reading, or a code cell, like the one below:

# %%
print("Hello world!")

# %% [markdown]
# **Code cells:** Code cells can run, by default, Python code.  To run the code cell, click on it and press `Shift + Enter/Return`.  You can edit a code cell simply by clicking inside it.

# %% [markdown]
# **Text cells:** Text cells are formatted with [Markdown](https://daringfireball.net/projects/markdown/), which provides a quick syntax to format text.  [Markdown Guide](https://www.markdownguide.org/) is one of the many possible references to get started with Markdown.
#
# To edit a text cell, you need to double click on it.  (You will then see the markdown code.)  When done, you run it, like a code cell, with `Shift + Enter/Return`, to format the text.

# %% [markdown]
# **Switching cell types:** By default new cells are code cells.  To convert to a text cell, you can click on the *Code* drop down box on the of the notebook and select *Markdown*.
#
# Alternatively, you can click on the left of cell and press `m` (lower case `M`).  It will convert it to a text/markdown cell.  Pressing `y` will convert back to a code cell.

# %% [markdown]
# **Edit and Command modes:** The *current (or selected) cell* has a blue mark on its left.  And a cell has two modes: *Edit Mode*, and *Command Mode*.  In edit mode, well, you can edit the cell.  You should see the cursor inside the cell and you can start typing in it.
#
# For a code cell, you just need to click inside it to enter edit mode.  For a text cell, you need to double click on it to enter edit mode.
#
# Clicking on the left of a cell will make it enter command mode.  But, if it is a text cell, it will not format the markdown code.  So, you can run it first, and then click on cell itself to select it.
#
# **Keyboard shortcuts:** If you plan to use Jupyter notebooks a lot, I strongly recommend you learn some keyboard shortcuts.  [Chetography](https://cheatography.com/) has a nice [shortcut cheatsheet](https://cheatography.com/weidadeyue/cheat-sheets/jupyter-notebook/).
#
# For instance, *in command mode*, to add a cell above the current one, press `a`.  To add a cell below it, press `b`.
#
# You can press `x`, `c`, and `v` to cut, copy, and paste a cell, respectively.  You can also drag and drop cells (clicking an holding on the left of the cell).

# %% [markdown]
# ### LaTeX

# %% [markdown]
# You can also enter mathematical expressions using [LaTeX](https://www.latex-project.org/).  With a quick search I've found this: [Introduction to LaTeX
# for Jupyter notebooks](http://chebe163.caltech.edu/2018w/handouts/intro_to_latex.html), which seems to introduce the basics.

# %% [markdown]
# Here is an example of LaTeX (from calculus): we say that if $f(x)$ is *differentiable* at $x=a$, if the limit
#
# $$
# \lim_{x \to a} \frac{f(x) - f(a)}{x-a} = \lim_{\Delta x \to 0} \frac{f(a + \Delta x) -f(a)}{\Delta x}
# $$
#
# exists.  In the case, the value of the limit is called the *derivative* of $f(x)$ at $x=a$, and usually is denoted by $f'(a)$.

# %% [markdown]
# ### Tab Completion

# %% [markdown]
# Jupyter Lab has *tab completion* for code cells.  This means that if you are typing a variable name or function name in a code cell and then press the key TAB (on the left of the Q key), it will give you the variables/functions that start with the characters you've already typed.

# %%
var_1 = 1
var_2 = 2
var_3 = 3

# %%
# var_  # press TAB

# %%
# min  # press tab

# %% [markdown]
# ## Basic Python/Sage

# %% [markdown]
# This notebook is running Sage, meaning that I've selected the Sage *kernel* to run the code cells by default.  But, unless I explicitly say otherwise, what comes next applies to both Sage and Python.  Again, Sage is built on top of Python, so it is not unlike running Python and loading many math libraries at the start.  Sage provides extra functions and data types that makes it easier to do math out of the box.
#
# Therefore, this introduction serves as an introduction to both Sage and Python!

# %% [markdown]
# ## Simple Computations

# %% [markdown]
# We can use Sage/Python to perform simple mathematical computations.  Its syntax should be mostly familiar.  For example, to compute the product $3 \cdot 4$, we simply type (in a *code cell*):

# %%
3 * 4

# %% [markdown]
# As it is usual, the asterisk `*` is used for product.

# %% [markdown]
# We can perform more involved computations.  For instance, to compute
# $$
# 3 + \left( \frac{2}{3} - 5 \cdot 7\right),
# $$
# we do:

# %%
3 + (2 / 3 - 5 * 7)

# %% [markdown]
# :::{warning} Sage versus Python
#
#  Note that this computation, in Sage, gives us a fraction and not a decimal (usually called a *float* in Python), as in Python.
# :::
#
#
# I will run the same computation using (real/plain) Python by starting the cell with `%%python`:

# %% language="python"
#
# print(3 + (2 / 3 - 5 * 7))

# %% [markdown]
# Although I needed the `print` above to see the result (unlike the previous code cell), this cell is running the same computation in *Python*, and the result is a decimal.
#
# Sage's behavior is, as expected, better for mathematics, as we get an exact results and can deal with [rational numbers](https://en.wikipedia.org/wiki/Rational_number) (i.e., fraction of integers).
#
# If we want the decimal in Sage, we have a few options:

# %%
4 / 6

# %% [markdown]
# (Note that Sage always gives you a *reduced fraction*, meaning that the numerator and denominator have no common factor.)

# %%
4.0 / 6

# %%
(4 / 6).numerical_approx()

# %%
numerical_approx(4 / 6)

# %% [markdown]
# Note that the last two have options allow you specify the number of digits in the numerical approximation with the optional argument `digits=`:

# %%
numerical_approx(4 / 6, digits=30)

# %%
(4 / 6).numerical_approx(digits=30)

# %% [markdown]
# Note that `n` is a shortcut for `numerical_approx`:

# %%
n(4 / 6, digits=30)

# %%
(4 / 6).n(digits=30)

# %% [markdown]
# The problem for the *function* `n(...)` is that we often use `n` as a variable name, which overwrites the function name!  In that case, we can use `numerical_approx(...)` or the *method* `.n`.

# %% [markdown]
# :::{warning} Sage versus Python
#
# For *powers* Python uses `**` instead of the more commonly used `^`, which is used by Sage.  (Sage also accepts `**` for powers!)  In Python is used for the logical operator *XOR*, or *"exclusive or"*.  So, if you use `^` instead of `**` Python will not give an error, but it won't compute what you were expecting!
# :::

# %%
3 ^ 4

# %% language="python"
# print(3 ^ 4)

# %%
3 ** 4

# %% language="python"
# print(3 ** 4)

# %% [markdown]
# As in any language, there is a specific syntax we must follow.  For instance:

# %% [markdown]
# ### Common Operators
#
# Here are some of the most basic operations:
#
#
# :::{table} Common Mathematical Operations
# :align: center
# :widths: auto
# :width: 100 %
# :name: tb-operations
#
# | Expression Type         | Operator | Example    | Value     |
# |-------------------------|----------|------------|-----------|
# | Addition                | `+`      | `2 + 3`    | `5`       |
# | Subtraction             | `-`      | `2 - 3`    | `-1`      |
# | Multiplication          | `*`      | `2 * 3`    | `6`       |
# | Division (Python)       | `/`      | `7 / 3`    | `2.66667` |
# | Division (Sage)         | `/`      | `7 / 3`    | `7 / 3`   |
# | Integer Division        | `//`     | `7 // 3`   | `2`       |
# | Remainder               | `%`      | `7 % 3`    | `1`       |
# | Exponentiation (Python) | `**`     | `2 ** 0.5` | `1.41421` |
# | Exponentiation (Sage)   | `^`      | `2 ^ 0.5`  | `1.41421` |
# :::

# %% [markdown]
# Sage/Python expressions obey the same familiar rules of *precedence* as in algebra: multiplication and division occur before addition and subtraction. Parentheses can be used to group together smaller expressions within a larger expression.

# %% [markdown]
# So, the expression:

# %%
1 + 2 * 3 * 4 * 5 / 6^3 + 7 + 8 - 9 + 10

# %% [markdown]
# represents
# $$
# 1 + \left(2 \cdot 3 \cdot 4 \cdot \frac{5}{6^3}\right) + 7 + 8 - 9 + 10 = \frac{158}{9} = 17.5555\ldots,
# $$
# while

# %%
1 + 2 * (3 * 4 * 5 / 6)^3 + 7 + 8 - 9 + 10

# %% [markdown]
# represents
# $$
# 1 + 2 \cdot {\left(3 \cdot 4 \cdot \frac{5}{6}\right)}^3 + 7 + 8 - 9 + 10 = 2017.
# $$

# %% [markdown]
# :::{note}
#
# Python would give `2017.0` as the answer.
# :::

# %% [markdown]
# ### Some Builtin Functions
#
# Sage comes with most functions needed in mathematics (without having to import other modules, like in Python).
#
# For instance, `abs` (also present in Python) is the absolute value function (i.e, $| \, \cdot \, |$):

# %%
abs(-12)

# %% [markdown]
# Rounding to the nearest integer (also available in Python):

# %%
round(5 - 1.3)

# %% [markdown]
# Maximum function (also available in Python):

# %%
max(2, 2 + 3, 4)

# %% [markdown]
# In this last example, the `max` function is *called* on three *arguments*: 2, 5, and 4. The value of each expression within parentheses is passed to the function, and the function *returns* the final value of the full call expression. The `max` function can take any number of arguments and returns the maximum.

# %% [markdown]
# All the above functions were present in (plain) Python.  But Sage has many that are not, for instance, log functions:

# %%
log(2)

# %% [markdown]
# :::{warning} Sage versus Python
#
# Here again we see a difference between Sage and Python.  Sage will not automatically evaluate functions when they do not yield "simple" numerical results, but only simplify when possible.  This makes sure that we do not lose precision.
# :::
#
# We can always the the decimal value/approximation with the `numerical_approx` function:

# %%
numerical_approx(log(2))

# %%
log(2).numerical_approx()

# %% [markdown]
# To get help on a particular function, you can type its name followed by a question mark `?`:

# %%
log?

# %% [markdown]
# or, you can use `help`:

# %%
help(log)

# %% [markdown]
# or you can press *Shift-TAB* with the cursor after the function's name:

# %%
log

# %% [markdown]
# As the documentation for `log` shows, the base for this log is `e`, meaning that `log` is the *natural log*.  But it also shows that we can use different bases.

# %% [markdown]
# So, the natural log of $16$, i.e., $\ln(16)$ is given by?:

# %%
log(16).numerical_approx()

# %% [markdown]
# Log base $2$ of $16$, i.e., $\log_2(16)$:

# %%
log(16, 2)

# %% [markdown]
# Note that the result is *exact*!  So, Sage is not using numerical methods to compute the log, it is *simplifying it* without loss of precision.

# %% [markdown]
# We could also have done:

# %% [markdown]
# Log base $4$ of $16$, i.e, $\log_4(16)$:

# %%
log(16, 4)

# %% [markdown]
# ### Getting Help

# %% [markdown]
# Besides using `?` at then end, `help(...)`, and pressing Shit+TAB, one can see the [source code](https://en.wikipedia.org/wiki/Source_code) of a function with `??`:

# %%
is_prime??

# %% [markdown]
# ### Math Constants

# %% [markdown]
# Sage also comes with some constants, like $\pi$ (set to `pi`) and $e$ (set to `e`):

# %%
cos(pi / 2)

# %%
numerical_approx(pi, digits=100)

# %%
log(e)

# %%
numerical_approx(e, digits=100)

# %% [markdown]
# ## Variables

# %% [markdown]
# We can store values in variables, so that these can be used later.  Here is an example of a computation of a restaurant bill:

# %%
subtotal = 30.17
tax_rate = 0.0925
tip_percentage = 0.2

tax = subtotal * tax_rate
tip = subtotal * tip_percentage

total = subtotal + tax + tip

round(total, 2)

# %% [markdown]
# Note how the variable names make clear what the code does, and allows us to reused it by changing the values of `subtotal`, `tax_rate`, and `tip_percentage`.

# %% [markdown]
# Variable names can only have:
# * letters (lower and upper case),
# * numbers, and
# * the underscore `_`.
#
# Moreover, variable names *cannot* start with a number and *should* not start with the underscore (unless you are aware of the [conventions for such variable names](https://peps.python.org/pep-0008/#naming-conventions)).
#
# You should always name your variables with descriptive names to make your code more readable.
#
# You should also try to avoid variable names already used in Python, as it would override their builtin values.  For instance, names like `print`, `int`, `abs`, `round` are already used in Python, so you should not used them.
#
# (If the name appears in a green in a code cell in Jupyter, then it is already taken!)

# %% [markdown]
# ## Comments
#
# We can enter *comments* in code cells to help describe what the code is doing.  Comments are text entered in Python (e.g., in code cells) that is ignored when running the code, so it is only present to provide information about the code.
#
# Comments in Python start with `#`.  All text after a `#` and in the same line is ignored by the Python interpreter.  (By convention, we usually leave two spaces between the code and `#` and one space after it.)
#
# As an illustration, here are some comments added to our previous restaurant code:

# %%
# compute restaurant bill

subtotal = 25.63  # meal cost in dollars
tax_rate = 0.0925  # tax rate
tip_percentage = 0.2  # percentage for the tip

tax = subtotal * tax_rate  # tax amount
tip = subtotal * tip_percentage  # tip amount

# compute the total:
total = subtotal + tax + tip

# round to two decimal places
round(total, 2)

# %% [markdown]
# Note that the code above probably did not need the comments, as it was already pretty clear.  Although there is such a thing as "too many comments", it is preferable to write too many than too few comments.

# %% [markdown]
# ## String (Text)
#
# *Strings* is the name for text blocks in Python (and in most programming languages).  To have a text (or string) object in Python, we simply surround it by single quotes `' '` or double quotes `" "`:

# %%
'This is some text.'

# %%
"This is also some text!"

# %% [markdown]
# If we need quotes inside the string, we need to use the other kind to delimit it:

# %%
"There's always time to learn something new."

# %%
'Descates said: "I think, therefore I am."'

# %% [markdown]
# What if we need both kinds of quotes in a string?
#
# We can *escape the quote* with a `\` as in:

# %%
"It's well know that Descartes has said: \"I think, therefore I am.\""

# %%
'It\'s well know that Descartes has said: "I think, therefore I am."'

# %% [markdown]
# Thus, when you repeat the string quote inside of it, put a `\` before it.
#
# Note that you can *always* escape the quotes, even when not necessary.  (It will do no harm.)  In the example below, there was no need to escape the single quote, as seen above:

# %%
"It\'s well know that Descartes has said: \"I think, therefore I am.\""

# %% [markdown]
# Another option is to use *triple quotes*, i.e., to surround the text by either `''' '''` or `""" """` (and then there is no need for escaping):

# %%
'''It's well know that Descartes has said: "I think, therefore I am."'''

# %% [markdown]
# On the other hand, we cannot use `""" """` here because our original string *ends* with a `"`.  If it did not, it would also work.  We can simply add a space:

# %%
"""It's well know that Descartes has said: "I think, therefore I am." """

# %% [markdown]
# Triple quote strings can also contain *multiple lines* (unlike single quote ones):

# %%
"""First line.
Second line.

Third line (after a blank line)."""

# %% [markdown]
# The output seems a bit strange (we have `\n` in place of line breaks --- we will talk about it below), but it *prints* correctly:

# %%
multi_line_text = """First line.
Second line.

Third line (after a blank line)."""

print(multi_line_text)

# %% [markdown]
# ### Special Characters
#
# The backslash `\` is used to give special characters.  (Note that it is *not* the forward slash `/` that is used for division!)
#
# Besides producing quotes (as in `\'` and `\"`), it can also produce line breaks, as seen above.
#
# For instance:

# %%
multi_line_text = "First line.\nSecond line.\n\nThird line (after a blank line)."

print(multi_line_text)

# %% [markdown]
# We can also use `\t` for *tabs*: it gives a "stretchable space" which can be convenient to align text:

# %%
aligned_text = "1\tA\n22\tBB\n333\tCCC\n4444\tDDDD"

print(aligned_text)

# %% [markdown]
# We could also use triple quotes to make it more readable:

# %%
aligned_text = """
1 \t A
22 \t BB
333 \t CCC
4444 \t DDDD"""

print(aligned_text)

# %% [markdown]
# Finally, if we need the backslash in our text, we use `\\` (i.e., we also *escape it*):

# %%
backslash_test = "The backslash \\ is used for special characters in Python.\nTo use it in a string, we need double backslashes: \\\\."

print(backslash_test)

# %% [markdown]
# ### f-Strings
#
# [f-strings](https://docs.python.org/3/reference/lexical_analysis.html#f-strings) (or *formatted string literals*) are helpful when you want to print variables with a string.
#
# For example:

# %%
birth_year = 2008
current_year = 2025

print(f"I was born in {birth_year}, so I am {current_year - birth_year} years old.")

# %% [markdown]
# So, we need to preface our (single quoted or double quoted) string with `f` and put our expression inside curly braces `{ }`.  It can be a variable (as in `birth_year`) or an expression.
#
# f-strings also allow us to format the expressions inside braces.  (Check the [documentation](https://docs.python.org/3/reference/lexical_analysis.html#f-strings) if you want to learn more.)

# %% [markdown]
# ### String Manipulation
#
# We can concatenate string with `+`:

# %%
name = "Alice"
eye_color = "brown"

name + " has " + eye_color + " eyes."

# %% [markdown]
# Note that we could have use an f-sting in the example above:

# %%
f"{name} has {eye_color} eyes."

# %% [markdown]
# We also have *methods* to help us manipulate strings.
#
# *Methods* are functions that belong to a particular object type, like strings, integers, and floats.  The syntax is `object.method(arguments)`.  (We had already seen the method `.numerical_approx()` above!)
#
# We can convert to upper case with the `upper` method:

# %%
test_string = "abc XYZ 123"
test_string.upper()

# %% [markdown]
# Similarly, the method `lower` converts to lower case:

# %%
test_string.lower()

# %% [markdown]
# We can also spit a string into a *list* of strings (more about lists below) with `split`:

# %%
test_string.split()

# %% [markdown]
# By default, it splits on spaces, but you can give a different character as an argument to specify the separator:

# %%
"abc-XYZ-123".split("-")

# %%
"abaccaaddd".split("a")

# %% [markdown]
# ## Lists
#
# *Lists* are (ordered) sequences of Python objects.  To create at list, you surround the elements by square brackets `[ ]` and separate them with commas `,`.  For example:

# %%
list_of_numbers = [5, 7, 3, 2]

list_of_numbers

# %% [markdown]
# But lists can have elements of any type:

# %%
mixed_list = [0, 1.2, "some string", [1, 2, 3]]

mixed_list

# %% [markdown]
# We can also have an empty list (to which we can later add elements):

# %%
empty_list = []

empty_list

# %% [markdown]
# ### Ranges

# %% [markdown]
# We can also create lists of consecutive numbers using `range`.  For instance, to have a list with elements from 0 to 5 we do:

# %%
list(range(6))

# %% [markdown]
# (Technically, `range` gives an object similar to a list, but not quite the same.  Using the function `list` we convert this object to an actual list.  Most often we do *not* need to convert the object to a list in practice, though.)
#
#
# :::{warning}
#
# Note then that `list(range(n))` gives a list `[0, 1, 2, ..., n - 1]`, so it starts at `0` (and not `1`) and ends at `n - 1`, so `n` itself is *not* included!  (This is huge pitfall when first learning with Python!)
# :::
#
#
# We can also tell where to start the list (if not at 0), by passing two arguments:

# %%
list(range(3, 10))

# %% [markdown]
# In this case the list start at 3, but ends at 9 (and not 10).
#
# We can also pass a third argument, which is the *step size*:

# %%
list(range(4, 20, 3))

# %% [markdown]
# So, we start at exactly the first argument (4 in this case), skip by the third argument (3 in this case), and stop in the last number *before* the second argument (20 in this case).

# %% [markdown]
# :::{warning} Sage versus Python
#
# Sage uses a more "flexible" data type for integers than pure Python.  The `range` function gives Python integers.  If we want to obtain Sage integers, we can use `srange` (for Sage range) or `xsrange`.
# :::
#
#
# The former gives a list:

# %%
srange(10, 20)

# %% [markdown]
# The latter, like range, gives an iterator. (We will discuss iterators when we talk about loops below.)

# %%
list(xsrange(10, 20))

# %% [markdown]
# Note the different date types for the elements:

# %%
type(list(range(10, 20))[0])  # data type of first element

# %%
type(srange(10, 20)[0])  # data type of first element

# %% [markdown]
# We should use Sage integers when we want to use those for *computations*.  But we can use Python integers (which take less memory) for simple tasks, like indexing or counting.

# %% [markdown]
# ### Extracting Elements
#
# First, remember our `list_of_numbers` and `mixed_list`:

# %%
list_of_numbers

# %%
mixed_list

# %% [markdown]
# We can extract elements from a list by position.  But:
#
# :::{attention}
#
# Sage/Python count **from 0** and not 1.
# :::
#
# So, to extract the first element of `list_of_numbers` we do:

# %%
list_of_numbers[0]

# %% [markdown]
# To extract the second:

# %%
list_of_numbers[1]

# %% [markdown]
# We can also count from the end using *negative indices*.  So, to extract the last element we use index `-1`:

# %%
mixed_list[-1]

# %% [markdown]
# The element before last:

# %%
mixed_list[-2]

# %% [markdown]
# To extract the `2` from `[1, 2, 3]` in `mixed_list`:

# %%
mixed_list[3][1]

# %% [markdown]
# (`[1, 2, 3]` is at index `3` of `mixed_list`, and `2` is at index `1` of `[1, 2, 3]`.)

# %% [markdown]
# ### Slicing
#
# We can get sublists from a list using what is called *slicing*.  For instance, let's start with the list:

# %%
list_example = list(range(5, 40, 4))

list_example

# %% [markdown]
# If I want to get a sublist of `list_example` starting at index 3 and ending at index 6, we do:

# %%
list_example[3:7]

# %% [markdown]
# :::{warning}
#
# **Note we used 7 instead of 6!**  Just like with ranges, we stop *before* the second number.
# :::
#
# If we want to start at the beginning, we can use 0 for the first number, or simply omit it altogether:

# %%
list_example[0:5]  # first 5 elements -- does not include index 5

# %%
list_example[:5]  # same as above

# %% [markdown]
# Omitting the second number, we go all the way to the end:

# %%
list_example[-3:]

# %% [markdown]
# We can get the length of a list with the function `len`:

# %%
len(list_example)

# %% [markdown]
# So, although wasteful (and not recommended) we could also do:

# %%
list_example[4:len(list_example)]  # all elements from index 4 until the end

# %% [markdown]
# :::{note}
#
# Note that the last valid index of the list is `len(list_example) - 1`, and *not* `len(list_example)`, since, again, we start counting from 0 and not 1.
# :::

# %% [markdown]
# We can also give a step size for the third argument, similar to `range`:

# %%
new_list = list(range(31))

new_list

# %%
new_list[4:25:3]  # from index 4 to (at most) 24, with step size of 3

# %% [markdown]
# ### Changing a List
#
# We can also *change elements* in a list.
#
# First, recall our `list_of_numbers`:

# %%
list_of_numbers

# %% [markdown]
# If then, for instance, we want to change the element at index 2 in `list_of_numbers` (originally a 3) to a 10, we can do:

# %%
list_of_numbers[2] = 10

list_of_numbers

# %% [markdown]
# We can add an element to the end of a list using the `append` *method*.  So, to add $-1$ to the end of `list_of_numbers`, we can do:

# %%
list_of_numbers.append(-1)

list_of_numbers

# %% [markdown]
# :::{warning}
#
# Note that `append` *changes the original list* and *returns no output*!
# :::

# %%
new_list = list_of_numbers.append(100)
new_list

# %% [markdown]
# No output?  Well, there is *nothing* saved in `new_list`, since `.append` does not give any output.  It did change `list_of_numbers`, though:

# %%
list_of_numbers

# %% [markdown]
# We can sort with the `sort` method:

# %%
list_of_numbers.sort()

list_of_numbers

# %% [markdown]
# (Again, it *changes the list and returns no output*!)

# %% [markdown]
# To sort in reverse order, we can use the optional argument `reverse=True`:

# %%
list_of_numbers.sort(reverse=True)

list_of_numbers

# %% [markdown]
# We can reverse the order of elements with the `reverse` method.  (This method does *no sorting at all*, it just reverse the whole list in its given order.)

# %%
mixed_list

# %%
mixed_list.reverse()

mixed_list

# %% [markdown]
# We can remove elements with the `pop` method.  By default it removes the last element of the list, but you can also pass it the index of the element to removed.
#
# `pop` changes the original list *and* returns the element removed!

# %%
list_of_numbers

# %%
removed_element = list_of_numbers.pop()  # remove last element

removed_element

# %%
list_of_numbers  # the list was changed!

# %%
removed_element = list_of_numbers.pop(1)  # remove element at index 1

removed_element

# %%
list_of_numbers  # again, list has changed!

# %% [markdown]
# ### List and Strings
#
# One can think of strings as (more or less) lists of characters.  (This is not 100% accurate, as we will see, but it is pretty close.)
#
# So, many of the operations we can do with list, we can also do with strings.
#
# For instance, we can use `len` to find the lenght (or number of characters) of a string:

# %%
quote = "I think, therefore I am."

len(quote)

# %% [markdown]
# We can also extract elements by index:

# %%
quote[3]  # 4th character

# %% [markdown]
# And, we can slice a string:

# %%
quote[2:20:3]

# %% [markdown]
# Conversely, just as we could concatenate strings with `+`, we can concatenate lists with `+`:

# %%
[1, 2, 3] + [4, 5, 6, 7]

# %% [markdown]
# :::{note}
#
# The crucial difference is that **we cannot change a string** (like we can change a list).
# :::
#
# If, for instance, you try
#
# ```python
# quote[3] = "X"
# ```
#
# you get an error.

# %% [markdown]
# Finally, if we have a list of strings, we can join them with the *string* method `join`.  (It is not a *list* method.)  The string in question is used to *separate* the strings in the list.  For instance:

# %%
list_of_strings = ["all", "you", "need", "is", "love"]

" ".join(list_of_strings)

# %%
"---".join(list_of_strings)

# %%
"".join(list_of_strings)

# %% [markdown]
# ### Multiple Assignments

# %% [markdown]
# When we want to assign multiple variable to elements of a list, we can do it directly with:

# %%
a, b, c = [1, 2, 3]
print(f"{a = }")  # shortcut for print(f"a = {a}")
print(f"{b = }")
print(f"{c = }")

# %% [markdown]
# In fact, we can simply do:

# %%
a, b, c = 1, 2, 3
print(f"{a = }")
print(f"{b = }")
print(f"{c = }")

# %% [markdown]
# This gives us a neat trick so exchange values between variables.  Say I want to swap the values of `a` and `b`.  Here is the most common way to this.  (We need a temporary variable!)

# %%
print(f"{a = }")
print(f"{b = }")

print("\nNow, switch!\n")

# perform the switch
old_a = a  # store original value of
a = b  # set a to the value of b
b = old_a  # set b to the original value of a

print(f"{a = }")
print(f"{b = }")

# %% [markdown]
# But in Sage/Python, we can simply do:

# %%
print(f"{a = }")
print(f"{b = }")

print("\nNow, switch!\n")

# perform the switch
a, b = b, a  # values on the *right* are the old/original!

print(f"{a = }")
print(f"{b = }")

# %% [markdown]
# ## Dictionaries
#
# *Dictionaries* are used to store data that can be retrieve from a *key*, instead of from position.  (In principle, a dictionary has no order!)  So, to each *key* (which must be unique) we have an associate *value*.
#
# You can think of a real dictionary, where you look up definitions for a word.  In this example the keys are the words, and the values are the definitions.
#
# In Python's dictionaries we have the key/value pairs surrounded by curly braces `{ }` and separated by commas `,`, and the key/value pairs are separated by a colon `:`.
#
# For instance, here is a dictionary with the weekdays in French:

# %%
french_days = {
    "Sunday": "dimanche",
    "Monday": "lundi",
    "Tuesday": "mardi",
    "Wednesday": "mercredi",
    "Thursday": "jeudi",
    "Friday": "vendredi",
    "Saturday": "samedi",
}

french_days

# %% [markdown]
# (Here the keys are the days in English, and to each key the associate value is the corresponding day in French.)
#
#
# Then, when I want to look up what is Thursday in French, I can do:

# %%
french_days["Thursday"]

# %% [markdown]
# As another example, we can have a dictionary that has all the grades (in a list) o students in a course:

# %%
grades = {"Alice": [89, 100, 93], "Bob": [78, 83, 80], "Carl": [85, 92, 100]}

grades

# %% [markdown]
# To see Bob's grades:

# %%
grades["Bob"]

# %% [markdown]
# To get the grade of Carl's second exam:

# %%
grades["Carl"][1]

# %% [markdown]
# ### Adding/Changing Entries

# %% [markdown]
# We can also add a pair of key/value to a dictionary.  For instance, to enter Denise's grades, we can do:

# %%
grades["Denise"] = [98, 93, 100]

grades

# %% [markdown]
# We can also change the values:

# %%
grades["Bob"] = [80, 85, 77]

grades

# %% [markdown]
# Or, to change a single grade:

# %%
grades["Alice"][2] = 95

grades

# %% [markdown]
# We can use `pop` to remove a pair of key/value by passing the corresponding key.  It returns the *value* for the given key and changes the dictionary (by removing the pair):

# %%
bobs_grades = grades.pop("Bob")

bobs_grades

# %%
grades

# %% [markdown]
# ### Membership

# %% [markdown]
# The keyword `in` checks if the value is a *key*:

# %%
french_days

# %%
"Monday" in french_days

# %%
"lundi" in french_days

# %% [markdown]
# We can test for values with `.values`.
#
# :::{warning}
#
# Checking for keys is really fast, but for values is pretty slow (relatively speaking).
# :::

# %%
"lundi" in french_days.values()

# %% [markdown]
# ## Sets

# %% [markdown]
# Besides lists and dictionaries, we also have *sets* for collections of elements.  Unlike lists, sets have *no order*.  In fact, a set (in math and in Sage/Python) is characterized by its elements, so repetitions of elements make no difference:
#
# $$
# \{1, 1, 2, 2, 2 \} = \{2, 1\}.
# $$

# %% [markdown]
# So, a trick to remove repetitions in lists is to convert it to set, and then back to a list:

# %%
my_list = [1, 1, 2, 2, 2]
my_list

# %%
set(my_list)

# %%
list(set(my_list))

# %% [markdown]
# As in math, sets are delimited by curly braces $\{ \cdots \}$:

# %%
my_set = {1, 2, 3}
my_set

# %%
my_set == {2, 1, 3, 1, 3, 2, 2}

# %% [markdown]
# Note that Python/Sage also uses curly braces for dictionaries, so it distinguishes between them by the use of `:`.  The only problem is for empty set and dictionary: `{}` gives an empty *dictionary*:

# %%
type({})

# %% [markdown]
# To create an empty set, usually denoted by $\varnothing$, we use `set()`:

# %%
set()

# %% [markdown]
# ### Membership

# %% [markdown]
# As expected, we can see if an element is in a set with the keyword `in`:

# %%
my_set = {1, 2, 3}
1 in my_set

# %%
5 in my_set

# %% [markdown]
# :::{note}
#
# Checking if something is in a set is *a lot* faster then checking if something is in a list!  So, whenever we are just keeping track of elements and need to check membership, we should use sets, not lists!
# :::

# %% [markdown]
# ### Set Operations

# %% [markdown]
# We have the usual set operations:

# %%
set_A = {1, 2, 3, 4}
set_B = {3, 4, 5, 6, 7, 8}

# %% [markdown]
# Union (members of both sets), i.e.,  $A \cup B$:

# %%
set_A.union(set_B)

# %%
set_A | set_B  # same as set_A.union(set_B)

# %% [markdown]
# Intersection (common elements), i.e., $A \cap B$:

# %%
set_A.intersection(set_B)

# %%
set_A & set_B  # same as set_A.intersection(set_B)

# %% [markdown]
# Difference (elements in the first, but not in the second), i.e., $A \setminus B$:

# %%
set_A.difference(set_B)

# %%
set_A - set_B  # same as set_A.difference(set_B)

# %% [markdown]
# We can also check for containment with `<`, `<=`, `>`, `>=`:

# %%
{1, 2} < {1, 2, 3}

# %%
{1, 2, 3} <= {1, 2, 4}

# %% [markdown]
# We can also add elements to sets:

# %%
set_A.add(100)

# %% [markdown]
# Note that, like `append` for lists, it does not give any output, but *changes* the original set:

# %%
set_A

# %% [markdown]
# We can clear/empty a set with:

# %%
set_A.clear()
set_A

# %% [markdown]
# ### Looping over Sets

# %% [markdown]
# We can also iterate over sets, but we cannot know (a priori) the order:

# %%
set_B

# %%
for element in set_B:
    print(f"{element} is in the set")

# %% [markdown]
# ## Conditionals
#
# ### Booleans
#
# Python has two reserved names for true and false: `True` and `False`.
#
# :::{attention}
#
# Note that `True` and `False` *must* be capitalized for Python/Sage to recognize them as booleans!  Using `true` and `false` does not work!
# :::
#
#
#
# For instance:

# %%
2 < 3

# %%
2 > 3

# %% [markdown]
# #### Boolean Operations
#
# One can flip their values with `not`:

# %%
not (2 < 3)

# %%
not (3 < 2)

# %%
not True

# %%
not False

# %% [markdown]
# These can also be combined with `and` and `or`:

# %%
(2 < 3) and (4 < 5)

# %%
(2 < 3) and (4 > 5)

# %%
(2 < 3) or (4 > 5)

# %%
(2 > 3) or (4 > 5)

# %% [markdown]
# :::{warning}
#
# Note that `or` is *not exclusive* (as usually in common language).
# :::
#
# In a restaurant, if an entree comes with "soup or salad", both is *not* an option.  But in math and computer science, `or` allows both possibilities being true:

# %%
(2 < 3) or (4 < 5)

# %% [markdown]
# ### Comparisons
#
# We have the following comparison operators:
#
#
# :::{table} Boolean Operations
# :align: center
# :name: tb-bool_op
#
# | **Operator** | **Description**                   |
# |--------------|-----------------------------------|
# | `==`         | Equality ($=$)                    |
# | `!=`         | Different ($\neq$)                |
# | `<`          | Less than ($<$)                   |
# | `<=`         | Less than or equal to ($\leq$)    |
# | `>`          | Greater than ($>$)                |
# | `>=`         | Greater than or equal to ($\geq$) |
# :::
#
#
# :::{warning}
#
# Note that since we use `=` to assign values to variables, we need `==` for comparisons.  *It's a common mistake to try to use `=` in a comparison, so be careful!*
# :::

# %% [markdown]
# Note that we can use
#
# ```python
# 2 < 3 <= 4
# ```
#
# as a shortcut for
#
# ```python
# (2 < 3) and (3 <= 4)
# ```

# %%
2 < 3 <= 4

# %%
2 < 5 <= 4

# %% [markdown]
# #### String Comparisons
#
# Note that these can also be used with other objects, such as strings:

# %%
"alice" == "alice"

# %%
"alice" == "bob"

# %% [markdown]
# It's case sensitive:

# %%
"alice" == "Alice"

# %% [markdown]
# The inequalities follow *dictionary order*:

# %%
"aardvark" < "zebra"

# %%
"giraffe" < "elephant"

# %%
"car" < "care"

# %% [markdown]
# But note that capital letters come earlier than all lower case letters:

# %%
"Z" < "a"

# %%
"aardvark" < "Zebra"

# %% [markdown]
# :::{tip}
#
# A common method when we don't care about case in checking for dictionary order, is to use the string method `.lower` for both strings.
# :::
#
# For instance:

# %%
string_1 = "aardvark"
string_2 = "Zebra"

string_1 < string_2  # capitalization has effect!

# %%
string_1.lower() < string_2.lower()  # capitalization has no effect!

# %% [markdown]
# ### Methods that Return Booleans
#
# We have functions/methods that return booleans.
#
# For instance, to test if a string is made of lower case letters:

# %%
test_string = "abc"

test_string.islower()

# %%
test_string = "aBc"

test_string.islower()

# %%
test_string = "abc1"

test_string.islower()

# %% [markdown]
# Here some other methods for strings:
#
# :::{table} String Methods
# :align: center
# :widths: auto
# :width: 100 %
# :name: tb-string_methods
#
# | **Method**   | **Description**                                  |
# |--------------|--------------------------------------------------|
# | `is_lower`   | Checks if all letters are lower case             |
# | `is_upper`   | Checks if all letters are upper case             |
# | `is_alnum`   | Checks if all characters are letters and numbers |
# | `is_alpha`   | Checks if all characters are letters             |
# | `is_numeric` | Checks if all characters are numbers             |
# :::

# %% [markdown]
# ### Membership
#
# We can test for membership with the keywords `in`:

# %%
2 in [1, 2, 3]

# %%
5 in [1, 2, 3]

# %%
1 in [0, [1, 2, 3], 4]

# %%
[1, 2, 3] in [0, [1, 2, 3], 4]

# %% [markdown]
# It also work for strings:

# %%
"vi" in "evil"

# %%
"vim" in "evil"

# %% [markdown]
# Note the the character must appear together:

# %%
"abc" in "axbxc"

# %% [markdown]
# We can also write `not in`.  So
#
# ```python
# "vim" not in "evil"
# ```
#
# is the same as
#
# ```python
# not ("vim" in "evil")
# ```

# %%
"vim" not in "evil"

# %% [markdown]
# ## if-Statements
#
# We can use conditionals to decide what code to run using *if-statements*:

# %%
water_temp = 110  # in Celsius

if water_temp >= 100:
    print("Water will boil.")

# %%
water_temp = 80  # in Celsius

if water_temp >= 100:
    print("Water will boil.")

# %% [markdown]
# The syntax is:
#
# ```
# if <condition>:
#     <code to run if condition is true>
# ```

# %% [markdown]
# :::{note}
#
# Note the indentation: all code that is indented will run when the condition is true!
# :::

# %%
water_temp = 110  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
    print("(Temperature above 100.)")

# %%
water_temp = 80  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
print("Non-indented code does not depend on the condition!")

# %% [markdown]
# We can add an `else` statement for code we want to run *only when the condition is false*:

# %%
water_temp = 110  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
else:
    print("Water will not boil.")

print("This will always be printed.")

# %%
water_temp = 80  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
else:
    print("Water will not boil.")

print("This will always be printed.")

# %% [markdown]
# We can add more conditions with `elif`, which stands for *else if*.
#
# For instance, if we want to check if the water will freeze:

# %%
water_temp = 110  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
elif water_temp <= 0:
    print("Water will freeze.")

# %%
water_temp = -5  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
elif water_temp <= 0:
    print("Water will freeze.")

# %%
water_temp = 50  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
elif water_temp <= 0:
    print("Water will freeze.")

# %% [markdown]
# Note that
#
# ```python
# if water_temp >= 100:
#     print("Water will boil.")
# elif water_temp <= 0:
#     print("Water will freeze.")
# ```
#
# is the same as
#
# ```python
# if water_temp >= 100:
#     print("Water will boil.")
# else:
#     if water_temp <= 0:
#         print("Water will freeze.")
# ```
#
# but much better to write (and read)!  And it would have been much worse if we had more `elif`'s!

# %% [markdown]
# :::{warning}
#
# Also note that if we have overlapping conditions, only the *first* to be met runs!
# :::
#
# For example:

# %%
number = 70

if number > 50:
    print("First condition met.")
elif number > 30:
    print("Second condition met, but not first")

# %%
number = 40

if number > 50:
    print("First condition met.")
elif number > 30:
    print("Second condition met, but not first")

# %%
number = 20

if number > 50:
    print("First condition met.")
elif number > 30:
    print("Second condition met, but not first")

# %% [markdown]
# We can add an `else` at the end, which will run when all conditions above it (from `if` an `elif`'s) are false:

# %%
water_temp = 110  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
elif water_temp <= 0:
    print("Water will freeze.")
else:
    print("Water will neither boil, nor freeze.")

# %%
water_temp = -5  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
elif water_temp <= 0:
    print("Water will freeze.")
else:
    print("Water will neither boil, nor freeze.")

# %%
water_temp = 40  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
elif water_temp <= 0:
    print("Water will freeze.")
else:
    print("Water will neither boil, nor freeze.")

# %% [markdown]
# We can have as many `elif`'s as we need:

# %%
water_temp = 110  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
elif water_temp >= 90:
    print("Water is close to boiling!")
elif 0 < water_temp <= 10:
    print("Water is close to freezing!")
elif water_temp <= 0:
    print("Water will freeze.")
else:
    print("Water will neither boil, nor freeze, nor it is close to either.")

# %%
water_temp = 90  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
elif water_temp >= 90:
    print("Water is close to boiling!")
elif 0 < water_temp <= 10:
    print("Water is close to freezing!")
elif water_temp <= 0:
    print("Water will freeze.")
else:
    print("Water will neither boil, nor freeze, nor it is close to either.")

# %%
water_temp = 40  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
elif water_temp >= 90:
    print("Water is close to boiling!")
elif 0 < water_temp <= 10:
    print("Water is close to freezing!")
elif water_temp <= 0:
    print("Water will freeze.")
else:
    print("Water will neither boil, nor freeze, nor it is close to either.")

# %%
water_temp = 3  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
elif water_temp >= 90:
    print("Water is close to boiling!")
elif 0 < water_temp <= 10:
    print("Water is close to freezing!")
elif water_temp <= 0:
    print("Water will freeze.")
else:
    print("Water will neither boil, nor freeze, nor it is close to either.")

# %%
water_temp = -5  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
elif water_temp >= 90:
    print("Water is close to boiling!")
elif 0 < water_temp <= 10:
    print("Water is close to freezing!")
elif water_temp <= 0:
    print("Water will freeze.")
else:
    print("Water will neither boil, nor freeze, nor it is close to either.")

# %% [markdown]
# Note that we could also have used instead
#
# ```python
# if water_temp >= 100:
#     print("Water will boil.")
# elif water_temp >= 90:
#     print("Water is close to boiling!")
# elif water_temp <= 0:
#     print("Water will freeze.")
# elif water_temp <= 10:
#     print("Water is close to freezing!")
# else:
#     print("Water will neither boil, nor freeze, nor it is close to either.")
# ```
#
# but *not*
#
# ```python
# if water_temp >= 100:
#     print("Water will boil.")
# elif water_temp >= 90:
#     print("Water is close to boiling!")
# elif water_temp <= 10:
#     print("Water is close to freezing!")
# elif water_temp <= 0:
#     print("Water will freeze.")
# else:
#     print("Water will neither boil, nor freeze, nor it is close to either.")
# ```

# %%
water_temp = -5  # should say it is freezing!

if water_temp >= 100:
    print("Water will boil.")
elif water_temp >= 90:
    print("Water is close to boiling!")
elif water_temp <= 10:
    print("Water is close to freezing!")
elif water_temp <=0:
    print("Water will freeze.")
else:
    print("Water will neither boil, nor freeze, nor it is close to either.")

# %% [markdown]
# ## for Loops
#
# We can use *for-loops* for repeating tasks.
#
# Let's show its use with an example.
#
# ### Loops with `range`
#
# To print *Beetlejuice* three times we can do:

# %%
for i in range(3):
    print("Beetlejuice")

# %% [markdown]
# The `3` in `range(3)` is the number of repetitions, and the indented block below the `for` line is the code to be repeated.  The `i` is the *loop variable*, but it is not used in this example.  (We will examples when we do use it soon, though.)
#
# Here `range(3)` can be thought as the list `[0, 1, 2]` (as seen above), and in each of the three times that the loop runs, the loop variable, `i` in this case, receives one of the values in this list *in order*.
#
# Let's illustrate this with another example:

# %%
for i in range(3):
    print(f"The value of i is {i}")  # print the value of i

# %% [markdown]
# So, the code above is equivalent to running:

# %%
# first iteration
i = 0
print(f"The value of i is {i}")

# second iteration
i = 1
print(f"The value of i is {i}")

# third iteration
i = 2
print(f"The value of i is {i}")

# %% [markdown]
# Here the `range` function becomes quite useful (and we should not surround it by `list`!).  For instance, if we want to add all even numbers, between 4 and 200 (both inclusive), we could do:

# %%
total = 0  # start with 0 as total

for i in range(2, 201, 2):  # note the 201 instead of 200!
    total = total + i  # replace total by its current value plus the value of i

print(total)  # print the result

# %% [markdown]
# :::{hint}
#
# It's worth observing that `total += i` is a shortcut (and more efficient than) `total = total + i`.
# :::
#
# So we could have done:

# %%
total = 0  # start with 0 as total

for i in range(2, 201, 2):  # note the 201 instead of 200!
    total += i  # replace total by its current value plus the value of i

print(total)  # print the result

# %% [markdown]
# Let's now create a list with the first $10$ perfect squares:

# %%
squares = []  # start with an empty list

for i in range(10):  # i = 0, 1, 2, ... 9
    squares.append(i^2)  # add i^2 to the end of squares

squares

# %% [markdown]
# ### Loops with Lists
#
# One can use any list instead of just `range`.  For instance:

# %%
languages = ["Python", "Java", "C", "Rust", "Julia"]

for language in languages:
    print(f"{language} is a programming language.")

# %% [markdown]
# The code above is equivalent to

# %%
language = "Python"
print(f"{language} is a programming language.")

language = "Java"
print(f"{language} is a programming language.")

language = "C"
print(f"{language} is a programming language.")

language = "Rust"
print(f"{language} is a programming language.")

language = "Julia"
print(f"{language} is a programming language.")

# %% [markdown]
# ### Loops with Dictionaries
#
# We can also loop over dictionaries.  In this case the loop variable receives the *keys* of the dictionary:

# %%
french_days

# %%
for day in french_days:
    print(f"{day} in French is {french_days[day]}.")

# %% [markdown]
# We could also have use `french_days.items()` which give *both* the key and value!

# %%
for day, french_day in french_days.items():
    print(f"{day} in French is {french_day}.")

# %% [markdown]
# :::{warning}
#
# Although in more recent versions of Python dictionaries keep the order in which the items were added, it is not wise to count on the ordering when looping through dictionaries.
# :::
#
#
# ### Loops with Sage Integers

# %% [markdown]
# We can loop with Sage integers using `xsrange`:

# %%
for x in xsrange(11, 31, 2):
    smallest_prime_factor = prime_divisors(x)[0]
    print(f"The smallest prime factors of {x} is {smallest_prime_factor}.")

# %% [markdown]
# (We've used the Sage function `prime_divisors` which gives an ordered list of prime divisors of the input.  Then, we take the first (and smallest) element to get the smallest prime divisor.)

# %% [markdown]
# :::{important}
#
# In loops, we should use `xsrange` instead of `srange`, as the former does not create a list (which has to be stored in memory), but outputs the next Sage integer on-demand.
# :::

# %% [markdown]
# ## while Loops
#
# While loops run while some condition is satisfied.  The syntax is
#
# ```python
# while <condition>:
#     <code to be repeated>
# ```
#
# Let's find the first integer greater than or equal to $1{,}000{,}000$ divisible by $2{,}776$ (in a not very smart way):

# %% jupyter={"outputs_hidden": false}
res = 10^6  # start with 10^6
while (res % 2776) != 0:  # % is for remainder!
    res += 1  # if it is not divisible, try next one
print(res)

# %% [markdown]
# Another way (which is like the common *until loop*):

# %%
res = 10^6
while True:  # runs until we manually stop it
    if res % 2776 == 0:  # test
        break  # found it!  stop the loop
    res += 1  # did not find it.  try the next one
print(res)

# %% [markdown]
# A smarter way:

# %% jupyter={"outputs_hidden": false}
# remember that // is the quotient, so the fraction rounded down
2776 * (1000000 // 2776 + 1)

# %% [markdown]
# Note that `//` give the quotient of the long division.  But note it would not work if the division were exact.  Here is a way when we want to the first divisor *greater than or equal to* $1{,}000{,}000$:

# %% jupyter={"outputs_hidden": false}
2776 * ceil(1000000 / 2776)

# %% [markdown]
# Add the first $100$ composite (i.e., non-prime) numbers greater than or equal to $20$:

# %% jupyter={"outputs_hidden": false}
total = 0  # result
count = 0  # number of composites so far
number = 20  # number to be added if composite
while count < 100:
    if not is_prime(number):  # using Sage's is_prime function!
        total += number
        count += 1
    number += 1  # move to next number
print(total)

# %% [markdown]
# ### List Comprehensions
#
# Python has a shortcut to create lists that we would usually created with a for loop.  It is easier to see how it works with a couple of examples.
#
# Suppose we want to create a list with the first ten positive cubes.  We can start with an empty list and add the cubes in a loop, as so:

# %%
# empty list
cubes = []

for i in xsrange(1, 11):
    cubes.append(i^3)

cubes

# %% [markdown]
# Using *list comprehension*, we can obtain the same list with:

# %%
cubes = [i^3 for i in xsrange(1, 11)]

cubes

# %% [markdown]
# Here is a more complex example.  Suppose we want to create a list of lists like:
#
# ```python
# [[1],
#  [1, 2],
#  [1, 2, 3],
#  [1, 2, 3, 4],
#  [1, 2, 3, 4, 5]]
# ```
#
# To do that, we need *nested* for loops:

# %%
nested_lists = []

for i in range(1, 6):
    inner_list = []
    for j in range(1, i + 1):
        inner_list.append(j)
    nested_lists.append(inner_list)

nested_lists

# %% [markdown]
# (Note that we could have replaced the inner loop with `inner_list = list(range(1, i + 1)`, but let's keep the loops to illustrate the mechanics of the process of changing from loops to list comprehensions.)
#
# Here is how we can do it using list comprehension:

# %%
nested_lists = [[j for j in range(1, i + 1)] for i in range(1, 6)]

nested_lists

# %% [markdown]
# We can also add *conditions* to when we add an element to our list.  For instance, let's create a list with all positive integers between $1$ and $30$ that are prime (using Sage's `is_prime` function):

# %%
[x for x in xsrange(1, 31) if is_prime(x)]

# %% [markdown]
# That is the same (but easier to write and read) than:

# %%
res = []
for x in xsrange(1, 31):
    if is_prime(x):
        res.append(x)
res

# %% [markdown]
# The notation for list comprehensions are similar to math notation for sets.  For instance, the set
#
# $$
# \{ x \in \{1, 2, \ldots, 31\} \; : \; \text{$x$ is prime} \}
# $$
#
# is the set
#
# $$
# \{2, 3, 5, 7, 11, 13, 17, 19, 23, 29\}.
# $$

# %% [markdown]
# ## More on Loops

# %% [markdown]
# In most computer languages, when we need to loop over elements of a list, you would have to do something like:
#
# ```python
# for i in range(len(my_list)):
#     print(f"The element is {my_list[i]}")  # get the element from the list
# ```
#
# As we've seen, in Sage/Python, we can loop over the lists directly:
#
# ```python
# for element in my_list:
#     print(f"The element is {element}")
# ```
#
# In general it is said that one (almost) never should use
#
# ```python
# for i in range(len(my_list)):
#    ...
# ```
#
# as there is usually a better way.  Let's some of these.

# %% [markdown]
# ### Loop with Two Variables

# %% [markdown]
# If we have a list with lists of length two as elements, we can loop over each pair:

# %%
double_list = [[1, 2], [3, 4], [5, 6]]

for x, y in double_list:
    print(f"x = {x}, y = {y}")

# %% [markdown]
# ### Loop over Multiple Lists

# %% [markdown]
# We can loop over two (or more) lists using `zip`:

# %%
list_a = [1, 2, 3]
list_b = ["a", "b", "c"]

for x, y in zip(list_a, list_b):
    print(f"x = {x}, y = {y}")

# %% [markdown]
# ### Loop over Element and Index

# %% [markdown]
# If we need to have both the element and the index, we can use `enumerate`:

# %%
primes_list = [2, 3, 5, 7]

for i, prime in enumerate(primes_list):
    # i: index
    # prime: element
    print(f"Prime number {i + 1} is {prime}")

# %% [markdown]
# ## Functions
#
# You are probably familiar with functions in mathematics.  For instance, if $f(x) = x^2$, then $f$ take some number $x$ as its *input* and returns its square $x^2$ as the *output*.  So,
#
# $$
# \begin{align*}
#   f(1) &= 1^2 = 1, && \text{(input: $1$, output: $1$)}; \\
#   f(2) &= 2^2 = 4, && \text{(input: $2$, output: $4$)}; \\
#   f(3) &= 3^2 = 9, && \text{(input: $3$, output: $9$)}; \\
#   f(4) &= 4^2 = 16, && \text{(input: $4$, output: $16$)}.
# \end{align*}
# $$

# %% [markdown]
# We can do the same in Python:

# %%
def square(x):
    return x ** 2

# %% [markdown]
# Here is a brief description of the syntax:
#
# * `def` is the keyword that tell Python we are *defining* a function;
# * `square` is the name of the function we chose (it has the same requirements as variable names);
# * inside the parentheses after the name come the parameter(s), i.e., the inputs of the function, in this case only `x`;
# * indented comes the code that runs when the function is called;
# * `return` gives the value that will be returned by the function, i.e., the output.
#
# Now to run, we just use the name with the desired input inside the parentheses:

# %%
square(1)

# %%
square(2)

# %%
square(3)

# %%
square(4)

# %% [markdown]
# It is *strongly recommended* that you add a *docstring* describing the function right below its `def` line.  We use triple quotes for that:

# %%
def square(x):
    """
    Given a value x, returns its square x ** 2.

    INPUT:
    x: a number.

    OUTPUT:
    The square of the input.
    """
    return x ** 2

# %% [markdown]
# It does not affect how the function works:

# %%
square(3)

# %% [markdown]
# But it allows whoever reads the code for the function to understand what it does.  (This might be *you* after a few days not working on the code!)
#
# It also allows anyone to get help for the function:

# %%
help(square)

# %% [markdown]
# Functions are like mini-programs.  For instance, remember the code to compute a restaurant bill:

# %%
# compute restaurant bill

subtotal = 25.63  # meal cost in dollars
tax_rate = 0.0925  # tax rate
tip_percentage = 0.2  # percentage for the tip

tax = subtotal * tax_rate  # tax amount
tip = subtotal * tip_percentage  # tip amount

# compute the total:
total = subtotal + tax + tip

# round to two decimal places
round(total, 2)

# %% [markdown]
# We can turn it into a function!  We can pass `subtotal`, `tax_rate`, and `tip_percentage` as arguments, and get the total.
#
# Here is how it is done:

# %%
def restaurant_bill(subtotal, tax_rate, tip_percentage):
    """
    Given the subtotal of a meal, tax rate, and tip percentage, returns
    the total for the bill.

    INPUTS:
    subtotal: total cost of the meal (before tips and taxes);
    tax_rate: the tax rate to be used;
    tip_percentage: percentage of subtotal to be used for the tip.

    OUTPUT:
    Total price of the meal with taxes and tip.
    """
    tax = subtotal * tax_rate  # tax amount
    tip = subtotal * tip_percentage  # tip amount

    # compute the total:
    total = subtotal + tax + tip

    # return total rounded to two decimal places
    return round(total, 2)

# %% [markdown]
# So, `restaurant_bill(25.63, 0.0925, 0.2)` should return the same value as above, `33.13`:

# %%
restaurant_bill(25.63, 0.0925, 0.2)

# %% [markdown]
# But now we can use other values, without having to type all the code again.  For instance, if the boll was $\$30$, tax rate is $8.75\%$, and we tip $18\%$, our bill comes to:

# %%
restaurant_bill(30, 0.0875, 0.18)

# %% [markdown]
# ### Default Values
#
# If we the tax rate and tip percentages don't usually change, we can set some default values for them in our function.
#
# For instance, let's assume that the tax rate is usually $9.25\%$ and the tip percentage is $20\%$.  We just set these values in the declaration of the function.  I also change the docstring to reflect the changes, but the rest remains the same.

# %%
def restaurant_bill(subtotal, tax_rate=0.0925, tip_percentage=0.2):
    """
    Given the subtotal of a meal, tax rate, and tip percentage, returns
    the total for the bill.

    INPUTS:
    subtotal: total cost of the meal (before tips and taxes);
    tax_rate: the tax rate to be used;
              default value: 0.0925 (9.25%);
    tip_percentage: percentage of subtotal to be used for the tip;
                    default value: 0.2 (20%).

    OUTPUT:
    Total price of the meal with taxes and tip.
    """
    tax = subtotal * tax_rate  # tax amount
    tip = subtotal * tip_percentage  # tip amount

    # compute the total:
    total = subtotal + tax + tip

    # return total rounded to two decimal places
    return round(total, 2)

# %% [markdown]
# Now, every time I use the default values, we can omit them:

# %%
restaurant_bill(25.63)

# %% [markdown]
# But I still can change them!  If I want to give a tip of $22\%$, I can do:

# %%
restaurant_bill(25.63, tip_percentage=0.22)

# %% [markdown]
# And if I am at a different state, where the tax rate is $8.75\%$:

# %%
restaurant_bill(25.63, tax_rate=0.0875)

# %% [markdown]
# And I can alter both, of course:

# %%
restaurant_bill(30, tax_rate=0.0875, tip_percentage=0.18)

# %% [markdown]
# ### Lambda (or Nameless) Functions
#
# We can create simple one line functions with a shortcut, using the `lambda` keyword.
#
# For instance, here is how we can create the `square` function from above with:

# %%
square = lambda x: x ** 2

# %% [markdown]
# Here is a description of the syntax:
#
# * `square =` just tells to store the result of the expression following `=` into the variable `square` (as usual).  In this case, the expression gives a *function*.
# * `lambda` is the keyword that tells Python we are creating a (lambda) function.
# * What comes before the `:` are the arguments of the function (only `x` in this case).
# * What comes after the `:` is what the function returns (`x ** 2` in this case).  (It must be a single line, containing what would come after `return` in a regular function.)
#
# Again, except for the docstring, which we *cannot* add with lambda functions, the code is equivalent to what we had before for the `square` function.

# %%
square(3)

# %%
square(4)

# %% [markdown]
# Here is another example, with two arguments:

# %%
average_of_two = lambda x, y: (x + y) / 2

# %%
average_of_two(3, 7)

# %%
average_of_two(5, 6)

# %% [markdown]
# **Note:** The most common use for lambda functions is to create functions that we pass *as arguments to other functions or methods*.
#
# In this scenario, we do not need to first create a function with `def`, giving it a name, and then pass this name as the argument of the other function/method.  We can simply create the function *inside the parentheses of the argument of the function*.  Thus, we do not need to name this function in the argument, which is why we sometimes call these lambda functions *nameless*.
#
# Here is an example.  Let's create a list with some random words:

# %%
words = ["Luis", "is", "the", "best", "teacher"]

# %% [markdown]
# We can sort it with `.sort`:

# %%
words.sort()
words

# %% [markdown]
# By default, it sorts alphabetically, but again, because of the capital `L`, `Luis` comes first.  We can deal with that using the `key=` optional argument of sort.  You can pass a *function* to the `key` argument, and then Sage/Python sorts the list based on the output of this function!
#
# So, we can create a function that "lowercases" the words, and then the sorting will not consider cases anymore:

# %%
def lower_case(word):
    return word.lower()

words.sort(key=lower_case)  # no parentheses!
words

# %% [markdown]
# Note that `Luis` is still capitalized, as the function is only used for *comparison* between elements!
#
# So, to see if `best` comes before or after `Luis` (with `key=lower_case`), we test
#
# ```python
# lower_case("best") < lower_case("Luis")
# ```
# If `True`, `best` does come before `Luis`, if `False`, it comes after.
#
# The elements themselves are not changed.

# %% [markdown]
# But note that our function is quite simple and only used for this sorting.  So, instead of creating it with `def`, we can use a lambda function instead!

# %%
words = ["Luis", "is", "the", "best", "teacher"]  # reset the list
words.sort(key=lambda word: word.lower())
words

# %% [markdown]
# Or, if we want to sort words by the *last letter*:

# %%
words = ["Luis", "is", "the", "best", "teacher"]  # reset the list
words.sort(key=lambda word: word[-1])
words

# %% [markdown]
# If we want to sort students in the `grades` dictionary by their score in the second exam:

# %%
grades

# %%
names = list(grades.keys())
names

# %%
names.sort(key=lambda name: grades[name][1])
names

# %% [markdown]
# ### Typing (Type Annotations)

# %% [markdown]
# Sage/Python does not enforce any type (class) declaration, as some functions.  But we can add it do the definition of the function to help the user know the expected types.
#
# Moreover, if your code editor uses a Python [server language protocol](https://en.wikipedia.org/wiki/Language_Server_Protocol) to check your code, then it can show when you are using the wrong type.

# %% [markdown]
# As a simple example, consider the function that repeats a given string a certain number of times:

# %%
def repeat_string(string, n_repetitions):
    return n_repetitions * string

repeat_string("nom", 3)

# %% [markdown]
# We can give types for the variables and output like this:

# %%
def repeat_string(string: str, n_repetitions: int) -> str:
    return n_repetitions * string

# %% [markdown]
# These annotations (the `: str`, `: int`, and `-> str`) does not affect the code at all (it is not enforced!):

# %%
repeat_string(10, 2)

# %%
repeat_string("nom", 3)

# %% [markdown]
# But, it is helpful to someone reading the code, and for some code editors, the line
#
# ```python
# repeat_string(10, 2)
# ```
#
# would be highlighted since it was expecting a string for the first argument.

# %% [markdown]
# This is not a big deal and I probably won't use it here (as it is more complicated for Sage, and we don't really need it), but you might see this often when reading Python code.

# %% [markdown]
# ## Some Useful Number Theory Functions
#
# Primality test:

# %% jupyter={"outputs_hidden": false}
is_prime(7)

# %% [markdown]
# Factorization:

# %% jupyter={"outputs_hidden": false}
factor(79462756279465971297294612)

# %% [markdown]
# Next prime after $1{,}000{,}000$:

# %% jupyter={"outputs_hidden": false}
next_prime(1_000_000)

# %% [markdown]
# :::{hint}
#
# Note that the `_` between digits of a number are ingonred by Sage/Python.  We can use them to help us see where the decimal commas would be in the number.
# :::
#
# Note that if the number itself is prime, it still checks for the *next* one:

# %%
next_prime(7)

# %% [markdown]
# List of primes greater than 10 and less than (and *not* equal to) 100:

# %% jupyter={"outputs_hidden": false}
prime_range(10, 100)

# %% [markdown]
# Note that this actually creates the *list*.  To have something like `range`, which is better for iterations, use `primes`:

# %% jupyter={"outputs_hidden": false}
primes(100)

# %% jupyter={"outputs_hidden": false}
list(primes(100))

# %%
for p in primes(100):
    print(f"{p} is prime")

# %% [markdown]
# If you want the first $100$ primes (and not the primes less than $100$) you can do, we can use `Primes()`:

# %%
Primes()[0:100]

# %% [markdown]
# You can think of `Primes()` as the "ordered" set of all primes.

# %% [markdown]
# As another example, here is the sum of all primes less than $100$ that when divided by 4 have remainder 1:

# %% jupyter={"outputs_hidden": false}
res = 0
for p in primes(100):
    if p % 4 == 1:
        res += p
print(res)

# %% [markdown]
# Here is an alternative (and better) way, showing the "if" construct inside lists/vectors:

# %% jupyter={"outputs_hidden": false}
sum([p for p in primes(100) if p % 4 == 1])

# %% [markdown]
# This list inside `sum` is constructed similarly to:
# $$
# \{ p \in P \; : \; p \equiv 1 \pmod{4} \}.
# $$
# where $P$ is the set of primes between $2$ and $99$.

# %% [markdown]
# Even better, we can use generators too:

# %%
sum(p for p in primes(100) if p % 4 == 1)

# %% [markdown]
# Here is the sum of the *first* $100$ primes that have remainder $1$ when divided by $4$, using a `while` loop:

# %% jupyter={"outputs_hidden": false}
res = 0  # result
count = 0  # number of primes
p = 2  # current prime
while count < 100:
    if p % 4 == 1:
        res += p  # add prime to result
        count += 1  # increase the count
    p = next_prime(p)  # go to next prime
print(res)

# %% [markdown]
# List of divisors and prime divisors:

# %% jupyter={"outputs_hidden": false}
a = 2781276
divisors(a), prime_divisors(a), factor(a)

# %% [markdown]
# Note that despite the formatted output, `factor` gives a "list" of prime factors and powers.  This means that `factor` gives a list of pairs, and each pair contains a prime and its corresponding power in the factorization:

# %% jupyter={"outputs_hidden": false}
for p, n in factor(100430):  # note the double loop variables!
    print(f"{p}^{n}")

# %%
factor(100430)

# %% [markdown]
# Let's find the number of primes less than some given number `a`:

# %% jupyter={"outputs_hidden": false}
a = 10_000_000

# %% [markdown]
# Let's time it as well, by adding `%%time` on top of the code cell:

# %% jupyter={"outputs_hidden": false}
# %%time
count = 0
for n in xsrange(a):
    if is_prime(n):
        count += 1
print(count)

# %% [markdown]
# A better way:

# %% jupyter={"outputs_hidden": false}
# %%time
len(prime_range(a))

# %% [markdown]
# The problem with this way is that we create a long list `prime_range(a)` (which we must store in memory) and then take its length.  (So, it uses a lot of memory, and little CPU.  The previous one was the opposite.)

# %% [markdown]
# Another way, which is faster then the first way (although not as fast as the second) and also uses little memory:

# %%
# %%time
p = 2
count = 0
while p < a:
    count += 1
    p = next_prime(p)
print(count)

# %% [markdown]
# This is virtually the same as the one before:

# %%
# %%time
count = 0
for p in Primes():
    if p >= a:
        break
    count += 1
print(count)

# %% [markdown]
# Or, the best way, is to use Sage's own `prime_pi`:

# %% jupyter={"outputs_hidden": false}
prime_pi?

# %% jupyter={"outputs_hidden": false}
# %%time
prime_pi(a)

# %% [markdown]
# *So much faster!*

# %% [markdown]
# Let's plot this function, usually denoted by $\pi(x)$, which is the number of primes less than or equal to $x$, from $0$ to $100$.

# %% jupyter={"outputs_hidden": false}
p1 = plot(prime_pi, 0, 100)
show(p1)

# %% [markdown]
# ## Data Types and Parents

# %% [markdown]
# We usually use `type` to find the data type of an element in Python:

# %%
type(1), type(1.0), type("1")

# %% [markdown]
# When dealing with numbers and other mathematical objects, a better option is to use `parent`:

# %%
parent(1), parent(1.0), parent(1/2)

# %% [markdown]
# ## Integers
#
# There are some aspects of integers in Sage that are worth observing.
#
# Sage has its own integer class/type:

# %% jupyter={"outputs_hidden": false}
parent(1)

# %% [markdown]
# These have properties are useful in mathematics and number theory in particular, when compared to pure Python integers.
#
# On the other hand, Sage also uses at times these Python integers:

# %% jupyter={"outputs_hidden": false}
for i in range(1):
    print(parent(i))

# %% [markdown]
# If you are using these integers as an index or a counter, the Python integers are just fine.  But they lack some of the properties of Sage integers.  For instance, say I want a list of integers from $1$ to $100$ which are perfect squares.  We can try:
#
# ```python
# [x for x in range(101) if x.is_square()]
# ```
#
# but we would get an error:
#
# ```
# AttributeError: 'int' object has no attribute 'is_square'
# ```

# %% [markdown]
# (Note that this corresponds to the set $\{x \in \{0, 1, \ldots, 100\} \; : \; x \text{ is a square.}\}$.)

# %% [markdown]
# The problem here is that the Python integer class `int` does not have the `.is_square` method, only the Sage integer class `Integer Ring` (or `sage.rings.integer.Integer`) does.
#
# One solution is to convert the Python integer to a Sage integer:

# %% jupyter={"outputs_hidden": false}
ZZ  # a shortcut for the class of Sage integers

# %% jupyter={"outputs_hidden": false}
for i in range(1):
    print(parent(ZZ(i)))

# %% [markdown]
# Again, Sage has its own `srange` and `xsrange` for loops over Sage integers, with the former giving a list and the latter a iterable/generator (better suited for loops!).

# %% [markdown]
# So, in practice, it is probably better to use `xsrange` instead of `srange` whenever we do not just need a list:

# %% jupyter={"outputs_hidden": false}
[x for x in xsrange(101) if x.is_square()]

# %% [markdown]
# ## Random
#
# Sage has already ``random`` and ``randint``, so there is no need to import Python's ``random`` module.

# %%
a = random()
a

# %%
a = randint(2, 20)
a

# %% [markdown]
# :::{warning}
#
# Note that ``randint(x, y)`` is an integer from ``x`` to ``y`` *inclusive*, so ``y`` is a possible output.
# :::

# %% [markdown]
# On the other hand, the function `randrange(x, y)` does give random integers from `x` to `y - 1`, like `range`.

# %%
randrange(2, 20)

# %% [markdown]
# Sage also has ``choice`` (to get a random element from a list), but not ``choices`` (to get more than one element).

# %%
v = [1, 10, 11, 14, 17, 23]
a = choice(v)
a

# %% [markdown]
# If we try
#
# ```python
# w = choices(v, k=2)
# ```
# we get an error:
#
# ```
# NameError: name 'choices' is not defined
# ```

# %% [markdown]
# But we can always import it from ``random`` if we need it:

# %%
from random import choices
w = choices(v, k=2)  # choose two random elements
w

# %% [markdown]
# Note that `choices` *can* repeat elements, so it is *"with replacement"*.  If you want *"without replacement"* (so no repeated element), you can use `sample` (already in Sage):

# %%
sample(list(range(20)), k=3)

# %% [markdown]
# ## More Math with Sage

# %% [markdown]
# Sage (and not Python in general) can do a lot more math!

# %% [markdown]
# ### Graphing

# %% [markdown]
# Let's graph $y = \sin(x)$ for $x$ between $0$ and $3\pi$:

# %%
x = var("x")  # we would not need this if we hadn't assigned x a value before
plot(sin(x), (x, 0, 3 * pi))

# %% [markdown]
# Or $z = \cos(x^2y)$ for $x \in [0, \pi]$, $y \in [0, 2\pi]$:

# %%
y = var("y")
plot3d(cos(x^2 * y), (x, 0, pi), (y, 0, 2*pi))

# %% [markdown]
# ### Calculus

# %% [markdown]
# We can do calculus.  For instance, let's compute the limit:
#
# $$
# \lim_{x \to 0} \frac{\sin(2x)}{\tan(3x)}:
# $$

# %%
limit(sin(2*x)/tan(3*x), x=0)

# %% [markdown]
# We can do derivatives, for instance
#
# $$
# \frac{\mathrm{d}}{\mathrm{d}x} \frac{\ln(x^2)}{x+1}:
# $$

# %%
derivative(ln(x^2)/(x + 1), x)

# %% [markdown]
# Sage can even print it nicely:

# %% jupyter={"outputs_hidden": false}
show(derivative(ln(x^2)/(x+1), x))

# %% [markdown]
# We can do indefinite integrals, for instance,
#
# $$
# \int \ln(x) \cdot x \; \mathrm{d}x:
# $$

# %%
show(integral(ln(x)*x, x))

# %% [markdown]
# Or definite integrals, for instance:
# $$\int_{2}^{10} \ln(x) \cdot x \; \mathrm{d}x:$$

# %%
integral(ln(x)*x, (x, 2, 10))

# %% [markdown]
# If we want the numerical approximation:

# %%
numerical_approx(_)  # _ uses the last output!

# %% [markdown]
# When the function is not integrable in elementary terms (no easy anti-derivative) we can use `numerical_integral` to get numerical values for a definite integral.  For instance, for
#
# $$
# \int_1^2 \mathrm{e}^{x^2} \mathrm{d} x:
# $$

# %%
numerical_integral(exp(x^2), 1, 2)

# %% [markdown]
# This means that the integral is about $14.989976019600048$ and the error estimated to be about $1.664221651553893 \cdot 10^{-13}$, which means that the previous estimation is correct up to $12$ decimal places!

# %% [markdown]
# ### Linear Algebra

# %% [markdown]
# We can also do linear algebra:

# %%
matrix_a = matrix(
    QQ,  # entries in QQ, the rationals
    3,  # 3 by 3
    [-1, 2, 2, 2, 2, -1, 2, -1, 2]  # entries
)

matrix_a

# %%
parent(matrix_a)

# %% [markdown]
# We can make Sage print the matrix with "nice" math formatting with `show`:

# %%
show(matrix_a)

# %% [markdown]
# If we want the $\LaTeX{}$ code for it:

# %%
latex(matrix_a)

# %% [markdown]
# Let's create another matrix:

# %%
matrix_b = matrix(
    QQ,  # entries in QQ, the rationals
    3,  # 3  rows
    4,  # 4 columns
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]  # entries
)
show(matrix_b)

# %% [markdown]
# We can compute products of matrices:

# %%
show(matrix_a * matrix_b)

# %% [markdown]
# Determinants:

# %%
matrix_a.determinant()

# %% [markdown]
# Inverses:

# %%
show(matrix_a^(-1))

# %% [markdown]
# Characteristic polynomial:

# %%
matrix_a.characteristic_polynomial()

# %% [markdown]
# Eigenvalues:

# %%
matrix_a.eigenvalues()

# %% [markdown]
# Eigenspaces:

# %%
matrix_a.eigenspaces_left()

# %% [markdown]
# As we can see (if we know/remember Math 251/257), the matrix is diagonalizable:

# %%
matrix_a.is_diagonalizable()

# %% [markdown]
# Here is the diagonal form and the change of bases matrix:

# %%
matrix_a.diagonalization()

# %% [markdown]
# Rank and nullity:

# %%
matrix_b.rank()

# %%
matrix_b.nullity()

# %% [markdown]
# ### Differential Equations

# %% [markdown]
# We can also solve differential equations.  For instance, to solve
# $$
# y' + y  = 1
# $$
#
# (where $y=y(x)$ is a function on $x$ and $y'$ its derivative):

# %%
x = var("x")  # x is the variable
y = function("y")(x)  # y is a function on x
desolve(diff(y, x) + y - 1, y)  # find solution(s) y

# %% [markdown]
# Note that the `_C` is for an arbitrary constant.  If we have initial conditions, say, $y(10) = 2$, we can pass it to `desolve` with `ics` to get an exact solution:

# %%
desolve(diff(y, x) + y - 1, y, ics=[10, 2])

# %% [markdown]
# Note that it simplifies to
# $$
# y(x) = \mathrm{e}^{10-x} + 1.
# $$

# %% [markdown]
# Here is a second order differential equation, for example:
# $$
# y'' - y = x:
# $$

# %% [markdown]
# Here is a second order differential equation:

# %%
x = var("x")
y = function("y")(x)
de = diff(y, x, 2) - y == x  # the differential equation
desolve(de, y)  # solve it!

# %% [markdown]
# Here `_K1` and `_K2` are arbitrary constants.

# %% [markdown]
# The initial conditions must now be for $y(x)$ and $y'(x)$.  If we have
# $$
# \begin{align*}
# y(10) &= 2, \\
# y'(10) &= 1,
# \end{align*}
# $$
#
# then:

# %%
desolve(de, y, ics=[10, 2, 1])

# %% [markdown]
# Let's double check:

# %%
f = desolve(de, y, ics=[10, 2, 1])
f(x=10), derivative(f, x)(x=10)

# %% [markdown]
# ## Calling other Programs
#
# Sage comes with and allow you to use other programs within the notebooks.  You must use "magic commands".
#
#
# Here is [GP/Pari](https://pari.math.u-bordeaux.fr/), a good program for Number Theory, which comes with Sage:

# %% jupyter={"outputs_hidden": false}
# %%gp
isprime(101)

# %% [markdown]
# (Note the different syntax and output!  It uses `1` for `True` and `0` for `False`.)

# %% [markdown]
# **If you have it installed in your computer** (like me), you can also call [Magma](http://magma.maths.usyd.edu.au/magma/), which is a very good (but expensive) Number Theory software:

# %% jupyter={"outputs_hidden": false}
# %%magma
IsPrime(101)

# %% [markdown]
# You can render HTML:

# %% jupyter={"outputs_hidden": false} language="html"
# We <b>can</b> use <em>HTML</em> to print text!

# %% [markdown]
# You can call pure Python:

# %% jupyter={"outputs_hidden": false} language="python3"
# print(2/3)

# %% [markdown]
# You can run a *shell command*.  For instance, this list the files ending with ``.ipynb`` (Jupyter notebooks) in the directory I'm running Sage:

# %% jupyter={"outputs_hidden": false}
%%!
ls  *.ipynb

# %% [markdown]
# There are also many other [builtin magics](https://ipython.readthedocs.io/en/stable/interactive/magics.html).
