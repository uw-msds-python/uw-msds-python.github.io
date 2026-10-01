---
layout: page
title: Homework 1
collection: autumn2026assignments
---

# DATA 598B Homework 1: The Command Line

## Context

The 20 Newsgroups data set is a collection of approximately 20,000 newsgroup documents, partitioned (nearly) evenly across 20 different newsgroups. "Newsgroups" are technically distinct from, but functionally similar to, discussion forums on the Internet (but older), and this dataset dates back to the 1990s. The 20 newsgroups collection has become a popular data set for experiments in text applications of machine learning techniques, such as text classification and text clustering.

Throughout this course, you will use the 20 Newsgroups data set to practice using the command line and Python. In this assignment, we'll explore the data set using the command line.

## Instructions

You will produce two files while completing this assignment:

* A file called `hw1.txt` containing a numbered list that, for each item, provides either the command you executed to perform the action or an answer to the question asked. You **must** use a terminal text editor to create and edit this file.
* A file called `hw1.history` that provides a history of the commands that you ran. This demonstrates your ability to use the command line. The final instruction below will show you how to generate this file.

Please perform the following actions. The `hw1.txt` file should contain the numbers 2 to 13 with the command that you ran to perform the action (except for #13, which should have a textual answer).

0. Open a new Terminal window. This will allow us to capture the terminal history.
1. Make a new directory called `hw1`
1. Change directories to that directory
1. Display your current working directory
1. Download the original 20 Newsgroups dataset from [http://qwone.com/~jason/20Newsgroups/](http://qwone.com/~jason/20Newsgroups/), saving the file as `newsgroups.tar.gz`. Make sure that this command is *silent* - it should not produce ANY output to the terminal.
1. Open the archive with `tar`
1. Delete the `newsgroups.tar.gz` file
1. Remove all of the files and directories within the archive that pertain to "talk" topics - those that start with `talk.`
1. Output the total number of files within the remaining newsgroup directories. Hint: you can use the `find` command to enumerate files, and `wc` to count lines.
1. Search within all of the newsgroup files for "Seattle" (case-insensitive) and put the search results into a file called `seattle.txt`.
1. Show the first 30 lines of `sci.crypt/14147` in the terminal.
1. Show the first 5 files in the `sci.crypt` directory.
1. Examine the first few lines of each of the first 5 files with `less` and examine the `From` header. What are the different ways that the email address might be formatted?

Once you are done, generate the `hw1.history` file (containing the commands that you ran) with the following command:
* If you're using bash:
    ```sh
    diff <( history | cut -c 8- ) ~/.bash_history | sed -n 's/^< //pg' > hw1.history
    ```
* If you're using zsh:
    ```sh
    diff <( history 1 | cut -c 8- ) ~/.zsh_history | sed -n 's/^< //pg' > hw1.history
    ```
* If you're using a different shell, post on the discussion board and the instructor will help you identify the proper command for your shell.

*How does this work? Understanding this is not required, but here's an explanation. The shell stores the history of all the commands that you've run in its history file, but that history file is written ("flushed") when the shell exits; history for the current session is only stored in memory. So what we can do is take the current history (minus the command numbers) (`history | cut -c 8-`) and compare it (`diff`) with the history file (`~/.bash_history`). That gives us some added lines and some removed lines, but we only care about the added lines (written since the last history flush), which start with `<`. The `sed` command allows us to print only the lines that start with `<` while also removing the `<` character (`sed -n 's/^< //pg'`). Finally we redirect those lines into the file `hw1.history`.*

## Grading

Submit your `hw1.txt` and `hw1.history` files via Gradescope ([link to Homework 1 submission](https://www.gradescope.com/courses/1401685/assignments/8786855)).

Your assignment will be graded based on:
* whether you submitted both `hw1.txt` and `hw1.history`
* whether the commands you provide in `hw1.txt` accurately perform the requested actions
* whether the solutions your provide are straightforward (ie don't use 5 commands when 1 will do)
* whether you used a terminal text editor 
* whether you used the terminal as part of the assignment
