---
layout: page
title: Exercise 2
collection: autumn2026assignments
---

# Lecture 1, Exercise 2 - Command Line Skills

This exercise pertains to [the City of Seattle's pet license data](https://data.seattle.gov/City-Administration/Seattle-Pet-Licenses/jguv-t9rb/about_data), which includes each pet's name, species, breed, and zip code.

We'll use the `script` command to capture your terminal interactions. At any point you can use the command `exit` to stop capturing the terminal interactions. It's ok if you do a lot of `man` lookups and false starts - we just want to see that you're trying. If you don't finish the exercise within our class time, that is fine - just `exit` and submit what you've completed.

Perform the following operations, in order. Make sure to use *relative paths*, not absolute paths.

1. Enter the command `script exercise2.script`. This starts capturing all actions that follow.

1. Download the City of Seattle's pet license data from https://data.seattle.gov/resource/jguv-t9rb.csv using `curl` or `wget` to a file in your **home directory**.

1. Make a new directory called `pet_analysis` in the **current directory**.

1. Copy the downloaded file from your home directory to the `pet_analysis` folder.

1. Remove the downloaded file from your home directory.

    *(Yes, we could have just moved the file instead, but we are practicing different commands)*

1. Search for dogs within the csv file and output any found to the terminal.
    - Hint: dogs are identified with the text "Dog" as the species.
    - Hint: You can use the `grep` command to search within a file. `grep` can be very complicated, but for our purposes here, the first example should show you how to do this.

1. Rename the csv file to `cats.csv`.

1. Output only the 30th line of the file to a file called `30th.txt` in the `pet_analysis` directory.
    - Hint: we didn't talk about this in lecture, but the man page for `head` can help you figure out how to do this.
    - Hint: you'll need to use redirection to put the line into the file.

1. Using the name of the 30th pet, print the text "\<name\> is so fluffy" to the terminal. You can hard-code the name of the 30th pet, you don't have to figure out how to do it programmatically.

1. Stop capturing your terminal interactions by entering the command `exit`. The record of your interactions is now stored in the file `exercise2.script`.

Submit the `exercise2.script` file, along with `exercise1.txt`, via Gradescope ([link to exercise submission on Gradescope](https://www.gradescope.com/courses/1401685/assignments/8780539))`.

## Bonus

Bonus questions are not for credit; if you are bored and speed through the previous exercise in rapid time, then the bonus exercises are for you.

1. The csv file is currently sorted by license grant time, ascending. Sort the file in-place (meaning the file is changed) by *descending* license grant time instead.

1. Print the text "\<name\> is so fluffy" to the terminal but do it in a fun color - try red or yellow.
    - Hint: You can do this with only the commands we've already learned
    - Hint: The bash cheat sheet linked from the course website is your friend.
