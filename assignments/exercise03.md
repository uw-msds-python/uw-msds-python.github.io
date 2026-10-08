---
layout: page
collection: autumn2026assignments
---

# Exercise 3 - Shell Scripting

This exercise is a follow up to [Exercise 2](<exercise02>) and pertains to [the City of Seattle's pet license data](https://data.seattle.gov/City-Administration/Seattle-Pet-Licenses/jguv-t9rb/about_data), which includes each pet's name, species, breed, and zip code.

Write a shell script called `exercise3.sh` that performs the following operations, in order. Make sure to use *relative paths*, not absolute paths.

1. Download the City of Seattle's pet license data from https://data.seattle.gov/resource/jguv-t9rb.csv using `curl` or `wget` to a file in your **home directory**.

1. Make a new directory called `pet_analysis` in the **current directory**.

1. Move the downloaded file from your home directory to the `pet_analysis` folder.

1. Count the number of cats within the csv file and output the text `There are <number> cats in the dataset`.
    - Hint: cats are identified with the text "Cat" as the species.
    - Hint: You can use the `grep` command to search within a file. `grep` can be very complicated, but for our purposes here, the examples should show you how to do this.
    - Hint: you'll need to use one or more topics we discussed in lecture today.

1. Do the same as the previous question, but for dogs ("Dog" as the species). Try to do this in a DIFFERENT way compared with the previous question (ie use a different set of commands/options and/or a different approach to printing).

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
    There are 20 pets in zip code 98101
    ```
