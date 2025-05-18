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

# Introduction to Python, Sage, and Jupyter Notebooks

+++

We will use some computer tools to learn and deal with cryptography in this course.  Our main software will be [Sage](https://www.sagemath.org/).  On the other hand, Sage is built on top of [Python](https://www.python.org/) (and other math software), with which it shares its syntax.  In fact, you can use virtually any Python tool within Sage.

But before we start our discussion of Sage and Python, we need to talk about [*Jupyter Notebooks*](https://jupyter.org/).

+++

## Jupyter Notebooks

+++

We will use [Jupyter Notebooks](https://jupyter.org/) in this course for our classes, computations, and homework.  In fact, what you are reading now either *is* a Jupyter notebook or was created with one!  If the latter, we recommend you download the corresponding notebook so that you can edit it and test it.  Moreover, the homework from this book is done with Jupyter notebooks, so it is important to familiarize yourself with it.

```{important}

From now on we will continue assuming you are reading the *Jupyter notebook*.  If you are reading the associated generated chapter, you can use it as a reference, but cannot edit it.  Just remember that actions mentioned below, like running or editing cells, refer to the Jupyter notebook.
```

Jupyter notebooks allow us to have formatted text, math formulas, images, and code together in a single document.

+++

### Cells

+++

A notebook is made of cells, which can be a text/Markdown cell, like this one, if you are reading this within Jupyter, or a code cell, like the one below:

```{code-cell} ipython3
print("Hello world!")
```

**Code cells:** Code cells can run code.  The language of the code depends on the [kernel](https://docs.jupyter.org/en/latest/install/kernels.html) used, with Python being the default and most used.  This notebook, though, is meant to be used with a [Sage kernel](https://doc.sagemath.org/html/en/installation/launching.html#setting-up-sagemath-as-a-jupyter-kernel-in-an-existing-jupyter-notebook-or-jupyterlab-installation).  To run the code cell, click on it and press `Shift + Enter/Return`.  You can edit a code cell simply by clicking inside it.

+++

**Text cells:** Text cells are formatted with [Markdown](https://daringfireball.net/projects/markdown/), which provides a quick syntax to format text.  [Markdown Guide](https://www.markdownguide.org/) is one of the many possible references to get started with Markdown.

To edit a text cell, you need to double click on it.  (You will then see the markdown code.)  When done, you run it, like a code cell, with `Shift + Enter/Return`, to format the text.

Note that the notebooks associated to this book use [MyST](https://mystmd.org/), which is an extension of Markdown, providing extra formatting options.  To read these properly within Jupyter, you might need to install [jupyterlab_myst](https://github.com/jupyter-book/jupyterlab-myst).  You can install it with

```
pip install jupyterlab_myst
```

+++

**Switching cell types:** By default new cells are code cells.  To convert to a text cell, you can click on the *Code* drop down box on the of the notebook and select *Markdown*.

Alternatively, you can click on the left of cell and press `m` (lower case `M`).  It will convert it to a text/markdown cell.  Pressing `y` will convert back to a code cell.

+++

**Edit and Command modes:** The *current (or selected) cell* has a blue mark on its left.  And a cell has two modes: *Edit Mode*, and *Command Mode*.  In edit mode, well, you can edit the cell.  You should see the cursor inside the cell and you can start typing in it.

For a code cell, you just need to click inside it to enter edit mode.  For a text cell, you need to double click on it to enter edit mode.

Clicking on the left of a cell will make it enter command mode.  But, if it is a text cell, it will not format the markdown code.  So, you can run it first, and then click on cell itself to select it.

**Keyboard shortcuts:** If you plan to use Jupyter notebooks a lot, I strongly recommend you learn some keyboard shortcuts.  [Chetography](https://cheatography.com/) has a nice [shortcut cheatsheet](https://cheatography.com/weidadeyue/cheat-sheets/jupyter-notebook/).

For instance, *in command mode*, to add a cell above the current one, press `a`.  To add a cell below it, press `b`.

You can press `x`, `c`, and `v` to cut, copy, and paste a cell, respectively.  You can also drag and drop cells (clicking an holding on the left of the cell).

+++

### LaTeX

+++

You can also enter mathematical expressions using [LaTeX](https://www.latex-project.org/).  With a quick search I've found this: [Introduction to LaTeX
for Jupyter notebooks](http://chebe163.caltech.edu/2018w/handouts/intro_to_latex.html), which seems to introduce the basics.

+++

Here is an example of LaTeX (from calculus): we say that if {math}`f(x)` is *differentiable* at $x=a$, if the limit

```{math}
\lim_{x \to a} \frac{f(x) - f(a)}{x-a} = \lim_{\Delta x \to 0} \frac{f(a + \Delta x) -f(a)}{\Delta x}
```

exists.  In the case, the value of the limit is called the *derivative* of $f(x)$ at $x=a$, and usually is denoted by $f'(a)$.

+++

### Tab Completion

+++

Jupyter Lab has *tab completion* for code cells.  This means that if you are typing a variable name or function name in a code cell and then press the key TAB (on the left of the Q key), it will give you the variables/functions that start with the characters you've already typed.

```{code-cell} ipython3
var_1 = 1
var_2 = 2
var_3 = 3
```

```{code-cell} ipython3
# var_  # press TAB
```

```{code-cell} ipython3
# min  # press tab
```

## Basic Python/Sage

+++

This notebook is running Sage, meaning that I've selected the Sage *kernel* to run the code cells by default.  But, unless I explicitly say otherwise, what comes next applies to both Sage and Python.  Again, Sage is built on top of Python, so it is not unlike running Python and loading many math libraries at the start.  Sage provides extra functions and data types that makes it easier to do math out of the box.

Therefore, this introduction serves as an introduction to both Sage and Python!

+++

## Simple Computations

+++

We can use Python/Sage to perform simple mathematical computations.  Its syntax should be mostly familiar.  For example, to compute the product $3 \cdot 4$, we simply type (in a *code cell*):

```{code-cell} ipython3
3 * 4
```

As it is usual, the asterisk `*` is used for product.

+++

We can perform more involved computations.  For instance, to compute
```{math}
3 + \left( \frac{2}{3} - 5 \cdot 7\right),
```
we do:

```{code-cell} ipython3
3 + (2 / 3 - 5 * 7)
```

```{warning} Sage versus Python

 Note that this computation, in Sage, gives us a fraction and not a decimal (usually called a *float* in Python), as in Python.
```


I will run the same computation using (real/plain) Python by starting the cell with `%%python`:

```{code-cell} ipython3
%%python

print(3 + (2 / 3 - 5 * 7))
```

Although I needed the `print` above to see the result (unlike the previous code cell), this cell is running the same computation in *Python*, and the result is a decimal.

Sage's behavior is, as expected, better for mathematics, as we get an exact results and can deal with [rational numbers](https://en.wikipedia.org/wiki/Rational_number) (i.e., fraction of integers).

+++

Note that Sage always gives you a *reduced fraction*, meaning that the numerator and denominator have no common factor.

```{code-cell} ipython3
4 / 6
```

If we want the decimal in Sage, we have a few options.  We can make one of the numbers a float/decimal:

```{code-cell} ipython3
4.0 / 6
```

We cam use the method or function `numerical_approximation`:

```{code-cell} ipython3
(4 / 6).numerical_approx()
```

```{code-cell} ipython3
numerical_approx(4 / 6)
```

Note that the last two have options allow you specify the number of digits in the numerical approximation with the optional argument `digits=`:

```{code-cell} ipython3
numerical_approx(4 / 6, digits=30)
```

```{code-cell} ipython3
(4 / 6).numerical_approx(digits=30)
```

Note that `n` is a shortcut for `numerical_approx`:

```{code-cell} ipython3
n(4 / 6, digits=30)
```

```{code-cell} ipython3
(4 / 6).n(digits=30)
```

The problem for the *function* `n(...)` is that we often use `n` as a variable name, which overwrites the function name!  In that case, we can use `numerical_approx(...)` or the *method* `.n`.

+++

```{warning} Sage versus Python

For *powers* Python uses `**` instead of the more commonly used `^`, which is used by Sage.  (Sage also accepts `**` for powers!)  In Python is used for the logical operator *XOR*, or [*"exclusive or"*](https://en.wikipedia.org/wiki/Exclusive_or).  So, if you use `^` instead of `**` Python will not give an error, but it won't compute what you were expecting!
```

```{code-cell} ipython3
3 ^ 4
```

```{code-cell} ipython3
%%python
print(3 ^ 4)
```

```{code-cell} ipython3
3 ** 4
```

```{code-cell} ipython3
%%python
print(3 ** 4)
```

As in any language, there is a specific syntax we must follow.  For instance:

+++

### Common Operators

Here are some of the most basic operations:


```{table} Common Mathematical Operations
:align: center
:widths: auto
:width: 100 %
:name: tb-operations

| Expression Type         | Operator | Example    | Value     |
|-------------------------|----------|------------|-----------|
| Addition                | `+`      | `2 + 3`    | `5`       |
| Subtraction             | `-`      | `2 - 3`    | `-1`      |
| Multiplication          | `*`      | `2 * 3`    | `6`       |
| Division (Python)       | `/`      | `7 / 3`    | `2.66667` |
| Division (Sage)         | `/`      | `7 / 3`    | `7 / 3`   |
| Integer Division        | `//`     | `7 // 3`   | `2`       |
| Remainder               | `%`      | `7 % 3`    | `1`       |
| Exponentiation (Python) | `**`     | `2 ** 0.5` | `1.41421` |
| Exponentiation (Sage)   | `^`      | `2 ^ 0.5`  | `1.41421` |
```

+++

Python/Sage expressions obey the same familiar rules of *precedence* as in algebra: multiplication and division occur before addition and subtraction. Parentheses can be used to group together smaller expressions within a larger expression.

+++

So, the expression:

```{code-cell} ipython3
1 + 2 * 3 * 4 * 5 / 6^3 + 7 + 8 - 9 + 10
```

represents
```{math}
1 + \left(2 \cdot 3 \cdot 4 \cdot \frac{5}{6^3}\right) + 7 + 8 - 9 + 10 = \frac{158}{9} = 17.5555\ldots,
```
while

```{code-cell} ipython3
1 + 2 * (3 * 4 * 5 / 6)^3 + 7 + 8 - 9 + 10
```

represents
```{math}
1 + 2 \cdot {\left(3 \cdot 4 \cdot \frac{5}{6}\right)}^3 + 7 + 8 - 9 + 10 = 2017.
```

+++

```{note}

Python would give `2017.0` as the answer.
```

```{code-cell} ipython3
%%python
print(1 + 2 * (3 * 4 * 5 / 6) ** 3 + 7 + 8 - 9 + 10)
```

### Some Builtin Functions

Sage comes with most functions needed in mathematics (without having to import other modules, like in Python).

For instance, `abs` (also present in Python) is the absolute value function (i.e, $| \, \cdot \, |$):

```{code-cell} ipython3
abs(-12)
```

Rounding to the nearest integer (also available in Python):

```{code-cell} ipython3
round(5 - 1.3)
```

Maximum function (also available in Python):

```{code-cell} ipython3
max(2, 2 + 3, 4)
```

In this last example, the `max` function is *called* on three *arguments*: 2, 5, and 4. The value of each expression within parentheses is passed to the function, and the function *returns* the final value of the full call expression. The `max` function can take any number of arguments and returns the maximum.

+++

All the above functions were present in (plain) Python.  But Sage has many that are not, for instance, log functions:

```{code-cell} ipython3
log(2)
```

```{warning} Sage versus Python

Here again we see a difference between Sage and Python.  Sage will not automatically evaluate functions when they do not yield "simple" numerical results, but only simplify when possible.  This makes sure that we do not lose precision.
```

We can always the the decimal value/approximation with the `numerical_approx` function:

```{code-cell} ipython3
numerical_approx(log(2))
```

```{code-cell} ipython3
log(2).numerical_approx()
```

To get help on a particular function, you can type its name followed by a question mark `?`:

```{code-cell} ipython3
log?
```

or, you can use `help`:

```{code-cell} ipython3
help(log)
```

or you can press *Shift-TAB* with the cursor after the function's name:

```{code-cell} ipython3
log
```

As the documentation for `log` shows, the base for this log is `e`, meaning that `log` is the [*natural log*](https://en.wikipedia.org/wiki/Natural_logarithm).  But it also shows that we can use different bases.

+++

So, the natural log of $16$, i.e., $\ln(16)$ is given by?:

```{code-cell} ipython3
log(16).numerical_approx()
```

Log base $2$ of $16$, i.e., $\log_2(16)$:

```{code-cell} ipython3
log(16, 2)
```

Note that the result is *exact*!  So, Sage is not using numerical methods to compute the log, it is *simplifying it* without loss of precision.

+++

We could also have done:

+++

Log base $4$ of $16$, i.e, $\log_4(16)$:

```{code-cell} ipython3
log(16, 4)
```

### Getting Help

+++

Besides using `?` at then end, `help(...)`, and pressing Shit+TAB, one can see the [source code](https://en.wikipedia.org/wiki/Source_code) of a function with `??`:

```{code-cell} ipython3
is_prime??
```

### Math Constants

+++

Sage also comes with some constants, like $\pi$ (set to `pi`) and $e$ (set to `e`):

```{code-cell} ipython3
cos(pi / 2)
```

```{code-cell} ipython3
numerical_approx(pi, digits=100)
```

```{code-cell} ipython3
log(e)
```

```{code-cell} ipython3
numerical_approx(e, digits=100)
```

## Variables

+++

We can store values in variables, so that these can be used later.  Here is an example of a computation of a restaurant bill:

```{code-cell} ipython3
subtotal = 30.17
tax_rate = 0.0925
tip_percentage = 0.2

tax = subtotal * tax_rate
tip = subtotal * tip_percentage

total = subtotal + tax + tip

round(total, 2)
```

Note how the variable names make clear what the code does, and allows us to reused it by changing the values of `subtotal`, `tax_rate`, and `tip_percentage`.

+++

Variable names can only have:
* letters (lower and upper case),
* numbers, and
* the underscore `_`.

Moreover, variable names *cannot* start with a number and *should* not start with the underscore (unless you are aware of the [conventions for such variable names](https://peps.python.org/pep-0008/#naming-conventions)).

You should always name your variables with descriptive names to make your code more readable.

You should also try to avoid variable names already used in Python/Sage, as it would override their builtin values.  For instance, names like `print`, `int`, `abs`, `round` are already used in Python/Sage, so you should not used them.

(If the name appears in a green in a code cell in Jupyter, then it is already taken!)

+++

## Comments

We can enter *comments* in code cells to help describe what the code is doing.  Comments are text entered in Python/Sage (e.g., in code cells) that is ignored when running the code, so it is only present to provide information about the code.

Comments in Python start with `#`.  All text after a `#` and in the same line is ignored by the Python/Sage interpreter.  (By convention, we usually leave two spaces between the code and `#` and one space after it.)

As an illustration, here are some comments added to our previous restaurant code:

```{code-cell} ipython3
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
```

Note that the code above probably did not need the comments, as it was already pretty clear.  Although there is such a thing as "too many comments", it is preferable to write too many than too few comments.

+++

## String (Text)

*Strings* is the name for text blocks in Python (and in most programming languages).  To have a text (or string) object in Python, we simply surround it by single quotes `' '` or double quotes `" "`:

```{code-cell} ipython3
'This is some text.'
```

```{code-cell} ipython3
"This is also some text!"
```

If we need quotes inside the string, we need to use the other kind to delimit it:

```{code-cell} ipython3
"There's always time to learn something new."
```

```{code-cell} ipython3
'Descates said: "I think, therefore I am."'
```

What if we need both kinds of quotes in a string?

We can *escape the quote* with a `\` as in:

```{code-cell} ipython3
"It's well know that Descartes has said: \"I think, therefore I am.\""
```

```{code-cell} ipython3
'It\'s well know that Descartes has said: "I think, therefore I am."'
```

Thus, when you repeat the string quote inside of it, put a `\` before it.

Note that you can *always* escape the quotes, even when not necessary.  (It will do no harm.)  In the example below, there was no need to escape the single quote, as seen above:

```{code-cell} ipython3
"It\'s well know that Descartes has said: \"I think, therefore I am.\""
```

Another option is to use *triple quotes*, i.e., to surround the text by either `''' '''` or `""" """` (and then there is no need for escaping):

```{code-cell} ipython3
'''It's well know that Descartes has said: "I think, therefore I am."'''
```

On the other hand, we cannot use `""" """` here because our original string *ends* with a `"`.  If it did not, it would also work.  We can simply add a space:

```{code-cell} ipython3
"""It's well know that Descartes has said: "I think, therefore I am." """
```

Triple quote strings can also contain *multiple lines* (unlike single quote ones):

```{code-cell} ipython3
"""First line.
Second line.

Third line (after a blank line)."""
```

The output seems a bit strange (we have `\n` in place of line breaks --- we will talk about it below), but it *prints* correctly:

```{code-cell} ipython3
multi_line_text = """First line.
Second line.

Third line (after a blank line)."""

print(multi_line_text)
```

### Special Characters

The backslash `\` is used to give special characters.  (Note that it is *not* the forward slash `/` that is used for division!)

Besides producing quotes (as in `\'` and `\"`), it can also produce line breaks, as seen above.

For instance:

```{code-cell} ipython3
multi_line_text = "First line.\nSecond line.\n\nThird line (after a blank line)."

print(multi_line_text)
```

We can also use `\t` for [*tabs*](https://en.wikipedia.org/wiki/Tab_key#Tab_characters): it gives a "stretchable space" which can be convenient to align text:

```{code-cell} ipython3
aligned_text = "1\tA\n22\tBB\n333\tCCC\n4444\tDDDD"

print(aligned_text)
```

We could also use triple quotes to make it more readable:

```{code-cell} ipython3
aligned_text = """
1 \t A
22 \t BB
333 \t CCC
4444 \t DDDD"""

print(aligned_text)
```

Finally, if we need the backslash in our text, we use `\\` (i.e., we also *escape it*):

```{code-cell} ipython3
backslash_test = "The backslash \\ is used for special characters in Python.\nTo use it in a string, we need double backslashes: \\\\."

print(backslash_test)
```

### f-Strings

[f-strings](https://docs.python.org/3/reference/lexical_analysis.html#f-strings) (or *formatted string literals*) are helpful when you want to print variables with a string.

For example:

```{code-cell} ipython3
birth_year = 2008
current_year = 2025

print(f"I was born in {birth_year}, so I am {current_year - birth_year} years old.")
```

So, we need to preface our (single quoted or double quoted) string with `f` and put our expression inside curly braces `{ }`.  It can be a variable (as in `birth_year`) or an expression.

f-strings also allow us to format the expressions inside braces.  (Check the [documentation](https://docs.python.org/3/reference/lexical_analysis.html#f-strings) if you want to learn more.)

+++

### String Manipulation

We can concatenate string with `+`:

```{code-cell} ipython3
name = "Alice"
eye_color = "brown"

name + " has " + eye_color + " eyes."
```

Note that we could have use an f-sting in the example above:

```{code-cell} ipython3
f"{name} has {eye_color} eyes."
```

We also have *methods* to help us manipulate strings.

*Methods* are functions that belong to a particular object type, like strings, integers, and floats.  The syntax is `object.method(arguments)`.  (We had already seen the method `.numerical_approx()` above!)

We can convert to upper case with the `upper` method:

```{code-cell} ipython3
test_string = "abc XYZ 123"
test_string.upper()
```

Similarly, the method `lower` converts to lower case:

```{code-cell} ipython3
test_string.lower()
```

We can also spit a string into a *list* of strings (more about lists below) with `split`:

```{code-cell} ipython3
test_string.split()
```

By default, it splits on spaces, but you can give a different character as an argument to specify the separator:

```{code-cell} ipython3
"abc-XYZ-123".split("-")
```

```{code-cell} ipython3
"abaccaaddd".split("a")
```

## Lists

*Lists* are (ordered) sequences of Python objects.  To create at list, you surround the elements by square brackets `[ ]` and separate them with commas `,`.  For example:

```{code-cell} ipython3
list_of_numbers = [5, 7, 3, 2]

list_of_numbers
```

But lists can have elements of any type:

```{code-cell} ipython3
mixed_list = [0, 1.2, "some string", [1, 2, 3]]

mixed_list
```

We can also have an empty list (to which we can later add elements):

```{code-cell} ipython3
empty_list = []

empty_list
```

### Ranges

+++

We can also create lists of consecutive numbers using `range`.  For instance, to have a list with elements from 0 to 5 we do:

```{code-cell} ipython3
list(range(6))
```

(Technically, `range` gives an object similar to a list, but not quite the same.  Using the function `list` we convert this object to an actual list.  Most often we do *not* need to convert the object to a list in practice, though.)


```{warning}

Note then that `list(range(n))` gives a list `[0, 1, 2, ..., n - 1]`, so it starts at `0` (and not `1`) and ends at `n - 1`, so `n` itself is *not* included!  (This is huge pitfall when first learning with Python!)
```


We can also tell where to start the list (if not at 0), by passing two arguments:

```{code-cell} ipython3
list(range(3, 10))
```

In this case the list start at 3, but ends at 9 (and not 10).

We can also pass a third argument, which is the *step size*:

```{code-cell} ipython3
list(range(4, 20, 3))
```

So, we start at exactly the first argument (4 in this case), skip by the third argument (3 in this case), and stop in the last number *before* the second argument (20 in this case).

+++

```{warning} Sage versus Python

Sage uses a more "flexible" data type for integers than pure Python.  The `range` function gives Python integers.  If we want to obtain Sage integers, we can use `srange` (for Sage range) or `xsrange`.
```


The former, `srange` gives a list, so we do not need the `list` function:

```{code-cell} ipython3
srange(10, 20)
```

The latter,`xsrange`, like range, gives an iterator. (We will discuss iterators when we talk about loops below.)

```{code-cell} ipython3
list(xsrange(10, 20))
```

Note the different date types for the elements:

```{code-cell} ipython3
type(list(range(10, 20))[0])  # data type of first element
```

```{code-cell} ipython3
type(srange(10, 20)[0])  # data type of first element
```

We should use Sage integers when we want to use those for *computations*.  But we can use Python integers (which take less memory) for simple tasks, like indexing or counting.

+++

### Extracting Elements

First, remember our `list_of_numbers` and `mixed_list`:

```{code-cell} ipython3
list_of_numbers
```

```{code-cell} ipython3
mixed_list
```

We can extract elements from a list by position.  But:

```{attention}

Python/Sage count **from 0** and not 1.
```

So, to extract the first element of `list_of_numbers` we do:

```{code-cell} ipython3
list_of_numbers[0]
```

To extract the second:

```{code-cell} ipython3
list_of_numbers[1]
```

We can also count from the end using *negative indices*.  So, to extract the last element we use index `-1`:

```{code-cell} ipython3
mixed_list[-1]
```

The element before last:

```{code-cell} ipython3
mixed_list[-2]
```

To extract the `2` from `[1, 2, 3]` in `mixed_list`:

```{code-cell} ipython3
mixed_list[3][1]
```

(`[1, 2, 3]` is at index `3` of `mixed_list`, and `2` is at index `1` of `[1, 2, 3]`.)

+++

### Slicing

We can get sublists from a list using what is called *slicing*.  For instance, let's start with the list:

```{code-cell} ipython3
list_example = list(range(5, 40, 4))

list_example
```

If I want to get a sublist of `list_example` starting at index 3 and ending at index 6, we do:

```{code-cell} ipython3
list_example[3:7]
```

```{warning}

**Note we used 7 instead of 6!**  Just like with ranges, we stop *before* the second number.
```

If we want to start at the beginning, we can use 0 for the first number, or simply omit it altogether:

```{code-cell} ipython3
list_example[0:5]  # first 5 elements -- does not include index 5
```

```{code-cell} ipython3
list_example[:5]  # same as above
```

Omitting the second number, we go all the way to the end:

```{code-cell} ipython3
list_example[-3:]
```

We can get the length of a list with the function `len`:

```{code-cell} ipython3
len(list_example)
```

So, although wasteful (and not recommended) we could also do:

```{code-cell} ipython3
list_example[4:len(list_example)]  # all elements from index 4 until the end
```

```{note}

Note that the last valid index of the list is `len(list_example) - 1`, and *not* `len(list_example)`, since, again, we start counting from 0 and not 1.
```

+++

We can also give a step size for the third argument, similar to `range`:

```{code-cell} ipython3
new_list = list(range(31))

new_list
```

```{code-cell} ipython3
new_list[4:25:3]  # from index 4 to (at most) 24, with step size of 3
```

### Changing a List

We can also *change elements* in a list.

First, recall our `list_of_numbers`:

```{code-cell} ipython3
list_of_numbers
```

If then, for instance, we want to change the element at index 2 in `list_of_numbers` (originally a 3) to a 10, we can do:

```{code-cell} ipython3
list_of_numbers[2] = 10

list_of_numbers
```

We can add an element to the end of a list using the `append` *method*.  So, to add $-1$ to the end of `list_of_numbers`, we can do:

```{code-cell} ipython3
list_of_numbers.append(-1)

list_of_numbers
```

```{warning}

Note that `append` *changes the original list* and *returns no output*!
```

+++

For instance, note what happens with the following code:

```{code-cell} ipython3
new_list = list_of_numbers.append(100)
new_list
```

No output?  Well, there is *nothing* saved in `new_list`, since `.append` does not give any output.  It did change `list_of_numbers`, though:

```{code-cell} ipython3
list_of_numbers
```

We can sort with the `sort` method:

```{code-cell} ipython3
list_of_numbers.sort()

list_of_numbers
```

(Again, it *changes the list and returns no output*!)

+++

To sort in reverse order, we can use the optional argument `reverse=True`:

```{code-cell} ipython3
list_of_numbers.sort(reverse=True)

list_of_numbers
```

We can reverse the order of elements with the `reverse` method.  (This method does *no sorting at all*, it just reverse the whole list in its given order.)

```{code-cell} ipython3
mixed_list
```

```{code-cell} ipython3
mixed_list.reverse()

mixed_list
```

We can remove elements with the `pop` method.  By default it removes the last element of the list, but you can also pass it the index of the element to removed.

`pop` changes the original list *and* returns the element removed!

```{code-cell} ipython3
list_of_numbers
```

```{code-cell} ipython3
removed_element = list_of_numbers.pop()  # remove last element

removed_element
```

```{code-cell} ipython3
list_of_numbers  # the list was changed!
```

```{code-cell} ipython3
removed_element = list_of_numbers.pop(1)  # remove element at index 1

removed_element
```

```{code-cell} ipython3
list_of_numbers  # again, list has changed!
```

### List and Strings

One can think of strings as (more or less) lists of characters.  (This is not 100% accurate, as we will see, but it is pretty close.)

So, many of the operations we can do with list, we can also do with strings.

For instance, we can use `len` to find the lenght (or number of characters) of a string:

```{code-cell} ipython3
quote = "I think, therefore I am."

len(quote)
```

We can also extract elements by index:

```{code-cell} ipython3
quote[3]  # 4th character
```

And, we can slice a string:

```{code-cell} ipython3
quote[2:20:3]
```

Conversely, just as we could concatenate strings with `+`, we can concatenate lists with `+`:

```{code-cell} ipython3
[1, 2, 3] + [4, 5, 6, 7]
```

```{note}

The crucial difference is that **we cannot change a string** (like we can change a list).
```

If, for instance, you try

```python
quote[3] = "X"
```

you get an error.

+++

Finally, if we have a list of strings, we can join them with the *string* method `join`.  (It is not a *list* method.)  The string in question is used to *separate* the strings in the list.  For instance:

```{code-cell} ipython3
list_of_strings = ["all", "you", "need", "is", "love"]

" ".join(list_of_strings)
```

```{code-cell} ipython3
"---".join(list_of_strings)
```

```{code-cell} ipython3
"".join(list_of_strings)
```

### Multiple Assignments

+++

When we want to assign multiple variable to elements of a list, we can do it directly with:

```{code-cell} ipython3
a, b, c = [1, 2, 3]
print(f"{a = }")  # shortcut for print(f"a = {a}")
print(f"{b = }")
print(f"{c = }")
```

In fact, we can simply do:

```{code-cell} ipython3
a, b, c = 1, 2, 3
print(f"{a = }")
print(f"{b = }")
print(f"{c = }")
```

This gives us a neat trick so exchange values between variables.  Say I want to swap the values of `a` and `b`.  Here is the most common way to this.  (We need a temporary variable!)

```{code-cell} ipython3
print(f"{a = }")
print(f"{b = }")

print("\nNow, switch!\n")

# perform the switch
old_a = a  # store original value of
a = b  # set a to the value of b
b = old_a  # set b to the original value of a

print(f"{a = }")
print(f"{b = }")
```

But in Python/Sage, we can simply do:

```{code-cell} ipython3
print(f"{a = }")
print(f"{b = }")

print("\nNow, switch!\n")

# perform the switch
a, b = b, a  # values on the *right* are the old/original!

print(f"{a = }")
print(f"{b = }")
```

## Dictionaries

*Dictionaries* are used to store data that can be retrieve from a *key*, instead of from position.  (In principle, a dictionary has no order!)  So, to each *key* (which must be unique) we have an associate *value*.

You can think of a real dictionary, where you look up definitions for a word.  In this example the keys are the words, and the values are the definitions.

In Python's dictionaries we have the key/value pairs surrounded by curly braces `{ }` and separated by commas `,`, and the key/value pairs are separated by a colon `:`.

For instance, here is a dictionary with the weekdays in French:

```{code-cell} ipython3
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
```

(Here the keys are the days in English, and to each key the associate value is the corresponding day in French.)


Then, when I want to look up what is Thursday in French, I can do:

```{code-cell} ipython3
french_days["Thursday"]
```

As another example, we can have a dictionary that has all the grades (in a list) o students in a course:

```{code-cell} ipython3
grades = {"Alice": [89, 100, 93], "Bob": [78, 83, 80], "Carl": [85, 92, 100]}

grades
```

To see Bob's grades:

```{code-cell} ipython3
grades["Bob"]
```

To get the grade of Carl's second exam:

```{code-cell} ipython3
grades["Carl"][1]  # note index 1 give the second element!
```

### Adding/Changing Entries

+++

We can also add a pair of key/value to a dictionary.  For instance, to enter Denise's grades, we can do:

```{code-cell} ipython3
grades["Denise"] = [98, 93, 100]

grades
```

We can also change the values:

```{code-cell} ipython3
grades["Bob"] = [80, 85, 77]

grades
```

Or, to change a single grade:

```{code-cell} ipython3
grades["Alice"][2] = 95  # make Alice's 3rd grade a 95

grades
```

We can use `pop` to remove a pair of key/value by passing the corresponding key.  It returns the *value* for the given key and changes the dictionary (by removing the pair):

```{code-cell} ipython3
bobs_grades = grades.pop("Bob")

bobs_grades
```

```{code-cell} ipython3
grades
```

### Membership

+++

The keyword `in` checks if the value is a *key*:

```{code-cell} ipython3
french_days
```

```{code-cell} ipython3
"Monday" in french_days
```

```{code-cell} ipython3
"lundi" in french_days
```

We can test for values with `.values`.

```{warning}

Checking for keys is really fast, but for values is pretty slow (relatively speaking).
```

```{code-cell} ipython3
"lundi" in french_days.values()
```

The key word `in` also works with lists and strings:

```{code-cell} ipython3
some_list = [1, 2, 3, 4]

1 in some_list, 5 in some_list  # should return True, False
```

```{code-cell} ipython3
some_string = "ABCD"

"BC" in some_string, "c" in some_string  # should return True, False
```

Note that the elements in a substring have to appear in the same exact sequence:

```{code-cell} ipython3
"AC" in some_string
```

## Sets

+++

Besides lists and dictionaries, we also have *sets* for collections of elements.  Unlike lists, sets have *no order*.  In fact, a set (in math and in Python/Sage) is characterized by its elements, so repetitions of elements make no difference:

```{math}
\{1, 1, 2, 2, 2 \} = \{2, 1\}.
```

+++

So, a trick to remove repetitions in lists is to convert it to set, and then back to a list:

```{code-cell} ipython3
my_list = [1, 1, 2, 2, 2]
my_list
```

```{code-cell} ipython3
set(my_list)
```

```{code-cell} ipython3
list(set(my_list))
```

As in math, sets are delimited by curly braces $\{ \cdots \}$:

```{code-cell} ipython3
my_set = {1, 2, 3}
my_set
```

```{code-cell} ipython3
my_set == {2, 1, 3, 1, 3, 2, 2}
```

Note that Python/Sage also uses curly braces for dictionaries, so it distinguishes between them by the use of `:`.  The only problem is for empty set and dictionary: `{}` gives an empty *dictionary*:

```{code-cell} ipython3
type({})
```

To create an empty set, usually denoted by $\varnothing$, we use `set()`:

```{code-cell} ipython3
set()
```

### Membership

+++

As expected, we can see if an element is in a set with the keyword `in`:

```{code-cell} ipython3
my_set = {1, 2, 3}
1 in my_set
```

```{code-cell} ipython3
5 in my_set
```

```{note}

Checking if something is in a set is *a lot* faster then checking if something is in a list!  So, whenever we are just keeping track of elements and need to check membership, we should use sets, not lists!
```

+++

### Set Operations

+++

We have the usual set operations:

```{code-cell} ipython3
set_A = {1, 2, 3, 4}
set_B = {3, 4, 5, 6, 7, 8}
```

Union (members of both sets), i.e.,  $A \cup B$:

```{code-cell} ipython3
set_A.union(set_B)
```

```{code-cell} ipython3
set_A | set_B  # same as set_A.union(set_B)
```

Intersection (common elements), i.e., $A \cap B$:

```{code-cell} ipython3
set_A.intersection(set_B)
```

```{code-cell} ipython3
set_A & set_B  # same as set_A.intersection(set_B)
```

Difference (elements in the first, but not in the second), i.e., $A \setminus B$:

```{code-cell} ipython3
set_A.difference(set_B)
```

```{code-cell} ipython3
set_A - set_B  # same as set_A.difference(set_B)
```

We can also check for containment with `<`, `<=`, `>`, `>=`:

```{code-cell} ipython3
{1, 2} < {1, 2, 3}
```

```{code-cell} ipython3
{1, 2, 3} <= {1, 2, 4}
```

We can also add elements to sets:

```{code-cell} ipython3
set_A.add(100)
```

Note that, like `append` for lists, it does not give any output, but *changes* the original set:

```{code-cell} ipython3
set_A
```

We can clear/empty a set with:

```{code-cell} ipython3
set_A.clear()
set_A
```

## Conditionals

### Booleans

Python has two reserved names for true and false: `True` and `False`.

```{attention}

Note that `True` and `False` *must* be capitalized for Python/Sage to recognize them as booleans!  Using `true` and `false` does not work!
```



For instance:

```{code-cell} ipython3
2 < 3
```

```{code-cell} ipython3
2 > 3
```

#### Boolean Operations

One can flip their values with `not`:

```{code-cell} ipython3
not (2 < 3)
```

```{code-cell} ipython3
not (3 < 2)
```

```{code-cell} ipython3
not True
```

```{code-cell} ipython3
not False
```

These can also be combined with `and` and `or`:

```{code-cell} ipython3
(2 < 3) and (4 < 5)
```

```{code-cell} ipython3
(2 < 3) and (4 > 5)
```

```{code-cell} ipython3
(2 < 3) or (4 > 5)
```

```{code-cell} ipython3
(2 > 3) or (4 > 5)
```

```{warning}

Note that `or` is *not exclusive* (as usually in common language).
```

In a restaurant, if an entree comes with "soup or salad", both is *not* an option.  But in math and computer science, `or` allows both possibilities being true:

```{code-cell} ipython3
(2 < 3) or (4 < 5)
```

### Comparisons

We have the following comparison operators:


```{table} Boolean Operations
:align: center
:name: tb-bool_op

| **Operator** | **Description**                   |
|--------------|-----------------------------------|
| `==`         | Equality ($=$)                    |
| `!=`         | Different ($\neq$)                |
| `<`          | Less than ($<$)                   |
| `<=`         | Less than or equal to ($\leq$)    |
| `>`          | Greater than ($>$)                |
| `>=`         | Greater than or equal to ($\geq$) |
```


```{warning}

Note that since we use `=` to assign values to variables, we need `==` for comparisons.  *It's a common mistake to try to use `=` in a comparison, so be careful!*
```

+++

Note that we can use

```python
2 < 3 <= 4
```

as a shortcut for

```python
(2 < 3) and (3 <= 4)
```

```{code-cell} ipython3
2 < 3 <= 4
```

```{code-cell} ipython3
2 < 5 <= 4
```

#### String Comparisons

Note that these can also be used with other objects, such as strings:

```{code-cell} ipython3
"alice" == "alice"
```

```{code-cell} ipython3
"alice" == "bob"
```

It's case sensitive:

```{code-cell} ipython3
"alice" == "Alice"
```

The inequalities follow *dictionary order*:

```{code-cell} ipython3
"aardvark" < "zebra"
```

```{code-cell} ipython3
"giraffe" < "elephant"
```

```{code-cell} ipython3
"car" < "care"
```

But note that capital letters come earlier than all lower case letters:

```{code-cell} ipython3
"Z" < "a"
```

```{code-cell} ipython3
"aardvark" < "Zebra"
```

```{tip}

A common method when we don't care about case in checking for dictionary order, is to use the string method `.lower` for both strings.
```

For instance:

```{code-cell} ipython3
string_1 = "aardvark"
string_2 = "Zebra"

string_1 < string_2  # capitalization has effect!
```

```{code-cell} ipython3
string_1.lower() < string_2.lower()  # capitalization has no effect!
```

### Methods that Return Booleans

We have functions/methods that return booleans.

For instance, to test if a string is made of lower case letters:

```{code-cell} ipython3
test_string = "abc"

test_string.islower()
```

```{code-cell} ipython3
test_string = "aBc"

test_string.islower()
```

```{code-cell} ipython3
test_string = "abc1"

test_string.islower()
```

Here some other methods for strings:

```{table} String Methods
:align: center
:widths: auto
:width: 100 %
:name: tb-string_methods

| **Method**   | **Description**                                  |
|--------------|--------------------------------------------------|
| `is_lower`   | Checks if all letters are lower case             |
| `is_upper`   | Checks if all letters are upper case             |
| `is_alnum`   | Checks if all characters are letters and numbers |
| `is_alpha`   | Checks if all characters are letters             |
| `is_numeric` | Checks if all characters are numbers             |
```

+++

### Membership

As shown above, we can test for membership with the keyword `in`:

```{code-cell} ipython3
2 in [1, 2, 3]
```

```{code-cell} ipython3
5 in [1, 2, 3]
```

```{code-cell} ipython3
1 in [0, [1, 2, 3], 4]
```

```{code-cell} ipython3
[1, 2, 3] in [0, [1, 2, 3], 4]
```

It also work for strings:

```{code-cell} ipython3
"vi" in "evil"
```

```{code-cell} ipython3
"vim" in "evil"
```

Note the the character must appear together:

```{code-cell} ipython3
"abc" in "axbxc"
```

We can also write `not in`.  So

```python
"vim" not in "evil"
```

is the same as

```python
not ("vim" in "evil")
```

```{code-cell} ipython3
"vim" not in "evil"
```

## if-Statements

We can use conditionals to decide what code to run, depending on some condition(s), using *if-statements*:

```{code-cell} ipython3
water_temp = 110  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
```

```{code-cell} ipython3
water_temp = 80  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
```

The syntax is:

```
if <condition>:
    <code to run if condition is true>
```

+++

```{note}

Note the indentation: all code that is indented will run when the condition is true!
```

+++

For example:

```{code-cell} ipython3
water_temp = 110  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
    print("(Temperature above 100.)")
```

Compare it with:

```{code-cell} ipython3
water_temp = 80  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
print("Non-indented code does not depend on the condition!")
```

We can add an `else` statement for code we want to run *only when the condition is false*:

```{code-cell} ipython3
water_temp = 110  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
else:
    print("Water will not boil.")

print("This will always be printed.")
```

```{code-cell} ipython3
water_temp = 80  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
else:
    print("Water will not boil.")

print("This will always be printed.")
```

We can add more conditions with `elif`, which stands for *else if*.

For instance, if we want to check if the water will freeze:

```{code-cell} ipython3
water_temp = 110  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
elif water_temp <= 0:
    print("Water will freeze.")
```

```{code-cell} ipython3
water_temp = -5  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
elif water_temp <= 0:
    print("Water will freeze.")
```

```{code-cell} ipython3
water_temp = 50  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
elif water_temp <= 0:
    print("Water will freeze.")
```

Note that

```python
if water_temp >= 100:
    print("Water will boil.")
elif water_temp <= 0:
    print("Water will freeze.")
```

is the same as

```python
if water_temp >= 100:
    print("Water will boil.")
else:
    if water_temp <= 0:
        print("Water will freeze.")
```

but much better to write (and read)!  And it would have been much worse if we had more `elif`'s!

+++

```{warning}

Also note that if we have overlapping conditions, only the *first* to be met runs!
```

For example:

```{code-cell} ipython3
number = 70

if number > 50:
    print("First condition met.")
elif number > 30:
    print("Second condition met, but not first")
```

```{code-cell} ipython3
number = 40

if number > 50:
    print("First condition met.")
elif number > 30:
    print("Second condition met, but not first")
```

```{code-cell} ipython3
number = 20

if number > 50:
    print("First condition met.")
elif number > 30:
    print("Second condition met, but not first")
```

We can add an `else` *at the end*, which will run when all conditions above it (from the `if` and all `elif`'s) are false:

```{code-cell} ipython3
water_temp = 110  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
elif water_temp <= 0:
    print("Water will freeze.")
else:
    print("Water will neither boil, nor freeze.")
```

```{code-cell} ipython3
water_temp = -5  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
elif water_temp <= 0:
    print("Water will freeze.")
else:
    print("Water will neither boil, nor freeze.")
```

```{code-cell} ipython3
water_temp = 40  # in Celsius

if water_temp >= 100:
    print("Water will boil.")
elif water_temp <= 0:
    print("Water will freeze.")
else:
    print("Water will neither boil, nor freeze.")
```

We can have as many `elif`'s as we need:

```{code-cell} ipython3
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
```

```{code-cell} ipython3
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
```

```{code-cell} ipython3
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
```

```{code-cell} ipython3
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
```

```{code-cell} ipython3
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
```

Note that we could also have used instead

```python
if water_temp >= 100:
    print("Water will boil.")
elif water_temp >= 90:
    print("Water is close to boiling!")
elif water_temp <= 0:
    print("Water will freeze.")
elif water_temp <= 10:
    print("Water is close to freezing!")
else:
    print("Water will neither boil, nor freeze, nor it is close to either.")
```

but *not*

```python
if water_temp >= 100:
    print("Water will boil.")
elif water_temp >= 90:
    print("Water is close to boiling!")
elif water_temp <= 10:
    print("Water is close to freezing!")
elif water_temp <= 0:
    print("Water will freeze.")
else:
    print("Water will neither boil, nor freeze, nor it is close to either.")
```

```{code-cell} ipython3
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
```

## for Loops

We can use *for-loops* for repeating tasks.

Let's show its use with an example.

### Loops with `range`

To print *Beetlejuice* three times we can do:

```{code-cell} ipython3
for i in range(3):
    print("Beetlejuice")
```

The `3` in `range(3)` is the number of repetitions, and the indented block below the `for` line is the code to be repeated.  The `i` is the *loop variable*, but it is not used in this example.  (We will see examples when we do use it soon, though.)

Here `range(3)` can be thought as the list `[0, 1, 2]` (as seen above), and in each of the three times that the loop runs, the loop variable, `i` in this case, receives one of the values in this list *in order*.

Let's illustrate this with another example:

```{code-cell} ipython3
for i in range(3):
    print(f"The value of i is {i}")  # print the value of i
```

So, the code above is equivalent to running:

```{code-cell} ipython3
# first iteration
i = 0
print(f"The value of i is {i}")

# second iteration
i = 1
print(f"The value of i is {i}")

# third iteration
i = 2
print(f"The value of i is {i}")
```

Here the `range` function becomes quite useful (and we should not surround it by `list`!).  For instance, if we want to add all even numbers, between 4 and 200 (both inclusive), we could do:

```{code-cell} ipython3
total = 0  # start with 0 as total

for i in range(2, 201, 2):  # note the 201 instead of 200!
    total = total + i  # replace total by its current value plus the value of i

print(total)  # print the result
```

```{hint}

It's worth observing that `total += i` is a shortcut (and more efficient than) `total = total + i`.
```

So we could have done:

```{code-cell} ipython3
total = 0  # start with 0 as total

for i in range(2, 201, 2):  # note the 201 instead of 200!
    total += i  # replace total by its current value plus the value of i

print(total)  # print the result
```

Let's now create a list with the first $10$ perfect squares:

```{code-cell} ipython3
squares = []  # start with an empty list

for i in range(10):  # i = 0, 1, 2, ... 9
    squares.append(i^2)  # add i^2 to the end of squares

squares
```

### Loops with Lists

One can use any list instead of just `range`.  For instance:

```{code-cell} ipython3
languages = ["Python", "Java", "C", "Rust", "Julia"]

for language in languages:
    print(f"{language} is a programming language.")
```

The code above is equivalent to

```{code-cell} ipython3
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
```

### Loops with Dictionaries

We can also loop over dictionaries.  In this case the loop variable receives the *keys* of the dictionary:

```{code-cell} ipython3
french_days
```

```{code-cell} ipython3
for day in french_days:
    print(f"{day} in French is {french_days[day]}.")
```

We could also have use `french_days.items()` which give *both* the key and value!

```{code-cell} ipython3
for day, french_day in french_days.items():
    print(f"{day} in French is {french_day}.")
```

```{warning}

Although in more recent versions of Python dictionaries keep the order in which the items were added, it is not wise to count on the ordering when looping through dictionaries.
```

+++

### Looping over Sets

+++

We can also iterate over sets, but we cannot know (a priori) the order:

```{code-cell} ipython3
set_B
```

```{code-cell} ipython3
for element in set_B:
    print(f"{element} is in the set")
```

### Loops with Sage Integers

+++

We can loop with Sage integers using `xsrange`:

```{code-cell} ipython3
for x in xsrange(11, 31, 2):
    smallest_prime_factor = prime_divisors(x)[0]
    print(f"The smallest prime factors of {x} is {smallest_prime_factor}.")
```

(We've used the Sage function `prime_divisors` which gives an ordered list of prime divisors of the input.  Then, we take the first (and smallest) element to get the smallest prime divisor.)

+++

```{important}

In loops, we should use `xsrange` instead of `srange`, as the former does not create a list (which has to be stored in memory), but outputs the next Sage integer on-demand.
```

+++

## while Loops

While loops run while some condition is satisfied.  The syntax is

```python
while <condition>:
    <code to be repeated>
```

Let's find the first integer greater than or equal to $1{,}000{,}000$ divisible by $2{,}776$ (in a not very smart way):

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
res = 10^6  # start with 10^6
while (res % 2776) != 0:  # % is for remainder!
    res += 1  # if it is not divisible, try next one
print(res)
```

Another way (which is like the common *until loop*):

```{code-cell} ipython3
res = 10^6
while True:  # runs until we manually stop it
    if res % 2776 == 0:  # test
        break  # found it!  stop the loop
    res += 1  # did not find it.  try the next one
print(res)
```

In this case the loop runs until we manually break out of it with the keyword `break`.

Here, though, is a smarter way (using math, rather than brute force) to accomplish the same:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
# remember that // is the quotient, so the fraction rounded down
2776 * (1000000 // 2776 + 1)
```

Note that `//` give the quotient of the long division.  But note it would not work if the division were exact.  Here is a way when we want to the first divisor *greater than or equal to* $1{,}000{,}000$:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
2776 * ceil(1000000 / 2776)
```

As another example of using `while`, let's add the first $100$ composite (i.e., non-prime) numbers greater than or equal to $20$:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
total = 0  # result
count = 0  # number of composites so far
number = 20  # number to be added if composite
while count < 100:
    if not is_prime(number):  # using Sage's is_prime function!
        total += number
        count += 1
    number += 1  # move to next number
print(total)
```

### List Comprehensions

Python has a shortcut to create lists that we would usually created with a for loop.  It is easier to see how it works with a couple of examples.

Suppose we want to create a list with the first ten positive cubes.  We can start with an empty list and add the cubes in a loop, as so:

```{code-cell} ipython3
# empty list
cubes = []

for i in xsrange(1, 11):
    cubes.append(i^3)

cubes
```

Using *list comprehension*, we can obtain the same list with:

```{code-cell} ipython3
cubes = [i^3 for i in xsrange(1, 11)]

cubes
```

Here is a more complex example.  Suppose we want to create a list of lists like:

```python
[[1],
 [1, 2],
 [1, 2, 3],
 [1, 2, 3, 4],
 [1, 2, 3, 4, 5]]
```

To do that, we need *nested* for loops:

```{code-cell} ipython3
nested_lists = []

for i in range(1, 6):
    inner_list = []
    for j in range(1, i + 1):
        inner_list.append(j)
    nested_lists.append(inner_list)

nested_lists
```

(Note that we could have replaced the inner loop with `inner_list = list(range(1, i + 1)`, but let's keep the loops to illustrate the mechanics of the process of changing from loops to list comprehensions.)

Here is how we can do it using list comprehension:

```{code-cell} ipython3
nested_lists = [[j for j in range(1, i + 1)] for i in range(1, 6)]

nested_lists
```

We can also add *conditions* to when we add an element to our list.  For instance, let's create a list with all positive integers between $1$ and $30$ that are prime (using Sage's `is_prime` function):

```{code-cell} ipython3
[x for x in xsrange(1, 31) if is_prime(x)]
```

That is the same (but easier to write and read) than:

```{code-cell} ipython3
res = []
for x in xsrange(1, 31):
    if is_prime(x):
        res.append(x)
res
```

The notation for list comprehensions are similar to math notation for sets.  For instance, the set

```{math}
:label: eq:set
\{ x \in \{1, 2, \ldots, 31\} \; : \; \text{$x$ is prime} \}
```

is the set

```{math}
\{2, 3, 5, 7, 11, 13, 17, 19, 23, 29\}.
```

```{note}

In math the symbol $\in$ denotes "*in*" or "*belongs to*", and the colon $:$ denotes "*such that*".

So, equation [](#eq:set) above reads as "the set of $x$'s in $\{1, 2, \ldots, 31\}$ such that $x$ is prime".
```

+++

## More on Loops

+++

In most computer languages, when we need to loop over elements of a list, you would have to do something like:

```python
for i in range(len(my_list)):
    print(f"The element is {my_list[i]}")  # get the element from the list
```

As we've seen, in Python/Sage, we can loop over the lists directly:

```python
for element in my_list:
    print(f"The element is {element}")
```

In general it is said that one (almost) never should use

```python
for i in range(len(my_list)):
   ...
```

as there is usually a better way.  Let's some of these.

+++

### Loop with Two Variables

+++

If we have a list with lists of length two as elements, we can loop over each pair:

```{code-cell} ipython3
double_list = [[1, 2], [3, 4], [5, 6]]

for x, y in double_list:
    print(f"x = {x}, y = {y}")
```

### Loop over Multiple Lists

+++

We can loop over two (or more) lists (usually of the same size) at the same time using `zip`:

```{code-cell} ipython3
list_a = [1, 2, 3]
list_b = ["a", "b", "c"]

for x, y in zip(list_a, list_b):
    print(f"x = {x}, y = {y}")
```

### Loop over Element and Index

+++

If we need to have both the element and the index, we can use `enumerate`:

```{code-cell} ipython3
primes_list = [2, 3, 5, 7]

for i, prime in enumerate(primes_list):
    # i: index
    # prime: element
    print(f"The prime {prime} is at index {i}.")
```

## Functions

You are probably familiar with functions in mathematics.  For instance, if $f(x) = x^2$, then $f$ take some number $x$ as its *input* and returns its square $x^2$ as the *output*.  So,

```{math}
\begin{align*}
  f(1) &= 1^2 = 1, && \text{(input: $1$, output: $1$)}; \\
  f(2) &= 2^2 = 4, && \text{(input: $2$, output: $4$)}; \\
  f(3) &= 3^2 = 9, && \text{(input: $3$, output: $9$)}; \\
  f(4) &= 4^2 = 16, && \text{(input: $4$, output: $16$)}.
\end{align*}
```

We can do the same in Python:

```{code-cell} ipython3
def square(x):
    return x ** 2
```

Here is a brief description of the syntax:

* `def` is the keyword that tell Python we are *defining* a function;
* `square` is the name of the function we chose (it has the same requirements as variable names);
* inside the parentheses after the name comes the parameter, or parameters, i.e., the inputs of the function, in this case only `x`;
* indented comes the code that runs when the function is called;
* `return` gives the value that will be returned by the function, i.e., the output.

Now to run, we just use the name with the desired input inside the parentheses:

```{code-cell} ipython3
square(1)
```

```{code-cell} ipython3
square(2)
```

```{code-cell} ipython3
square(3)
```

```{code-cell} ipython3
square(4)
```

It is *strongly recommended* that you add a [*docstring*](https://en.wikipedia.org/wiki/Docstring) describing the function right below its `def` line.  We use triple quotes for that:

```{code-cell} ipython3
def square(x):
    """
    Given a value x, returns its square x ** 2.

    INPUT:
    x: a number.

    OUTPUT:
    The square of the input.
    """
    return x ** 2
```

It does not affect how the function works:

```{code-cell} ipython3
square(3)
```

But it allows whoever reads the code for the function to understand what it does.  (This might be *you* after a few days not working on the code!)

It also allows anyone to get help for the function:

```{code-cell} ipython3
help(square)
```

Functions are like mini-programs.  For instance, remember the code to compute a restaurant bill:

```{code-cell} ipython3
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
```

We can turn it into a function!  We can pass `subtotal`, `tax_rate`, and `tip_percentage` as arguments, and get the total.

Here is how it is done:

```{code-cell} ipython3
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
```

So, `restaurant_bill(25.63, 0.0925, 0.2)` should return the same value as above, `33.13`:

```{code-cell} ipython3
restaurant_bill(25.63, 0.0925, 0.2)
```

But now we can use other values, without having to type all the code again.  For instance, if the boll was $\$30$, tax rate is $8.75\%$, and we tip $18\%$, our bill comes to:

```{code-cell} ipython3
restaurant_bill(30, 0.0875, 0.18)
```

### Default Values

If we the tax rate and tip percentages don't usually change, we can set some default values for them in our function.

For instance, let's assume that the tax rate is usually $9.25\%$ and the tip percentage is $20\%$.  We just set these values in the declaration of the function.  I also change the docstring to reflect the changes, but the rest remains the same.

```{code-cell} ipython3
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
```

Now, every time I use the default values, we can omit them:

```{code-cell} ipython3
restaurant_bill(25.63)
```

But I still can change them!  If I want to give a tip of $22\%$, I can do:

```{code-cell} ipython3
restaurant_bill(25.63, tip_percentage=0.22)
```

And if I am at a different state, where the tax rate is $8.75\%$:

```{code-cell} ipython3
restaurant_bill(25.63, tax_rate=0.0875)
```

And I can alter both, of course:

```{code-cell} ipython3
restaurant_bill(30, tax_rate=0.0875, tip_percentage=0.18)
```

### Lambda (or Nameless) Functions

We can create simple one line functions with a shortcut, using the `lambda` keyword.

For instance, here is how we can create the `square` function from above with:

```{code-cell} ipython3
square = lambda x: x ** 2
```

Here is a description of the syntax:

* `square =` just tells to store the result of the expression following `=` into the variable `square` (as usual).  In this case, the expression gives a *function*.
* `lambda` is the keyword that tells Python we are creating a (lambda) function.
* What comes before the `:` are the arguments of the function (only `x` in this case).
* What comes after the `:` is what the function returns (`x ** 2` in this case).  (It must be a single line, containing what would come after `return` in a regular function.)

Again, except for the docstring, which we *cannot* add with lambda functions, the code is equivalent to what we had before for the `square` function.

```{code-cell} ipython3
square(3)
```

```{code-cell} ipython3
square(4)
```

Here is another example, with two arguments:

```{code-cell} ipython3
average_of_two = lambda x, y: (x + y) / 2
```

```{code-cell} ipython3
average_of_two(3, 7)
```

```{code-cell} ipython3
average_of_two(5, 6)
```

```{note}

The most common use for lambda functions is to create functions that we pass *as arguments to other functions or methods*.
```

In this scenario, we do not need to first create a function with `def`, giving it a name, and then pass this name as the argument of the other function/method.  We can simply create the function *inside the parentheses of the argument of the function*.  Thus, we do not need to name this function in the argument, which is why we sometimes call these lambda functions *nameless*.

Here is an example.  Let's create a list with some random words:

```{code-cell} ipython3
words = ["Luis", "is", "the", "best", "teacher"]
```

We can sort it with `.sort`:

```{code-cell} ipython3
words.sort()
words
```

By default, it sorts alphabetically, but again, because of the capital `L`, `Luis` comes first.  We can deal with that using the `key=` optional argument of sort.  You can pass a *function* to the `key` argument, and then Python/Sage sorts the list based on the output of this function!

So, we can create a function that "lowercases" the words, and then the sorting will not consider cases anymore:

```{code-cell} ipython3
def lower_case(word):
    return word.lower()

words.sort(key=lower_case)  # no parentheses!
words
```

Note that `Luis` is still capitalized, as the function is only used for *comparison* between elements!

So, to see if `best` comes before or after `Luis` (with `key=lower_case`), we test

```python
lower_case("best") < lower_case("Luis")
```
If `True`, `best` does come before `Luis`, if `False`, it comes after.

The elements themselves are not changed.

+++

But note that our function is quite simple and only used for this sorting.  So, instead of creating it with `def`, we can use a lambda function instead!

```{code-cell} ipython3
words = ["Luis", "is", "the", "best", "teacher"]  # reset the list
words.sort(key=lambda word: word.lower())
words
```

Or, if we want to sort words by the *last letter*:

```{code-cell} ipython3
words = ["Luis", "is", "the", "best", "teacher"]  # reset the list
words.sort(key=lambda word: word[-1])
words
```

If we want to sort students in the `grades` dictionary by their score in the second exam:

```{code-cell} ipython3
grades
```

```{code-cell} ipython3
names = list(grades.keys())
names
```

```{code-cell} ipython3
names.sort(key=lambda name: grades[name][1])
names
```

### Typing (Type Annotations)

+++

Python/Sage does not enforce any type (class) declaration, as some functions.  But we can add it do the definition of the function to help the user know the expected types.

Moreover, if your code editor uses a Python [server language protocol](https://en.wikipedia.org/wiki/Language_Server_Protocol) to check your code, then it can show when you are using the wrong type.

+++

As a simple example, consider the function that repeats a given string a certain number of times:

```{code-cell} ipython3
def repeat_string(string, n_repetitions):
    return n_repetitions * string

repeat_string("nom", 3)
```

We can give types for the variables and output like this:

```{code-cell} ipython3
def repeat_string(string: str, n_repetitions: int) -> str:
    return n_repetitions * string
```

These annotations (the `: str`, `: int`, and `-> str`) does not affect the code at all (it is not enforced!):

```{code-cell} ipython3
repeat_string(10, 2)
```

```{code-cell} ipython3
repeat_string("nom", 3)
```

But, it is helpful to someone reading the code, and for some code editors, the line

```python
repeat_string(10, 2)
```

would be highlighted since it was expecting a string for the first argument.

+++

This is not a big deal and I probably won't use it here (as it is more complicated for Sage, and we don't really need it), but you might see this often when reading Python code.

+++

## Some Useful Number Theory Functions

Primality test:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
is_prime(7)
```

Factorization:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
factor(79462756279465971297294612)
```

Next prime after $1{,}000{,}000$:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
next_prime(1_000_000)
```

```{hint}

Note that the `_` between digits of a number are ingonred by Python/Sage.  We can use them to help us see where the decimal commas would be in the number.
```

Note that if the number itself is prime, it still checks for the *next* one:

```{code-cell} ipython3
next_prime(7)
```

List of primes greater than 10 and less than (and *not* equal to) 100:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
prime_range(10, 100)
```

Note that this actually creates the *list*.  To have something like `range`, which is better for iterations, use `primes`:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
primes(100)
```

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
list(primes(100))
```

```{code-cell} ipython3
for p in primes(100):
    print(f"{p} is prime")
```

If you want the first $100$ primes (and not the primes less than $100$) you can do, we can use `Primes()`:

```{code-cell} ipython3
Primes()[0:100]
```

You can think of `Primes()` as the "ordered" set of all primes.

+++

As another example, here is the sum of all primes less than $100$ that when divided by 4 have remainder 1:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
res = 0
for p in primes(100):
    if p % 4 == 1:
        res += p
print(res)
```

Here is an alternative (and better) way, showing the "if" construct inside a list comprehension:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
sum([p for p in primes(100) if p % 4 == 1])
```

This list inside `sum` is constructed similarly to:
```{math}
\{ p \in P \; : \; p \equiv 1 \pmod{4} \}.
```
where $P$ is the set of primes between $2$ and $99$.

+++

We can even drop the braces:

```{code-cell} ipython3
sum(p for p in primes(100) if p % 4 == 1)
```

Here is the sum of the *first* $100$ primes that have remainder $1$ when divided by $4$, using a `while` loop:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
res = 0  # result
count = 0  # number of primes
p = 2  # current prime
while count < 100:
    if p % 4 == 1:
        res += p  # add prime to result
        count += 1  # increase the count
    p = next_prime(p)  # go to next prime
print(res)
```

List of divisors and prime divisors:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
a = 2781276
divisors(a)
```

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
prime_divisors(a)
```

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
factor(a)
```

Note that despite the formatted output, `factor` gives a "list" of prime factors and powers.  This means that `factor` gives a list of pairs, and each pair contains a prime and its corresponding power in the factorization:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
for p, n in factor(100430):  # note the double loop variables!
    print(f"{p}^{n}")
```

```{code-cell} ipython3
factor(100430)
```

Let's find the number of primes less than some given number `a`:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
a = 10_000_000
```

Let's time it as well, by adding `%%time` on top of the code cell:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
%%time
count = 0
for n in xsrange(a):
    if is_prime(n):
        count += 1
print(count)
```

A better way:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
%%time
len(prime_range(a))
```

The problem with this way is that we create a long list `prime_range(a)` (which we must store in memory) and then take its length.  (So, it uses a lot of memory, and little CPU.  The previous one was the opposite.)

+++

Another way, which is faster then the first way (although not as fast as the second) and also uses little memory:

```{code-cell} ipython3
%%time
p = 2
count = 0
while p < a:
    count += 1
    p = next_prime(p)
print(count)
```

This is virtually the same as the one before:

```{code-cell} ipython3
%%time
count = 0
for p in Primes():
    if p >= a:
        break
    count += 1
print(count)
```

Or, the best way, is to use Sage's own `prime_pi`:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
prime_pi?
```

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
%%time
prime_pi(a)
```

*So much faster!*

+++

Let's plot this function, usually denoted by $\pi(x)$, which is the number of primes less than or equal to $x$, from $0$ to $100$.

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
p1 = plot(prime_pi, 0, 100)
show(p1)
```

## Data Types and Parents

+++

We usually use `type` to find the data type of an element in Python:

```{code-cell} ipython3
type(1), type(1.0), type("1")
```

When dealing with numbers and other mathematical objects, a better option is to use `parent`:

```{code-cell} ipython3
parent(1), parent(1.0), parent(1/2)
```

## Integers

There are some aspects of integers in Sage that are worth observing.

Sage has its own integer class/type:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
parent(1)
```

These have properties are useful in mathematics and number theory in particular, when compared to pure Python integers.

On the other hand, Sage also uses at times these Python integers:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
for i in range(1):
    print(parent(i))
```

If you are using these integers as an index or a counter, the Python integers are just fine.  But they lack some of the properties of Sage integers.  For instance, say I want a list of integers from $1$ to $100$ which are perfect squares.  We can try:

```python
[x for x in range(101) if x.is_square()]
```

but we would get an error:

```
AttributeError: 'int' object has no attribute 'is_square'
```

+++

(Note that this corresponds to the set $\{x \in \{0, 1, \ldots, 100\} \; : \; x \text{ is a square.}\}$.)

+++

The problem here is that the Python integer class `int` does not have the `.is_square` method, only the Sage integer class `Integer Ring` (or `sage.rings.integer.Integer`) does.

One solution is to convert the Python integer to a Sage integer:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
ZZ  # a shortcut for the class of Sage integers
```

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
for i in range(1):
    print(parent(ZZ(i)))
```

Again, Sage has its own `srange` and `xsrange` for loops over Sage integers, with the former giving a list and the latter a iterable/generator (better suited for loops!).

+++

So, in practice, it is probably better to use `xsrange` instead of `srange` whenever we do not just need a list:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
[x for x in xsrange(101) if x.is_square()]
```

## Random

Sage has already ``random`` and ``randint``, so there is no need to import Python's ``random`` module.

```{code-cell} ipython3
a = random()  # a float between 0 and 1
a
```

```{code-cell} ipython3
a = randint(2, 20)
a
```

```{warning}

Note that ``randint(x, y)`` is an integer from ``x`` to ``y`` *inclusive*, so ``y`` is a possible output.
```

+++

On the other hand, the function `randrange(x, y)` does give random integers from `x` to `y - 1`, like `range`.

```{code-cell} ipython3
randrange(2, 20)
```

Sage also has ``choice`` (to get a random element from a list), but not ``choices`` (to get more than one element).

```{code-cell} ipython3
v = [1, 10, 11, 14, 17, 23]
a = choice(v)
a
```

If we try

```python
w = choices(v, k=2)
```
we get an error:

```
NameError: name 'choices' is not defined
```

+++

But we can always import it from ``random`` if we need it:

```{code-cell} ipython3
from random import choices
w = choices(v, k=2)  # choose two random elements
w
```

Note that `choices` *can* repeat elements, so it is *"with replacement"*.  If you want *"without replacement"* (so no repeated element), you can use `sample` (already in Sage):

```{code-cell} ipython3
sample(list(range(20)), k=3)
```

## More Math with Sage

+++

Sage (and not Python in general) can do a lot more math!

+++

### Graphing

+++

Let's graph $y = \sin(x)$ for $x$ between $0$ and $3\pi$:

```{code-cell} ipython3
x = var("x")  # we would not need this if we hadn't assigned x a value before
plot(sin(x), (x, 0, 3 * pi))
```

Or $z = \cos(x^2y)$ for $x \in [0, \pi]$, $y \in [0, 2\pi]$:

```{code-cell} ipython3
y = var("y")
plot3d(cos(x^2 * y), (x, 0, pi), (y, 0, 2*pi))
```

### Calculus

+++

We can do calculus.  For instance, let's compute the limit:

```{math}
\lim_{x \to 0} \frac{\sin(2x)}{\tan(3x)}:
```

```{code-cell} ipython3
limit(sin(2*x)/tan(3*x), x=0)
```

We can do derivatives, for instance

```{math}
\frac{\mathrm{d}}{\mathrm{d}x} \frac{\ln(x^2)}{x+1}:
```

```{code-cell} ipython3
derivative(ln(x^2)/(x + 1), x)
```

Sage can even print it nicely:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
derivative(ln(x^2)/(x+1), x)
```

We can do indefinite integrals, for instance,

```{math}
\int \ln(x) \cdot x \; \mathrm{d}x:
```

```{code-cell} ipython3
integral(ln(x)*x, x)
```

Or definite integrals, for instance:

```{math}
\int_{2}^{10} \ln(x) \cdot x \; \mathrm{d}x:
```

```{code-cell} ipython3
integral(ln(x)*x, (x, 2, 10))
```

If we want the numerical approximation:

```{code-cell} ipython3
numerical_approx(_)  # _ uses the last output!
```

When the function is not integrable in elementary terms (no easy anti-derivative) we can use `numerical_integral` to get numerical values for a definite integral.  For instance, for

```{math}
\int_1^2 \mathrm{e}^{x^2} \mathrm{d} x:
```

```{code-cell} ipython3
numerical_integral(exp(x^2), 1, 2)
```

This means that the integral is about $14.989976019600048$ and the error estimated to be about $1.664221651553893 \cdot 10^{-13}$, which means that the previous estimation is correct up to $12$ decimal places!

+++

### Linear Algebra

+++

We can also do linear algebra:

```{code-cell} ipython3
matrix_a = matrix(
    QQ,  # entries in QQ, the rationals
    3,  # 3 by 3
    [-1, 2, 2, 2, 2, -1, 2, -1, 2]  # entries
)

matrix_a
```

```{code-cell} ipython3
parent(matrix_a)
```

We can make Sage print the matrix with "nice" math formatting with `show` (this only work in Jupyter Lab, not in the static book version):

```{code-cell} ipython3
show(matrix_a)
```

If we want the $\LaTeX{}$ code for it:

```{code-cell} ipython3
latex(matrix_a)
```

Let's create another matrix:

```{code-cell} ipython3
matrix_b = matrix(
    QQ,  # entries in QQ, the rationals
    3,  # 3  rows
    4,  # 4 columns
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]  # entries
)
matrix_b
```

We can compute products of matrices:

```{code-cell} ipython3
matrix_a * matrix_b
```

Determinants:

```{code-cell} ipython3
matrix_a.determinant()
```

Inverses:

```{code-cell} ipython3
matrix_a^(-1)
```

Characteristic polynomial:

```{code-cell} ipython3
matrix_a.characteristic_polynomial()
```

Eigenvalues:

```{code-cell} ipython3
matrix_a.eigenvalues()
```

Eigenspaces:

```{code-cell} ipython3
matrix_a.eigenspaces_left()
```

As we can see (if we know/remember Math 251/257), the matrix is diagonalizable:

```{code-cell} ipython3
matrix_a.is_diagonalizable()
```

Here is the diagonal form and the change of bases matrix:

```{code-cell} ipython3
matrix_a.diagonalization()
```

Rank and nullity:

```{code-cell} ipython3
matrix_b.rank()
```

```{code-cell} ipython3
matrix_b.nullity()
```

### Differential Equations

+++

We can also solve differential equations.  For instance, to solve
```{math}
y' + y  = 1
```

(where $y=y(x)$ is a function on $x$ and $y'$ its derivative):

```{code-cell} ipython3
x = var("x")  # x is the variable
y = function("y")(x)  # y is a function on x
desolve(diff(y, x) + y - 1, y)  # find solution(s) y
```

Note that the `_C` is for an arbitrary constant.  If we have initial conditions, say, $y(10) = 2$, we can pass it to `desolve` with `ics` to get an exact solution:

```{code-cell} ipython3
desolve(diff(y, x) + y - 1, y, ics=[10, 2])
```

Note that it simplifies to
```{math}
y(x) = \mathrm{e}^{10-x} + 1.
```

+++

Here is a second order differential equation, for example:
```{math}
y'' - y = x:
```

+++

Here is a second order differential equation:

```{code-cell} ipython3
x = var("x")
y = function("y")(x)
de = diff(y, x, 2) - y == x  # the differential equation
desolve(de, y)  # solve it!
```

Here `_K1` and `_K2` are arbitrary constants.

+++

The initial conditions must now be for $y(x)$ and $y'(x)$.  If we have
```{math}
\begin{align*}
y(10) &= 2, \\
y'(10) &= 1,
\end{align*}
```

then:

```{code-cell} ipython3
desolve(de, y, ics=[10, 2, 1])
```

Let's double check:

```{code-cell} ipython3
f = desolve(de, y, ics=[10, 2, 1])
f(x=10), derivative(f, x)(x=10)
```

## Calling other Programs

Sage comes with and allow you to use other programs within the notebooks.  You must use "magic commands".


Here is [GP/Pari](https://pari.math.u-bordeaux.fr/), a good program for Number Theory, which comes with Sage:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
%%gp
isprime(101)
```

(Note the different syntax and output!  It uses `1` for `True` and `0` for `False`.)

+++

**If you have it installed in your computer** (like me), you can also call [Magma](http://magma.maths.usyd.edu.au/magma/), which is a very good (but expensive) Number Theory software:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
%%magma
IsPrime(101)
```

You can render HTML:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
%%html
We <b>can</b> use <em>HTML</em> to print text!
```

You can call pure Python:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
%%python3
print(2/3)
```

You can run a *shell command*.  For instance, this list the files ending with ``.ipynb`` (Jupyter notebooks) in the directory I'm running Sage:

```{code-cell} ipython3
---
jupyter:
  outputs_hidden: false
---
%%!
ls  *.ipynb
```

There are also many other [builtin magics](https://ipython.readthedocs.io/en/stable/interactive/magics.html).
