# cwb.vim 
cwb.vim is very small plug-in for opening files and running commands in the Edinburgh Concurrency Workbench through Vim, as editing inside the program is so unpleasant that the bundled Emacs interactive mode is the official recommended way to use the program.

## Dependencies
The only dependence for the plug-in not including Vim and CWB itself, is the Expect program used for communicating with CWB, as CWB does not accept input directly from the command line.

## Installation
1. Installation
Either copy cwb.vim to your .vim/plugins directory, or install it using a plug-in manager like [vundle](http://github.com/gmarik/vundle)
 or [pathogen.vim](https://github.com/tpope/vim-pathogen).


2. Configuration
After the installation is completed, should a couple of variables be added to your .vimrc, although only the full path to CWB is strictly necessary, the values shown being assigned to the variables are the plug-ins default values.


```
"Path to CWB on your system, must be set for the plug-in to work.
let g:CWBPath = ""

"Path to Expect on your system, must be set if Which or Expect is not part of path on your system.
let g:ExpectPath = system("which expect")

"The command needed to start a terminal emulator and run its first parameter as a command with all
" subsequent paramters passed to this command, for most terminal emulators is it the -e or -x flag.
let g:TerminalCommand = system("which [urxvt, xterm, gnome-terminal, xfce4-terminal, konsole]")

"The buffer used for the output from CWB, the plug-in will reuse the buffer if it allready exists.
let g:CWBOutputBuffer = "__cwb_output__"

```

##Documentation   
The following is a listing of the commands made available by the plug-in and a short description of the functionality they provide. Cwb.vim also provides syntax highlighting for data files with the .cwb extension.

```
"Loads the file in the buffer into CWB and appends the ouput to a right vsplit
OpenInCWB

"Loads the file in the buffer into CWB, and executes an arbitrary command provided by the user 
OpenAndRunCommandInCWB

```
As a special case will calling the command SIM through OpenAndRunCommandInCWB in cwb-vim launch a terminal instead of creating a right split. This is necessary as the command sets CWB in a special interactive simulation mode, and communication interactively with CWB through Expect and updating the right split in Vim at the same time is still an unsolved problem.
 
##License
The plug-in is licensed under the Vim License, a full version of this license should have been bundled with your Vim installation and can be accessed using the :help license command, it can also be found here [vim License](http://vimdoc.sourceforge.net/htmldoc/uganda.html).
