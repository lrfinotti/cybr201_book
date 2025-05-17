---
jupytext:
  formats: ipynb,sage:percent,md:myst
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

# About this Book

+++

## Introduction

This book is an introduction to the main mathematical and computational ideas in cryptography.  It is heavily based on selected sections of [An Introduction to Mathematical Cryptography](doi:10.1007/978-1-4939-1711-2), by Jeffrey Hoffstein, Jill Pipher, and Joseph H. Silverman, which is an excellent introduction to mathematical cryptography.  In fact, we strongly recommend the more mathematically inclined readers to use that book in addition to (or perhaps even instead of) this present one.  This book does not go nearly as deep in the math, but focus more in computations and applications.  For example, we might just give computational evidence that some mathematical statement is true, rather than giving an actual proof.  We do prove the easier statements, though, and although these could be skipped by the reader with less interest in the mathematics, we urge them to at least try read them, even if only superficially enough to have a general idea of why the statement is true.

This book was written to serve as a text book for [CYBR 201 - Introduction to Cryptography and Data Protection](https://catalog.utk.edu/content.php?filter%5B27%5D=CYBR&filter%5B29%5D=201&filter%5Bkeyword%5D=&filter%5B32%5D=1&filter%5Bcpage%5D=1&cur_cat_oid=54&expand=&navoid=11523&search_database=Filter#) at the [University of Tennessee](https://www.utk.edu/), which the author proposed and developed.


## Goal

The main goal of this book is to introduce the mathematical ideas behind [cryptosystems](https://en.wikipedia.org/wiki/Cryptosystem) and [digital signature](https://en.wikipedia.org/wiki/Digital_signature) methods, but with a very practical and computational approach and with minimal prerequisites in mathematics.  By following this book, the reader should be able to understand the underlying mathematical problems on which the security of cryptosystems and digital signatures are based, and the computational challenges associated to them.

The more mathematically inclined, but with less experience with coding, should realize the difficulties of finding efficient methods for computations of even the most basic mathematical objects.  Finding these methods requires a shift on how we think about mathematical problems.

On the other hand, the more computationally inclined readers, but with less mathematical background, should realize that a good mathematical insight quite often yields much greater gains than any clever coding.

Those who are just starting with both the math and programming at this level hopefully will see the important relation between the two topics in a very practical and concrete application.

This way, we hope that all these groups should benefit from this book.


## Computations

There is a large focus on computations, since the challenges involved in creating and breaking cryptosystems are computational in nature.  Therefore we will focus on computational methods in [Number Theory](https://en.wikipedia.org/wiki/Number_theory), the main mathematical background for the cryptosystems introduced here.  We will discuss many methods and algorithms, but always with a practical goal.

We will not assume any previous background in Number Theory, but we will introduce the needed results as we progress.


## Sage

We will use [Sage](https://www.sagemath.org/) as the main programming language for our examples.  Sage is based on [Python](https://www.python.org/), which is a simple and yet powerful programming language, often taught as a first programming language.  Sage uses the same syntax as Python, so it should be easy for those who already know Python to use Sage, while been a suitable introduction to programming as well.

Sage adds a lot more mathematical functionality to Python out of the box, making the implementation and testing of the methods in this book a lot easier, when compared to plain Python.

As with Python, Sage if free and open source.  It can be installed directly in the users computer or used online with [Cocalc](https://cocalc.com/).

We will not assume that the reader has any previous experience with coding, and introduce the necessary background in the text.  But experience with coding, especially in Python,  would certainly benefit the reader.


## Homework

We suggest the reader complete the corresponding homework assignments available [here](FIXME!).  These implement methods and algorithms described in the text, and therefore are computational (rather than purely mathematical) in nature.  The goal is to reinforce the ideas introduced and allow the reader to experience the difficulties and efficiency differences between different methods.

These are available as [Jupyter Notebooks](https://jupyter.org/) that should be run using Sage as the kernel.  *These notebooks will not work with pure Python!*

Most routines that the reader will implement are available in Sage already, and in fact these will be used to test the reader's code in the homework.  But, again, the goal is not to have the final product/tool, it is to *understand* how these methods work, what they involve, what is the math behind it, and to see in them working in practice.

Hopefully the homework give the reader practice with coding, with a particular care about efficiency.


## Acknowledgments

The book [An Introduction to Mathematical Cryptography](doi:10.1007/978-1-4939-1711-2), by Jeffrey Hoffstein, Jill Pipher, and Joseph H. Silverman, was the main resource for this book, along with class notes from the author on a course based in that book.

This book was written during a semester in which the [College of Emerging and Collaborative Studies](https://cecs.utk.edu/) at the [University of Tennessee](https://www.utk.edu/) reduced the author's teaching load, allowing the writing of this book.  The teaching reduction was given so the author could develop the new course [CYBR 201 - Introduction to Cryptography and Data Protection](https://catalog.utk.edu/content.php?filter%5B27%5D=CYBR&filter%5B29%5D=201&filter%5Bkeyword%5D=&filter%5B32%5D=1&filter%5Bcpage%5D=1&cur_cat_oid=54&expand=&navoid=11523&search_database=Filter#), and although writing the book was not a requirement, the extra time allowed the author to do it.
