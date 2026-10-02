---
layout: page
title: Lecture 1
collection: autumn2026lectures
---

# DATA 598B: The shell

## File systems

Let's start at the beginning. The data on your computer is stored in what we call a "file system". A file system is composed of "directories" or "folders", each of which contain other directories or individual "files", which contain data. This file system is actually a tree.

                          / (root)
                             |
               -----------------------------
              |              |              |
         Applications      System         Users
              |              |              |
             ...            ...     ---------------
                                   |               |
                           melissawinstanley     alice
                                   |               |
                             ------------         ...
                            |            |
                        Documents    Downloads
                            |            |
                        ---------       ...
                       |         |
                      foo       bar.txt

A "path" is a route from the root to a file or directory.

We can refer to things in the file system either by their "absolute path" or their "relative path".

* The "absolute path" lists every directory that exists between a file and the root. For instance, in the prior example, the absolute path of bar.txt would be
    ```
    /Users/melissawinstanley/Documents/bar.txt
    ```
* The "relative path" says that, relative to the current directory that we're looking at, what is the path the the file? For instance, if we are currently in the "melissawinstanley" folder, then the path to bar.txt is only the part that occurs after melissawinstanley in the file tree.
    ```
    Documents/bar.txt
    ```

## What you're used to

Typically, when we're using a computer, we use a graphical user interface or "GUI" to accomplish tasks. For instance, when I start up my computer, I see a text box that I click on and enter my password, then see a "desktop" that displays many buttons for different applications. If I want to view a text file on my Mac, I click on a button that launches an application called Finder. Finder displays a list of all the folders and files on my computer, and I can click through to change folders and double click to open a file in another application called TextEdit. I can then modify the file and save it by clicking on the menu bar and then on the "Save" option. I can copy a file by right clicking on its name and selecting the "copy" option, or I can click, hold, and drag the file to move it someplace else. I can delete the file by right clicking on it, or by clicking and dragging it to the "trash can".

## A textual alternative

In this class, we're going to translate these operations from a graphical user interface to a textual user interface. Instead of clicking on things, we'll use the keyboard to get around.

Let's try it. In order to do this, we use a graphical application called a "terminal". To get to text-world, we open up the Terminal (in Windows, make sure you're using WSL).

Now where are we? What do we see? We are running a program called a "shell" on your computer. The "shell" takes text that you type ("commands") and executes the programs that correspond with those commands. All of the "commands" that we are about to talk about are actually little programs that do things.

"Click on Finder button to display files" becomes

```sh
$ pwd
/Users/melissawinstanley/Documents/uwcse/data513/lectures/01
$ ls
books   jokes   test.txt
```

Here, "pwd" stands for "present working directory", and it launches a computer program that displays the path to the current directory, where you are. We are in a folder called "Users" and a subfolder called "melissawinstanley" (which is what we call my "home directory", just like your user's directory in Mac or Windows), etc etc down to a folder called "01". "ls" stands for "list segments", and it lists all the files and folders within the present working directory. In this case, there is a folder called "books" and a folder called "jokes" and a file called "test.txt" in the current directory.

You can also provide arguments to a shell commend. You can add a folder after "ls" if you want to see the files inside a sub-folder. If there is a folder named "books" in the present working directory, you can do

```sh
$ ls books
AnnaKarenina.txt        Dracula.txt
```

"Double clicking on a folder to view the files in that folder" becomes

```sh
$ cd books
$ pwd
/Users/melissawinstanley/Documents/uwcse/data513/lectures/01/books
```

Here, "cd" stands for "change directory", and we move from the current directory to a child directory called "books". Note that here we've used the "relative path" for the child directory books - since we are currently in the directory /Users/melissawinstanley, we can provide the name of "books" relative to that directory, which is just "books". We could also have done this same thing with the "absolute path" of books.

```sh
$ cd /Users/melissawinstanley/Documents/uwcse/data513/lectures/01/books
```

How could I get back to the original directory? By providing the name of that directory.

```sh
$ cd /Users/melissawinstanley/Documents/uwcse/data513/lectures/01
```

"View the contents of a file" becomes

```sh
$ cat test.txt
This is an example text file.
```

"cat" is a command that displays the stuff that is stored in a file.

"Copy a file" becomes

```sh
$ cp test.txt test2.txt
$ cat test2.txt
This is an example text file.
```

"cp" stands for "copy" and it copies the first file (test.txt) and names the copy the second file name provided (test2.txt). Now if we "cat" the new file, we see that it contains exactly the same text as the original file.

"Drag and drop a file to move it" becomes

```sh
$ mv test2.txt test3.txt
$ cat test2.txt
cat: test2.txt: No such file or directory
$ cat test3.txt
This is an example text file.
```

"mv" stands for "move", and it moves the file to the new name and location. It removes the old file, as we can see when we try to "cat" it (it no longer exists).

"Remove a file by right-clicking and selecting delete" becomes

```sh
$ rm test3.txt
$ cat test3.txt
cat: test3.txt: No such file or directory
```

"rm" stands for "remove", and it deletes the file. It's important to note that for both mv and rm, there is NO undo. You can't undo this by dragging a file from the Trash back to the desktop - so be careful what you're doing.

## Why text?

OK, so why would we actually want this? Isn't a GUI a much better option?

* Power users can go faster in a text-based world
    * Using a mouse is actually slower for many things than just typing
* Low bandwidth (good for remote operation)
    * We're using a "remote machine" - for example, a Google engineer has a dedicated computer in a data center
    * All interactions with that machine must go over WiFi
    * A GUI is complicated - if we send all information about the GUI over WiFi, things can be really slow
    * Text is cheap to send back and forth over the network - so it's faster
* Users who want easy logging
    * We can easily see what went wrong (for example, "no such file or directory")
* Users who want programmability (scripting!)
    * This will be the core of the first assignments

Most computer scientists use a combination of GUIs and shells, depending what they’re doing.

## Getting help

So far we've seen a bunch of simple commands that help us navigate and examine the file system (ls, cd, cat, cp, mv, rm). But now I want to do something more complicated: I want to list not just the contents of the current directory (which I could do with "ls") but also the time at which each file was last modified. This was something easy to see in the GUI world: the Finder showed times next to the name of each file. How will we figure out how to do this?

Linux has a built-in manuals (files containing documentation) that describe the commands and programs that we've been running. We call these "man pages", and we can access them by using the "man" command.

```sh
$ man ls
```

That command gives us a large amount of information about how the "ls" command works. We can use the up and down keys to view the whole page (or, as the man page directs at the bottom of the screen, press "h" to learn more about how to navigate a man page). You can press "/" followed by a search command, then enter, to search. The man page lists how to use the ls command: provide the ls command followed by one or more "options" and then the name of a file.

```sh
ls [OPTION]... [FILE]...
```

What is an option? The man page lists those too. Options are usually represented as one or two dashes followed by one or more characters, and they customize the behavior of the command. For example, in the ls man page we can see a description of "The Long Format" which includes file modification time and is controlled with the `-l option`. So to achieve our goal of displaying files with modification time, we can run the following command:

```sh
$ ls -l
```

You can use the "man" command to find out information about other commands, too:

```sh
$ man mv
$ man rm
$ man pwd
```

Man pages are viewable online. Check out the Links section of the course webpage to find a link to the online Linux man pages reference. You can explore the documentation to learn about other commands (check out the intro link). You can also use the Linux pocket guide, if you've bought it, to learn about different commands and tools.

Another way to get help and understand how a command works is to use the `--help` option, when available:

```sh
$ python --help
```

While many buillt-in commands do not use `--help`, most more complicated programs that you run from the command line (like Python, which we will use later in the course) support the --help option. The output from --help is printed to the terminal.

What if you forget all the things that we've discussed today? Well the shell will help you out if you just type "help".

```sh
$ help
```

## Text editor

Now we're at a point where we really need a text editor so we can modify files. There's a lot of different command line text editors and a lot of passionate people who prefer one in particular. I *do not care* which text editor you use. I recommend `nano` for you all. You can read how to install it in the Software section of the course website. My preferred text editor is emacs, but that's often more complicated than beginners need.

## Break: Exercise 1

We'll take a break here and tackle Exercise 1, which will give us experience with a text editor and some of the command line basics that we've seen so far.

## Special characters

In the ls man page, you may have noticed a couple options that refer to . (one dot) and .. (two dots). What do those mean?

There are some "special characters" that you can use in the shell.

    .   # current directory
    ..  # parent directory
    ~   # home directory for your user

We can use these commands to simplify navigating the file system. To navigate up one level, before we had to give the full path of the parent directory:

```sh
# if we are in /Users/melissawinstanley/foo/baz
$ cd /Users/melissawinstanley/foo
```

But now, we can use the .. shortcut to do the same thing:

```sh
$ cd ..  # moves one directory up in the file system
```

Similarly for the home directory:

```sh
$ cd /Users/melissawinstanley # old version
$ cd ~                        # using the special tilde character
```

## Shell history, autocomplete

Typing all these commands is a lot of typing! I thought I said that the shell can be a lot faster than a GUI? There are a few ways to make things faster.

If you start typing a file name, you can use the tab key to autocomplete the file name. For example if I start typing this:

```sh
$ less An
```

and then I hit tab, if there is a file that starts with An in the current directory, it will auto-complete for you.

```sh
$ less AnnaKarenina.txt
```

You can also use the up arrow to get to previous commands (and the down arrow to get back again).

Similarly, the "history" command will list out all the commands that you've used in the past.

```sh
$ history
    1  cd books
    2  ls AnnaKarenina.txt
    3  history
```

(what's that "less" command that I just used? use "man" to find out what it does! there's also a "head" and a "tail" command that might help you out!)

## Filename metacharacters

How else can we do things faster in the shell? The shell is actually not just a simple program that takes a command and executes it. It can also take that command and perform SUBSTITUTIONS in order to avoid having to type file names directly.

For example, the "*" character is a special character. It means "all files in the current directory". So if I am in a directory that contains two sub-folders bar, and baz, then "ls *" will essentially perform "ls bar baz". It will substitute all files into the command.

```sh
$ ls *
bar:
a.txt  b.txt  test2.txt  test.txt

baz:
pun.txt
```

So I lied a bit. "*" actually stands for "zero or more characters". So if you add additionally characters around the star, you can get different results.

```sh
$ ls bar/*
bar/a.txt bar/b.txt bar/test2.txt bar/test.txt
$ ls bar/test*
bar/test2.txt  bar/test.txt
```

The ? character is also special - see if you can figure out what it means using man pages or the internet!

OK, but what if I ACTUALLY want to use the asterisk character, and I don't want to use it in this "zero or more characters" sense? If you actually want am asterisk, you can surround it with quotes ("", or '*'). This is easy to see with the "echo" command, which echos what you give it as input.

```sh
$ echo *
bar baz
$ echo "*"
*
```

## I/O Streams

Each program needs a way to interact with the outside world - a program that is running on the computer but doesn't have a way to get input from you or to show you the result of its computation is not very useful!

We classify the modes of interaction into three categories:

* Input. How does the process get data?
* Output. How does the process show the results of its computation?
* Error. How does the process communicate diagnostic information or things that went wrong?

We call these "I/O streams" for "input" and "output".

Each I/O stream has a default implementation.

* Input: "stdin" - the keyboard
* Output: "stdout" - the screen
* Error: "stderr" - also the screen

## Redirection

What if we don't want to use the default input and output streams? Sometimes we might not want to take input manually from the keyboard, or we might want to save output in a file instead of just printing it to the screen. We call the process of changing the input and output streams of a program "redirection".

You specify redirection of input and output with another set of special characters.

    >     # Output stream to a file   ex. ls foo/ > foo_ls.txt
    2>    # Error stream to a file    ex. ls doesnotexist 2> error.txt
    >>    # Output stream to a file, but append to the file, don't overwrite
    &>    # Output and error streams to the same file
    <     # Input stream from a file  ex. cat < test.txt
    |     # Output stream of the first command equals the input stream of the second command (ie "piping")
          #     ex. cat AnnaKarenina.txt | less
    (and more: 2>>, &>>, <<, <<<, 2>&1)

Redirection is done entirely in the shell - the programs that you are running know nothing about it. All they have is a way to get input and a place to write output.

As an example of redirection, we saw in the previous section that the `echo` command writes the given text to the terminal - `stdout`:

```sh
echo Hello World!
```

We might instead want to write the text to a file. We *could* do this with a text editor, but if we don't want it to be interactive, we can do it with redirection by redirecting the output of `echo` into a file called `hello.txt`:

```sh
echo Hello World! > hello.txt
```

If we perform this command again, we will *overwrite* the file, ie replace it with new content. If instead we want to *append* (add) to the file, we can use the double arrow:

```sh
echo Second line >> hello.txt
```

Piping is a vary powerful idea. It means we don't have to execute commands in isolation - now we can string them together! This takes small, simple commands and creates a more useful output. For example, maybe we want to search for a particular file name in the current directory. We could do this by sending the output of the `ls` command into a search tool, like `grep`:

```sh
ls -lR | grep bird
```

**NOTE:** this is not a great way to search for a file by name. We actually have a specific command for that: `find`.

One particular file on every Linux system that is useful when doing redirection is the file /dev/null. What is this file? Read up on it on your own and figure it out.

## Interacting with the Internet

A data file I want to look at here, as a demonstration, is [a dataset from the City of Seattle's Open Data portal listing all of the city's parks](https://data.seattle.gov/Community-and-Culture/Seattle-Parks-And-Recreation-Park-Addresses/v5tj-kqhc/about_data).

Let's make a new directory called `park_data`. How do we make a new directory? Let's check out our [Unix command cheat sheet on the course website](https://linuxize.com/cheatsheet/linux-commands/).

It turns out there's a command `mkdir` to make a directory:

```sh
$ mkdir park_data
```

Let's move into the directory so we can work within it:

```sh
$ cd park_data
```

Now I want to download the park data. I found it online, but how do I download a file using the terminal? The cheat sheet can help with that too - it shows that there are two options: `wget` and `curl`. I don't have `wget` on my computer, but I can read about `curl`using:

```sh
$ man curl
```

If I just `curl`, it's going to output everything to the terminal:

```sh
$ curl https://data.seattle.gov/resource/v5tj-kqhc.csv
```

But I want to save it in a file! Looking at the man page, we can see that there is a `-o` option that we can use to tell `curl` to put the data in a file:

```sh
$ curl https://data.seattle.gov/resource/v5tj-kqhc.csv -o parks.csv
```

Now I want to examine some of that data. If I `cat` an entire file, it's a bit big. I just want to see some of it. The cheat sheet tells us we can use `head`.

```sh
$ head parks.csv
```

How could we use redirection instead of the `-o` option for the `curl` command, to redirect `curl`'s output to a file? We could also do:

```sh
curl https://data.seattle.gov/resource/v5tj-kqhc.csv > parks.csv
```

Maybe all we need is to see the rows of the park data bit by bit. We can do this by piping the `curl` result to `less` directly:

```sh
$ curl https://data.seattle.gov/resource/v5tj-kqhc.csv | less
```

This takes the output of `curl` - which can be a lot - and `head`s it - all in one line!

## Break: Exercise 2

Exercise 2 will explore the new topics that we've discussed: special characters, metacharacters, redirection, and Internet access.
