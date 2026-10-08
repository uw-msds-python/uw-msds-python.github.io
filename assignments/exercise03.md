---
layout: page
title: Exercise 3
collection: autumn2026assignments
---

# Lecture 2, Exercise 3 - Shell Scripting

This exercise is a follow up to [Exercise 2](<exercise02>) and pertains to [the City of Seattle's pet license data](https://data.seattle.gov/City-Administration/Seattle-Pet-Licenses/jguv-t9rb/about_data), which includes each pet's name, species, breed, and zip code.

Write a shell script called `exercise3.sh` that performs the following operations, in order. Make sure to use *relative paths*, not absolute paths.

1. Download the City of Seattle's pet license data from https://data.seattle.gov/resource/jguv-t9rb.csv using `curl` or `wget` to a file in your **home directory**.

1. Make a new directory called `pet_analysis` in the **current directory**.

1. Move the downloaded file from your home directory to the `pet_analysis` folder.

1. Create a variable called `nice_cat` that contains the text "Luna"

1. Output the lines of the csv file that are for **cats** with the name stored in the `nice_cat` variable. We want to search for BOTH cats AND the name.
    - Hint: cats are identified with the text "Cat" as the species.
    - Hint: You can use the `grep` command to search within a file. `grep` can be very complicated, but for our purposes here, the examples should show you how to do this.

1. Remove the `pet_analysis` directory and csv file (clean up after yourself!).

1. Use the `source` command to run the script.

1. Make sure that the script is executable and that you can run it with the `./exercise3.sh` command.

## Bonus

Bonus questions are not for credit; if you are bored and speed through the previous exercise in rapid time, then the bonus exercises are for you.

1. Scripts can also take arguments - what you provide after the name of the script when you execute it. You can access arguments by numbered variables: the variable `$1` represents the first argument, `$2` represents the second argument, etc. Update your script so that it also takes an argument that represents a zip code, and outputs the number of pets in that zip code. Precisely, the script should be able to be called like:
    ```sh
    $ ./exercise3.sh 98101
    ```
    and it should output (in addition to the cat/dog counting):
    ```
    Pets in zip code 98101:
    29
    ```
