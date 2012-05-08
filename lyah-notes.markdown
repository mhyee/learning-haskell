# 1 Introduction

* Tutorial is aimed for people with imperative programming experience (eg C, C++, Java), but not functional programming experience

* These notes will carry my bias - I have had some experience with programming in Scheme

## What is Haskell?

* Haskell is a purely functional programming language
	* Functions have no side-effects
	* If you call a function multiple times with the same arguments, it will always return the same result
	* Variables are immutable
	* You program by giving the computer functions to evaluate (versus imperative programming, where you give the computer a series of steps to execute)

* Haskell is lazy
	* Haskell only executes functions (and performs calculations) when it needs to
	* This allows for infinite data structures

* Haskell is statically typed, and makes use of type inference

## Running Haskell

* Need a text editor and a compiler (most common one is GHC)

* Easy to get started with the [Haskell Platform](http://hackage.haskell.org/platform/)

* Haskell scripts usually have a `.hs` extension

* GHC can run in an interactive (REPL) mode, with `ghci`
	* Exit with `CTRL+D`
	* Define functions in `foobar.hs`, and load in GHCi by typing `:l foobar`
	* To reload, type `:r`