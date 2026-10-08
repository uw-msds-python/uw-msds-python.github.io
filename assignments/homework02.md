---
layout: page
title: Homework 2
collection: autumn2026assignments
---

# DATA 598B Homework 2: Git & Shell Scripting
In this assignment, we'll continue to use the 20 Newsgroups dataset as an example. You will extend your solution to Homework 1 into a shell script and practice using git to make incremental changes.

## Prerequisite: Setting Up GitLab 
We will be using GitLab to submit homework and give feedback. GitLab is a web-based git hosting service that is similar to GitHub but hosted locally by the Computer Science Department.

Make sure to follow the steps in [Exercise 4](https://uw-msds-python.github.io/assignments/exercise04) to set up GitLab access from your terminal. You won't be able to do the rest of the assignment without it!

## The Assignment

In this assignment, we'll extend our solution to Homework 1 into a shell script and practice using git to make incremental changes. For each change you make (each step in the homework), you should **commit** the change to the repository before continuing on to the next step. If you realize you made a mistake, that's ok - either update the commit that you've already made ("amend" it) or make an additional commit describing the fixes you made. Extra commits are ok!

We expect you to continue using the command line and a command line text editor for this assignment. If you get stuck in a bad state with git, reach out for help on the discussion board so that you can get help.

1. Clone the git repository from GitLab onto your computer.
1. Create a shell script called `initial.sh` in a new directory called `scripts`. The script should be very basic: it should print "Hello World" to the terminal. Make sure that your script is executable! Commit the new file to the repository.
   * In particular, if you are using Windows, making sure scripts are committed with proper permissions is slightly more complicated due to how Windows permissions interact with git. Check out [this guide](https://www.scivision.dev/git-windows-chmod-executable/) for making files executable with git on Windows. 
1. Update the `initial.sh` script to download and unarchive the 20 newsgroups dataset, using some of the same commands as in Homework 1. Remove the "Hello World". Once you have made these updates, you should commit the updated script to the repository. Precisely, when executed in the *root* of the repository (not the `scripts` directory), the script should:
   * Make a new directory called `data` in the *root* of the repository.
   * Download the original 20 Newsgroups dataset from [http://qwone.com/~jason/20Newsgroups/](http://qwone.com/~jason/20Newsgroups/) into the `data` directory.
   * Open the archive into the `data` directory.
   * Delete the downloaded archive file, keeping only the expanded directory.
1. Update the `initial.sh` script to print some statistics about the dataset - in particular, the number of directories and files in the dataset. The exact output should be
   ```sh
   Downloaded <number1> newsgroup categories and <number2> documents into the data directory
   ```
   Where `<number1>` is the number of directories and `<number2>` is the number of individual newsgroup documents within those directories. Make sure that this output is the ONLY output when you run the script. Once you have made these updates, you should commit the updated script to the repository.
   * Hint: the dataset is called "20 newsgroups", so make sure your numbers agree
1. Whoops! We've realized that `initial.sh` is not a good name for a script that sets up a repository. Rename the script to `setup.sh`. Commit the name change to the repository.
1. Edit this file (`README.md`) to remove all of these instructions and update it to explain what the script does. If you used any resources other than the lecture resources, provided links, or the man pages, explain what you used and how. Commit the updated README to the repository.
   * We have not talked about Markdown format (`.md` files), and you *do not* have to follow Markdown formatting - treat it just like a text file if you like. We will talk about Markdown again in DATA 515; if you want to learn about Markdown before then, visit [this reference guide](https://www.markdownguide.org) for an introduction.

After completing all of these steps, you should have 2 files and at least 5 commits made by you in your repository. **Push** the changes to GitLab.

## Grading

Submit your Homework 2 GitLab repository via Gradescope. When you open the submission pane for Homework 2, click on the "GitLab" link in the bottom right corner and do not upload directly, as shown here:

![GitLabSubmissionButton](https://uw-msds-python.github.io/images/GitLabSubmission.png)

Your assignment will be graded based on:
* whether you included the files specified above (and no others!)
* whether your script accurately performs the requested actions and produces the requested output
* whether your script works on another Unix machine
* whether the solutions your provide are straightforward (ie don't use 5 commands when 1 will do)
* whether you made incremental changes to the repository over multiple commits

## More Context

In data processing applications, the data being used can be very large. Git repositories are good for collaboration and version management, and *can* be used for data files, but storing large data files is not encouraged for a variety of reasons:
   * Git stores the entire history of your repository for *always*, even if it is later modified or removed. This includes all versions of all large data files ever uploaded to the repository.
   * Everyone who clones the repository must download the *entire* history. Note that this is not true of every version control system, but is true of git. If someone just wants to look at or run the code, but not with real data, they will still need to download all of the versions of all of the data files.
   * Git is designed for text-based formats. Data stored in binary formats, especially, requires snapshotting the entire file every time any part of the data is changed.
   * While code often evolves rapidly, data files sometimes do not; git version management can be unnecessary.
   * Large files that *are* changed can bloat the git changelog, causing git to slow down for the entire repository.

Instead, applications will often provide a set of tools and scripts for interacting with the data required by the application. Collaborators will have the choice of whether and when to download the data, and it will not pollute git's repository history.

This also means that if data files are accidentally uploaded to a repository, it's not enough to simply remove them with a second commit, because they are still present in the repository's history. To fix this mistake, we can use a feature of git called "interactive rebase" which will rewrite git's history ([more documentation on git rebase](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History)). Here's an example flow of how to fix it.

```sh
# First, determine how far back you made the bad commit.
# Look at the log of commits
$ git log

# Once you find the bad commit, determine how many commits ago it was.
# If the bad commit was 3 commits ago, for example, we are going to use "3" in
# the following command. This starts an interactive rebase (aka rewriting
# history)
$ git rebase -i HEAD~3

# Now you're in a text editor with a list of commits. Find the commit you want
# to change and change "pick" to "edit". Save and exit. (Alternatively, if you
# wanted to remove the commit entirely, you could use "drop").

# Make any change that you would like - for example, removing data files with
# git rm <file>

# Then amend (update) the current commit with `git commit --amend`:
$ git commit --amend

# Lastly, restore all later commits with:
$ git rebase --continue

# If you get in a bad state, you can always abort the rebase:
$ git rebase --abort
```
