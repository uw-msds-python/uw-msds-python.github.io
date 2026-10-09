# DATA 598B: Shell Scripting

In the last lecture, we covered how you use the shell, a program that runs a command-line interface for you to interact with the operating system. We learned a bunch of commands (actually small programs) that you can use to get around and accomplish small tasks. This lecture, we'll take those building blocks and expand upon them.

## What is a shell script?

We can actually write shell "programs" - we'll call them scripts. A shell script is simply a series of commands like what you'd see in the regular Terminal.

In the last lecture, we downloaded a file using `curl` and then examined it. Let's say we want this to be a reproducible set of steps so that we can share with our friends and enable them to access our parks data.

We can put all of those commands together into a file - a script. Just create a new file (`download_parks.sh`) and put all those commands from last lecture one line after another. You'll need to put the following line at the very top of the file:

```sh
#!/bin/bash
```

This indicates that this program is a shell program - the shell should use /bin/bash (which is the shell itself - use the path that works on your system) to execute the commands. Note that the program here could really refer to any program - like Python, for example. The shell will find the program you specified and run it with the contents that follow the first line. (fun fact: the extension at the end of file, `.sh`, doesn't matter!). If you're using zsh, it will look more like `#!/bin/zsh`. If it still doesn't work, you can find the path of your `bash` program using the command `which bash`.

To run a script that you've made, you can issue a command with the name of the script preceeded by `./`:

```sh
$ ./download_parks.sh
```

But what's this? It doesn't work.

```sh
bash: ./download_parks.sh: Permission denied
```

## Permissions

It turns out that each file in the file system also has the concept of "permissions". Who owns the file? Who is permitted to view it? Who is permitted to edit it? For example, if there are multiple users on a computer and I try to see the files in someone else's personal directory, I'm going to get an error, because your user owns it and not me:

```sh
$ cd /Users/someoneelse
-bash: cd: /Users/someoneelse/: Permission denied
```

We can see who owns each file and what they're allowed to do by running the ls command with an extra "-l" option.

```sh
$ ls -l download_parks.sh
-rw-r--r--  1 melissawinstanley  staff   327B Oct  1 15:07 download_parks.sh
```

When we do this, we can see that I "own" each file (that's what the "melissawinstanley" means). We can also see a set of permissions that look like a combination of "drwx" and dashes. What does this mean? Well, the r means "read", w means "write", and x means "execute" (as in "run this file as a program"). And there are permissions for three different categories of people: the owner, the "group" (won't discuss this right now), and everyone. So in the above example, the owner can read or write the file; anyone in the group can read the file; and the general population can read the file. No one can execute (aka run) the file.

If there's a "d" at the front, then the file is actually a directory. In this example, the script is *not* a directory, so it doesn't have a "d".

We need to change the permissions to make it runnable, aka "executable". You can change the permissions on a file by using the command `chmod` (which stands for "change mode"). Look at the man page for `chmod` to learn more. If I want to enable anyone to execute the script, I can say:

```sh
$ chmod a+x download_parks.sh
```

Now we can run the file as expected!

```sh
$ ./download_parks.sh
```

Why can't I do `download_parks.sh` directly, without the `./` at the front? Hint: it has to do with what's called the "PATH" environment variable.

## Shell Variables

If you've ever used a programming language before, you've probably learned about variables, a named memory location where you can store a value. While bash is not as flexible or ergonomic of a programming language as any you've used before, it does actually provide a full set of programming features. We will not be learning the full feature set of bash in this course (loops and conditionals are out of scope, for example), variables are still a useful bash concept for everyone to know about.

You can assign variables in bash with an equals sign, just like in most programming languages, and access them from other commands using the dollar sign "$" followed by the name of the variable:

```sh
$ test_variable=hello
$ echo $test_variable
hello
```

Important gotcha: there must be NO SPACES around the equals sign. The variables are also case-sensitive - `test_variable` is not the same as `TEST_VARIABLE`.

There are a few common variables that you might encounter in your data science work. You can use `echo` to see the value of any of these variables:

* `$PATH` - this variable contains a list of paths, separated by the ":" character, where the shell itself will look for executable programs. If, for example, you enter the command `pwd`, bash has to figure out which program you actually mean to run. It looks through all of the directories specified by the `$PATH` variable and looks in each one for an executable called `pwd` (in this case, in the `/bin` directory). This is why your new `download_parks.sh` script cannot be run without the `./` in the front - the `$PATH` variable does not contain the current directory, and so bash doesn't know how to find the executable. By providing the `./`, you're telling bash that it can find the file in the current directory.
* `$HOME` - stores the path of your home directory
* `$PWD` - stores the path of the present working directory (same as the `pwd` command)
* `$USER` - stores the current logged-in user
* `$SHELL` - stores the path to the actual shell program you are using, like `/bin/bash`
* `$HOSTNAME` - stores the name of your computer
* `$EDITOR` - stores the path of the default text editor, which is used when you do a git commit
* `$PS1` - this variable controls your prompt, as in the text to the left of your cursor when you're in the shell. By changing this variable, you can change the prompt. [See the man page for more information](https://man7.org/linux/man-pages/man1/bash.1.html#PROMPTING)

In addition to basic variables like those above, we can also create variables that store the result of another command. For example, if we have a test file `test.txt` that contains the text "Hello World", then you can create a variable as follows:

```sh
$ hello_var=$(cat test.txt)
$ echo $hello_var
Hello World
```

This is called "command substitution", and it makes bash scripts much more powerful by allowing you to reuse the result of a previous command in more complex ways.

Note that there's a difference between using the variable within quotes (`"$var"`) and directly (`$var`). What is the difference?

```sh
$ hello_var="*  Hello  *"
$ echo $hello_var
books jokes test.txt Hello books jokes test.txt
$ echo "$hello_var"
*  Hello  *
```

Using the variable in quotes (`"$var"`) preserves the text of the variable precisely, including spaces and special characters. Without the quotes, the variable is used as-is directly on the command line. The following two commands are functionally the same in this case:

```sh
$ echo $hello_var
# Interprets * as the filename wildcard, and ignores extra spaces
$ echo *  Hello  *
```

## .bashrc

In your home directory, you can have two special files called `.bashrc` and `.bash_profile`. These are files to customize your bash shell - and they are actually scripts! Now that we know about scripts, we can start to understand what's going on in these files. I showed my `.bash_profile` file.

```bash
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/melissawinstanley/opt/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/melissawinstanley/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/melissawinstanley/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/melissawinstanley/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

eval "$(/opt/homebrew/bin/brew shellenv)"

export EDITOR="/usr/bin/nano"
export PS1='\W$ '
```

We talked about the different elements of the file. There is the stuff that miniconda set up for me. There's some stuff that helps me use "homebrew", a management program that helps me install other programs. And finally, there's a setting for the default text editor to use and setting my prompt (the stuff that you see before each command).

Your `.bashrc` and `.bash_profile` files are loaded on startup (when you start the shell), or whenever the `source` command is run. `source` is a builtin command in bash that says "execute every line as if the user had typed it in directly in the shell". So if you modify your `.bashrc` or `.bash_profile` files, you will need to run `source` in order for it to actually use your changes:

```sh
$ source .bash_profile
```

You can actually run any script this way, including the `download_parks.sh` script that we wrote earlier:

```sh
$ source download_parks.sh
```

I highly recommend that you add at least one customization to your `.bashrc` - set the default text editor!

As for the differences between `.bashrc` and `.bash_profile` - research it if you're interested, but it's not important for this class! `zsh` has similar files in your home directory, if you choose to use `zsh` instead.

## Break: Exercise 3

Exercise 3 will let you practice writing a shell script.
